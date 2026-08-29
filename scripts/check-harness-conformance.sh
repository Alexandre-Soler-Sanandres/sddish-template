#!/usr/bin/env bash
#
# check-harness-conformance.sh
#
# Portable structural guard for the SDD-ish agent harness. Runs from a bare checkout
# of this template repository OR from a repository created from it (GitHub "Use this
# template" or a full clone). Uses only bash, grep, sed, find, sort — no template-
# maintainer-only tooling, no network, no generated indexes.
#
# WHAT THIS IS NOT
# ----------------
# This is a structural check only. It does NOT satisfy or replace:
#   - the agent-performed COR-10-060 rule-ID citation audit,
#   - Improvement validation (IMPR-05-*),
#   - explicit per-Improvement user approval,
#   - human semantic review of any harness change.
# A clean run here means the skeleton is internally consistent, nothing more.
#
# Exit status: 0 = all checks passed, 1 = one or more checks failed, 2 = usage error.

set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || { echo "cannot cd to repo root" >&2; exit 2; }

FAILED=0
CHECKS=0

section() { printf '\n== %s ==\n' "$1"; }
pass()    { CHECKS=$((CHECKS + 1)); printf 'PASS  %s\n' "$1"; }
fail()    { CHECKS=$((CHECKS + 1)); FAILED=1; printf 'FAIL  %s\n' "$1"; }
detail()  { printf '        %s\n' "$1"; }

RULE_RE='[A-Z]{2,6}-[0-9]{2}-[0-9]{3}(-v1)?'

# Harness surfaces that carry rule-ID citations and canonical instructions.
CITE_ROOTS=(agent-harness)
[ -f AGENTS.md ] && CITE_ROOTS+=(AGENTS.md)
[ -f CLAUDE.md ] && CITE_ROOTS+=(CLAUDE.md)
[ -f .github/copilot-instructions.md ] && CITE_ROOTS+=(.github/copilot-instructions.md)
[ -d .claude/skills/harness ] && CITE_ROOTS+=(.claude/skills/harness)
[ -d .agents/skills/harness ] && CITE_ROOTS+=(.agents/skills/harness)
[ -d .github/agents ] && CITE_ROOTS+=(.github/agents)

# ---------------------------------------------------------------------------
section "Rule-ID definitions and citations"
# ---------------------------------------------------------------------------
# Definitions are '## Rules' table rows co-located in each source file, shaped
# '| ID | ... |' with the ID as the whole first cell.
defs_file="$(mktemp)"
grep -rhoE "^\|[[:space:]]*${RULE_RE}[[:space:]]*\|" agent-harness/ 2>/dev/null \
  | grep -oE "${RULE_RE}" | sort > "$defs_file"

dupes="$(uniq -d "$defs_file")"
if [ -n "$dupes" ]; then
  fail "duplicate rule-ID definitions"
  while IFS= read -r d; do [ -n "$d" ] && detail "defined more than once: $d"; done <<< "$dupes"
else
  pass "no duplicate rule-ID definitions ($(sort -u "$defs_file" | grep -c . ) unique IDs)"
fi

defs_uniq="$(mktemp)"
sort -u "$defs_file" > "$defs_uniq"

cites_file="$(mktemp)"
grep -rhoE "\`${RULE_RE}\`" "${CITE_ROOTS[@]}" 2>/dev/null \
  | tr -d '`' | sort -u > "$cites_file"

missing="$(comm -23 "$cites_file" "$defs_uniq")"
if [ -n "$missing" ]; then
  fail "cited rule IDs with no definition"
  while IFS= read -r m; do [ -n "$m" ] && detail "no definition for: $m"; done <<< "$missing"
else
  pass "every cited rule ID resolves to exactly one definition"
fi
rm -f "$defs_file" "$defs_uniq" "$cites_file"

# ---------------------------------------------------------------------------
section "Referenced local paths"
# ---------------------------------------------------------------------------
# Every backtick-quoted agent-harness/....md file mentioned in a harness source file
# must exist. Only .md targets are checked: bare directory tokens are also used in
# prohibition rules (e.g. "MUST NOT create agent-harness/tools/") where non-existence
# is the correct state.
path_fail=0
while IFS= read -r p; do
  [ -z "$p" ] && continue
  [ -f "$p" ] || { fail "referenced file missing: $p"; path_fail=1; }
done < <(grep -rhoE '`agent-harness/[A-Za-z0-9_./-]+\.md`' agent-harness/ 2>/dev/null \
          | tr -d '`' | sort -u)
[ "$path_fail" -eq 0 ] && pass "all backtick-quoted agent-harness/*.md paths in harness sources exist"

# ---------------------------------------------------------------------------
section "Markdown links inside agent-harness/"
# ---------------------------------------------------------------------------
link_fail=0
while IFS= read -r rec; do
  file="${rec%%::*}"
  target="${rec#*::}"
  case "$target" in
    http://*|https://*|mailto:*|\#*) continue ;;
  esac
  target="${target%%#*}"
  [ -z "$target" ] && continue
  resolved="$(cd "$(dirname "$file")" && cd "$(dirname "$target")" 2>/dev/null && pwd)/$(basename "$target")"
  if [ ! -e "$resolved" ]; then
    fail "broken link in ${file#./}: $target"
    link_fail=1
  fi
done < <(grep -rEno '\]\([^) ]+\)' agent-harness/ 2>/dev/null \
          | sed -E 's/^([^:]+):[0-9]+:\]\(/\1::/; s/\)$//')
[ "$link_fail" -eq 0 ] && pass "all relative Markdown links in agent-harness/ resolve"

# ---------------------------------------------------------------------------
section "Entry-point wrapper parity (Codex / Claude / Copilot)"
# ---------------------------------------------------------------------------
wrapper_fail=0
if [ -d .claude/skills/harness ]; then
  for d in .claude/skills/harness/*/; do
    verb="$(basename "$d")"
    claude=".claude/skills/harness/${verb}/SKILL.md"
    codex=".agents/skills/harness/${verb}/SKILL.md"
    copilot=".github/agents/${verb}.agent.md"
    for f in "$claude" "$codex" "$copilot"; do
      if [ ! -f "$f" ]; then
        fail "wrapper missing for '${verb}': $f"
        wrapper_fail=1
      fi
    done
    [ -f "$claude" ] && [ -f "$codex" ] && [ -f "$copilot" ] || continue
    # The 'Follow agent-harness/...' pointer must name the same target file in all three.
    mapfile -t follows < <(
      for f in "$claude" "$codex" "$copilot"; do
        grep -oE 'Follow agent-harness/[A-Za-z0-9_./-]+\.md' "$f" | head -n1
      done | sort -u
    )
    if [ "${#follows[@]}" -ne 1 ]; then
      fail "wrapper '${verb}' points at divergent harness files across layers"
      for x in "${follows[@]}"; do detail "$x"; done
      wrapper_fail=1
    fi
  done
  [ "$wrapper_fail" -eq 0 ] && pass "every harness verb has three parity wrappers with a matching Follow target"
else
  detail "no .claude/skills/harness — wrapper parity check skipped"
fi

# improve-harness must be Review-only (no raw-problem entry).
ih_fail=0
for f in .claude/skills/harness/improve-harness/SKILL.md \
         .agents/skills/harness/improve-harness/SKILL.md \
         .github/agents/improve-harness.agent.md; do
  [ -f "$f" ] || continue
  if grep -qiE 'review or problem|source review or problem' "$f"; then
    fail "improve-harness wrapper still permits raw-problem entry: ${f#./}"
    ih_fail=1
  fi
  grep -qi 'Review' "$f" || { fail "improve-harness wrapper does not name a Review source: ${f#./}"; ih_fail=1; }
done
[ "$ih_fail" -eq 0 ] && pass "improve-harness wrappers are Review-only"

# ---------------------------------------------------------------------------
section "Lifecycle skeleton and status vocabulary"
# ---------------------------------------------------------------------------
skel_fail=0
for d in adrs ideas implementation-plans improvements questions reviews specs tasks transcripts use-cases; do
  [ -d "harness-data/artifacts/$d" ] || { fail "missing lifecycle folder: harness-data/artifacts/$d"; skel_fail=1; }
done
# Legacy Discovery is an optional Extension: its artifact root exists only when enabled.
if [ -f harness-data/HARNESS-PROFILE.yaml ] && grep -qE '^[[:space:]]*legacy_discovery:[[:space:]]*enabled' harness-data/HARNESS-PROFILE.yaml; then
  [ -d harness-data/extensions/legacy-discovery ] || [ -d harness-data/artifacts/legacy ] \
    || { fail "legacy_discovery enabled but no harness-data/extensions/legacy-discovery/ (or bridge) present"; skel_fail=1; }
fi
# v2 uses a single Questions registry file (IMPROVEMENT-0144); the v1 three-file
# split (QUESTIONS-OPEN/RESOLVED/DISCARDED.md) is gone.
if [ -d harness-data/artifacts/questions ]; then
  [ -f harness-data/artifacts/questions/QUESTIONS.md ] \
    || { fail "missing Questions registry file: harness-data/artifacts/questions/QUESTIONS.md"; skel_fail=1; }
fi
for d in proposed accepted; do
  [ -d "harness-data/artifacts/adrs/$d" ] || { fail "missing ADR folder: harness-data/artifacts/adrs/$d"; skel_fail=1; }
done
if [ -d harness-data/artifacts/implementation-plans/approved ]; then
  fail "stale ADR-era folder present: harness-data/artifacts/implementation-plans/approved (canonical is ready/)"
  skel_fail=1
fi
if [ -f harness-data/CATALOG.md ]; then
  if grep -qE 'Plans at status `approved`' harness-data/CATALOG.md; then
    fail "harness-data/CATALOG.md still tracks Plans at 'approved' (canonical is 'ready')"
    skel_fail=1
  fi
fi
[ "$skel_fail" -eq 0 ] && pass "lifecycle folders, Questions registry, and Plan status vocabulary are canonical"

# ---------------------------------------------------------------------------
section "Templates and placeholder hygiene"
# ---------------------------------------------------------------------------
tmpl_fail=0
for f in agent-harness/templates/*.md; do
  [ -f "$f" ] || continue
  # First non-empty line is either YAML frontmatter (lifecycle artifacts) or a top
  # heading (prose scaffolds such as GUIDE-template / PROJECT-PLAYBOOK-template).
  first="$(grep -m1 -E '.' "$f")"
  case "$first" in
    '---'|'# '*) : ;;
    *) fail "template has neither frontmatter nor a top heading: ${f#./}"; tmpl_fail=1 ;;
  esac
done
# Non-template lifecycle artifacts must not carry angle-bracket ALLCAPS placeholders.
ph="$(grep -rlnE '<[A-Z][A-Z0-9_]{2,}>' harness-data/artifacts/ 2>/dev/null || true)"
if [ -n "$ph" ]; then
  fail "unfilled <PLACEHOLDER> tokens in committed artifacts"
  while IFS= read -r x; do [ -n "$x" ] && detail "${x#./}"; done <<< "$ph"
  tmpl_fail=1
fi
[ "$tmpl_fail" -eq 0 ] && pass "templates have frontmatter and committed artifacts carry no placeholders"

# ---------------------------------------------------------------------------
section "Harness evaluation suite"
# ---------------------------------------------------------------------------
eval_fail=0
if [ -d harness-evals ]; then
  [ -x scripts/evaluate-harness.sh ] || { fail "harness evaluation runner is missing or not executable"; eval_fail=1; }
  if [ -x scripts/evaluate-harness.sh ] && ! bash scripts/evaluate-harness.sh --check; then
    fail "harness evaluation suite structure is invalid"
    eval_fail=1
  fi
  [ "$eval_fail" -eq 0 ] && pass "harness evaluation suite is structurally valid"
else
  detail "harness evaluation suite not yet installed"
fi

# ---------------------------------------------------------------------------
printf '\n'
if [ "$FAILED" -eq 0 ]; then
  printf 'OK  %d checks passed\n' "$CHECKS"
  exit 0
fi
printf 'FAILED  see above (%d checks run)\n' "$CHECKS"
exit 1
