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
for d in adrs changes ideas improvements plans questions reviews specs tasks transcripts use-cases; do
  [ -d "harness-data/artifacts/$d" ] || { fail "missing artifact-type root: harness-data/artifacts/$d"; skel_fail=1; }
done
# Legacy Discovery is an optional Extension: its v2 artifact root exists only when enabled.
if [ -f harness-data/HARNESS-PROFILE.yaml ] && grep -qE '^[[:space:]]*legacy_discovery:[[:space:]]*enabled' harness-data/HARNESS-PROFILE.yaml; then
  [ -d harness-data/extensions/legacy-discovery ] \
    || { fail "legacy_discovery enabled but harness-data/extensions/legacy-discovery/ is missing"; skel_fail=1; }
fi
# V2 has one stable type/ID path per artifact; frontmatter status does not select a folder.
# V2 uses a single Questions registry file.
if [ -d harness-data/artifacts/questions ]; then
  [ -f harness-data/artifacts/questions/QUESTIONS.md ] \
    || { fail "missing Questions registry file: harness-data/artifacts/questions/QUESTIONS.md"; skel_fail=1; }
fi
[ "$skel_fail" -eq 0 ] && pass "v2 artifact-type roots and Questions registry are canonical"

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
section "V2 regression guards"
# ---------------------------------------------------------------------------
v2_fail=0
stale_paths="$(grep -rEn 'harness-data/artifacts/(implementation-plans|legacy)/|harness-data/artifacts/(adrs|ideas|improvements|plans|reviews|specs|tasks|transcripts|use-cases)/(active|ready|done|archive|proposed|accepted)/|QUESTIONS-(OPEN|RESOLVED|DISCARDED)\.md' agent-harness README.md 2>/dev/null || true)"
if [ -n "$stale_paths" ]; then
  fail "active surfaces contain retired v1 paths"
  printf '%s\n' "$stale_paths" | while IFS= read -r x; do detail "$x"; done
  v2_fail=1
fi
legacy_fields="$(grep -rEn '^(source|related|entrypoint|entrypoint_type|included_tasks|blocks|next|follow_up|supersedes|superseded_by|derived_[a-z_]+):' agent-harness/templates 2>/dev/null || true)"
if [ -n "$legacy_fields" ]; then
  fail "templates contain retired relationship fields"
  printf '%s\n' "$legacy_fields" | while IFS= read -r x; do detail "$x"; done
  v2_fail=1
fi
legacy_schema_prose="$(grep -rEn '`(source|related|entrypoint|entrypoint_type|included_tasks|blocks|follow_up|superseded_by|derived_[a-z_]+)`' agent-harness 2>/dev/null || true)"
if [ -n "$legacy_schema_prose" ]; then
  fail "active harness prose names retired relationship fields"
  printf '%s\n' "$legacy_schema_prose" | while IFS= read -r x; do detail "$x"; done
  v2_fail=1
fi
retired_statuses="$({
  grep -En '`(captured|clarifying|ready-for-refining|landed)`|status:[[:space:]]*(captured|clarifying|ready-for-refining|landed)' agent-harness/artifact-specs/IDEA.md || true
  grep -En '`(raw|processed|reviewed)`|status:[[:space:]]*(raw|processed|reviewed)' agent-harness/artifact-specs/TRANSCRIPT.md || true
  grep -En 'status[^[:cntrl:]]{0,30}(resolved|discarded)' agent-harness/artifact-specs/REVIEW.md || true
  grep -En 'status[^[:cntrl:]]{0,30}rejected' agent-harness/artifact-specs/ADR.md || true
} 2>/dev/null)"
if [ -n "$retired_statuses" ]; then
  fail "core Artifact Contracts contain retired status vocabulary"
  printf '%s\n' "$retired_statuses" | while IFS= read -r x; do detail "$x"; done
  v2_fail=1
fi
legacy_question_creation="$(grep -rEn 'MUST (use|create).*(Q-<APP>|Q-APPKEY|CSQ-|CSP-)|Create or update.*(CSQ-|CSP-)' agent-harness 2>/dev/null || true)"
if [ -n "$legacy_question_creation" ]; then
  fail "active instructions create retired Question ID families"
  printf '%s\n' "$legacy_question_creation" | while IFS= read -r x; do detail "$x"; done
  v2_fail=1
fi
[ "$v2_fail" -eq 0 ] && pass "active surfaces reject v1 paths, template fields, and Question creation rules"

# ---------------------------------------------------------------------------
section "Generated-view behavior"
# ---------------------------------------------------------------------------
view_fail=0
fixture="$(mktemp -d)"
mkdir -p "$fixture/artifacts/specs" "$fixture/artifacts/tasks" "$fixture/artifacts/plans" \
  "$fixture/extensions/legacy-discovery/findings"
write_record() {
  local path=$1 body=$2
  printf '%s\n' "$body" >"$path"
}
write_record "$fixture/artifacts/specs/SPEC-9001.md" '---
id: SPEC-9001
type: spec
status: ready
title: Fixture spec
source_ids: []
---'
write_record "$fixture/artifacts/tasks/TASK-9001.md" '---
id: TASK-9001
type: task
status: ready
title: Fixture task one
source_ids: [SPEC-9001]
depends_on: [TASK-9002]
allowed_paths: [src/app]
---'
write_record "$fixture/artifacts/tasks/TASK-9002.md" '---
id: TASK-9002
type: task
status: ready
title: Fixture task two
source_ids: [SPEC-9001]
depends_on: [TASK-9001]
allowed_paths: [src]
---'
write_record "$fixture/artifacts/plans/PLAN-9001.md" '---
id: PLAN-9001
type: implementation-plan
status: ready
title: Fixture plan one
source_ids: [SPEC-9001]
included_ids: [TASK-9001]
---'
write_record "$fixture/artifacts/plans/PLAN-9002.md" '---
id: PLAN-9002
type: implementation-plan
status: in-progress
title: Fixture plan two
source_ids: [SPEC-9001]
included_ids: [TASK-9002]
---'
write_record "$fixture/extensions/legacy-discovery/findings/LF-FIX-0001.md" '---
id: LF-FIX-0001
type: legacy-finding
status: reviewed
title: Fixture extension record
---'
write_record "$fixture/HARNESS-PROFILE.yaml" 'extensions:
  legacy_discovery: disabled'

active="$(bash scripts/render-harness-views.sh "$fixture" active-plans)"
conflicts="$(bash scripts/render-harness-views.sh "$fixture" plan-conflicts)"
backlinks="$(bash scripts/render-harness-views.sh "$fixture" backlinks SPEC-9001)"
trace="$(bash scripts/render-harness-views.sh "$fixture" trace TASK-9001)"
disabled="$(bash scripts/render-harness-views.sh "$fixture" --stdout)"
[[ $active == *'PLAN-9001|ready|SPEC-9001|TASK-9001|src/app'* ]] \
  || { fail "active-plans query omitted canonical Plan/Task data"; view_fail=1; }
[[ $conflicts == *'same-source:SPEC-9001'* && ( $conflicts == *'path-overlap:src/app:src'* || $conflicts == *'path-overlap:src:src/app'* ) ]] \
  || { fail "plan-conflicts query missed same-source or ancestor-path overlap"; view_fail=1; }
[[ $backlinks == *'PLAN-9001|source_ids|SPEC-9001'* ]] \
  || { fail "backlinks query omitted a canonical incoming edge"; view_fail=1; }
[[ $trace == *'TASK-9001|depends_on|TASK-9002'* ]] \
  || { fail "trace query omitted a cyclic canonical edge"; view_fail=1; }
[[ $disabled != *'LF-FIX-0001'* ]] \
  || { fail "disabled Extension leaked into generated views"; view_fail=1; }
write_record "$fixture/HARNESS-PROFILE.yaml" 'extensions:
  legacy_discovery: enabled'
enabled="$(bash scripts/render-harness-views.sh "$fixture" --stdout)"
[[ $enabled == *'LF-FIX-0001'* ]] \
  || { fail "enabled Extension was omitted from generated views"; view_fail=1; }
rm -rf "$fixture"
[ "$view_fail" -eq 0 ] && pass "active plans, conflicts, backlinks, trace cycles, and Extension gating behave as specified"

# ---------------------------------------------------------------------------
printf '\n'
if [ "$FAILED" -eq 0 ]; then
  printf 'OK  %d checks passed\n' "$CHECKS"
  exit 0
fi
printf 'FAILED  see above (%d checks run)\n' "$CHECKS"
exit 1
