#!/usr/bin/env bash
set -euo pipefail

root=${1:-harness-data}
artifacts="$root/artifacts"
fail=0
declare -A seen=()

# ---------------------------------------------------------------------------
# Harness source checks (IMPROVEMENT-0146): rules are co-located in each
# source file's "## Rules" section; there is no agent-harness/rules/ tree.
# ---------------------------------------------------------------------------
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ah="$repo/agent-harness"
if [[ -d $ah ]]; then
  # 1. no paired-rules residue
  if [[ -d "$ah/rules" ]]; then
    echo "paired-rules residue: $ah/rules still exists" >&2; fail=1
  fi

  # scan roots: all of agent-harness, root loaders, generated wrapper layers
  mapfile -t src < <(
    { find "$ah" -type f -name '*.md'
      for x in AGENTS.md CLAUDE.md .github/copilot-instructions.md; do [[ -f $repo/$x ]] && echo "$repo/$x"; done
      find "$repo/.claude/skills/harness" "$repo/.agents/skills/harness" "$repo/.github/agents" -type f 2>/dev/null || true
    } | sort -u
  )
  idre='[A-Z]{2,4}-[0-9]{2}-[0-9]{3}(-v1)?'

  # 2. every rule ID defined exactly once (a "definition" = a table row whose
  #    first cell is exactly the ID)
  dup=$(grep -hoE "^\|[[:space:]]*${idre}[[:space:]]*\|" "${src[@]}" 2>/dev/null \
        | grep -oE "$idre" | sort | uniq -d)
  if [[ -n $dup ]]; then
    echo "rule ID defined more than once:" >&2
    printf '  %s\n' $dup >&2
    fail=1
  fi

  # 3. no dangling citations (every cited ID resolves to a definition row)
  defs=$(grep -hoE "^\|[[:space:]]*${idre}[[:space:]]*\|" "${src[@]}" 2>/dev/null | grep -oE "$idre" | sort -u)
  cites=$(grep -hoE "$idre" "${src[@]}" 2>/dev/null | sort -u)
  dangle=$(comm -13 <(printf '%s\n' "$defs") <(printf '%s\n' "$cites"))
  if [[ -n $dangle ]]; then
    echo "dangling rule-ID citations (cited, never defined):" >&2
    printf '  %s\n' $dangle >&2
    fail=1
  fi

  # 4. entry-point manifest completeness: every UNCONDITIONED entrypoints.yaml
  #    entry has all three wrappers, and every wrapper has a manifest entry.
  #    Conditioned entries (`condition: extension:<name>`) may legitimately have
  #    no wrappers when the extension is disabled — check 5 validates those.
  manifest="$ah/entrypoints.yaml"
  if [[ -f $manifest ]]; then
    uncond=$(awk '
      /^[[:space:]]*- name:[[:space:]]/ { name=$3; cond=0 }
      /^[[:space:]]*condition:[[:space:]]*extension:/ { cond=1 }
      /^[[:space:]]*body:[[:space:]]*\|/ { if (name && !cond) print name; name="" }
    ' "$manifest")
    for n in $uncond; do
      [[ -f "$repo/.claude/skills/harness/$n/SKILL.md" ]] || { echo "manifest: missing .claude wrapper for '$n'" >&2; fail=1; }
      [[ -f "$repo/.agents/skills/harness/$n/SKILL.md" ]] || { echo "manifest: missing .agents wrapper for '$n'" >&2; fail=1; }
      [[ -f "$repo/.github/agents/$n.agent.md" ]] || { echo "manifest: missing .github wrapper for '$n'" >&2; fail=1; }
    done
    for d in "$repo"/.claude/skills/harness/*/; do
      [[ -d $d ]] || continue
      n=$(basename "$d")
      grep -qE "^[[:space:]]*- name: $n\$" "$manifest" || { echo "wrapper '$n' has no entrypoints.yaml entry" >&2; fail=1; }
    done
  else
    echo "missing entry-point manifest: $manifest" >&2; fail=1
  fi

  # 5. generated-wrapper cleanliness: the live wrapper layers must equal what
  #    generate-harness-wrappers.sh produces from entrypoints.yaml (catches
  #    hand-edits and manifest drift). Skipped when the generator is absent
  #    (adopter repos that only mirror generated output).
  gen="$repo/scripts/generate-harness-wrappers.sh"
  if [[ -x $gen ]] && command -v python3 >/dev/null 2>&1; then
    tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
    mkdir -p "$tmp/agent-harness"
    cp "$manifest" "$tmp/agent-harness/entrypoints.yaml"
    # carry the project profile so extension-gated entry points resolve the same way
    if [[ -f "$repo/harness-data/HARNESS-PROFILE.yaml" ]]; then
      mkdir -p "$tmp/harness-data"
      cp "$repo/harness-data/HARNESS-PROFILE.yaml" "$tmp/harness-data/HARNESS-PROFILE.yaml"
    fi
    for layer in .claude/skills/harness .agents/skills/harness .github/agents; do
      [[ -e "$repo/$layer" ]] && { mkdir -p "$tmp/$(dirname "$layer")"; cp -r "$repo/$layer" "$tmp/$layer"; }
    done
    if ! "$gen" "$tmp" >/dev/null 2>&1; then
      echo "generate-harness-wrappers.sh failed to run" >&2; fail=1
    else
      for layer in .claude/skills/harness .agents/skills/harness .github/agents; do
        if ! diff -r "$repo/$layer" "$tmp/$layer" >/dev/null 2>&1; then
          echo "wrapper layer $layer is out of sync with agent-harness/entrypoints.yaml — run scripts/generate-harness-wrappers.sh" >&2
          fail=1
        fi
      done
    fi
  fi
fi

profile="$root/HARNESS-PROFILE.yaml"
if [[ -f $profile ]]; then
  if ! awk '
    BEGIN { extensions=0; legacy=0; bad=0 }
    /^[[:space:]]*#/ || /^[[:space:]]*$/ { next }
    /^extensions:[[:space:]]*$/ { if (extensions++) bad=1; next }
    /^  legacy_discovery:[[:space:]]*(enabled|disabled)[[:space:]]*$/ { if (!extensions || legacy++) bad=1; next }
    { bad=1 }
    END { exit bad }
  ' "$profile"; then
    echo "invalid closed profile schema: $profile" >&2
    fail=1
  fi
fi

declare -A paths=(
  [change-spec]=changes [use-case]=use-cases [spec]=specs [task]=tasks
  [implementation-plan]=plans [review]=reviews [harness-improvement]=improvements
  [idea]=ideas [transcript]=transcripts [adr]=adrs
)
declare -A statuses=(
  [change-spec]='draft ready in-progress blocked done rejected archived'
  [use-case]='draft ready in-progress blocked done rejected archived'
  [spec]='draft ready in-progress blocked done rejected archived'
  [task]='draft ready in-progress blocked done rejected archived'
  [implementation-plan]='draft ready in-progress blocked done rejected archived'
  [review]='draft assessed closed archived'
  [harness-improvement]='proposed approved in-progress done rejected archived'
  [idea]='active accepted rejected archived'
  [transcript]='recording recorded archived'
  [adr]='proposed accepted superseded archived'
)

# ---------------------------------------------------------------------------
# Record-level v2 validations. The read-only Legacy Discovery bridge
# (harness-data/artifacts/legacy/, removed by IMPROVEMENT-0150) is governed
# by the extension, not by the core v2 record model — it is skipped here.
# ---------------------------------------------------------------------------
declare -A rec_seen_type=()
declare -A rec_fwd=()
declare -A rec_src=()

while IFS= read -r -d '' file; do
  case "$file" in "$artifacts"/legacy/*) continue ;; esac
  front=$(sed -n '/^---$/,/^---$/p' "$file")
  id=$(printf '%s\n' "$front" | sed -n 's/^id: *//p' | head -1)
  type=$(printf '%s\n' "$front" | sed -n 's/^type: *//p' | head -1)
  status=$(printf '%s\n' "$front" | sed -n 's/^status: *//p' | head -1 | sed 's/[[:space:]]*#.*$//' | xargs)
  [[ -n $id && -n $type && -n $status ]] || { echo "missing v2 frontmatter: $file" >&2; fail=1; continue; }
  [[ -z ${seen[$id]+x} ]] || { echo "duplicate ID: $id" >&2; fail=1; }
  seen[$id]=1
  [[ -n ${paths[$type]+x} ]] || { echo "unknown type '$type': $file" >&2; fail=1; continue; }
  [[ " ${statuses[$type]} " == *" $status "* ]] || { echo "invalid status '$status' for $id" >&2; fail=1; }
  [[ $file == "$artifacts/${paths[$type]}/$id.md" ]] || { echo "unstable path for $id: $file" >&2; fail=1; }

  # (IMPROVEMENT-0149) no v1 reverse-link, renamed, or derived_* frontmatter field
  # survives on a migrated record. Canonical forward links are source_ids /
  # related_adrs / question_refs / included_ids only (OUTPUTS.md).
  bad=$( { printf '%s\n' "$front" | grep -oE '^(source|related|legacy_refs|entrypoint|entrypoint_type|included_tasks|excluded_tasks|blocks|next|follow_up|superseded_by|derived_[a-z_]+):' || true; } | sed 's/:$//' | sort -u | tr '\n' ' ')
  [[ -z ${bad// } ]] || { echo "v1 reverse/renamed field(s) on $id: $bad" >&2; fail=1; }

  rec_seen_type[$id]=$type
  rec_fwd[$id]=$(printf '%s\n' "$front" | sed -nE 's/^(source_ids|related_adrs|included_ids|question_refs): *\[(.*)\].*$/\2/p' | tr ',' ' ')
  rec_src[$id]=$(printf '%s\n' "$front" | sed -nE 's/^source_ids: *\[(.*)\].*$/\1/p' | tr ',' ' ')
done < <(find "$artifacts" -type f -name '*.md' ! -path '*/questions/QUESTIONS.md' -print0)

# (IMPROVEMENT-0149) no record left under a v1 lifecycle subfolder
while IFS= read -r -d '' d; do
  case "$d" in "$artifacts"/legacy/*) continue ;; esac
  if compgen -G "$d/*.md" >/dev/null; then
    echo "records under v1 lifecycle path: $d" >&2; fail=1
  fi
done < <(find "$artifacts" -type d \( -name active -o -name ready -o -name done -o -name blocked -o -name archive -o -name proposed \) -print0 2>/dev/null)

# ---- Questions registry: one QUESTIONS.md, no v1 status-split remnants ----
if compgen -G "$artifacts/questions/QUESTIONS-*.md" >/dev/null; then
  echo "v1 Questions split file(s) remain under $artifacts/questions/" >&2; fail=1
fi
questions="$artifacts/questions/QUESTIONS.md"
declare -A qseen=()
if [[ -f $questions ]]; then
  while IFS= read -r qid; do [[ -n $qid ]] && qseen[$qid]=1; done < <(
    grep -oE '^\|[[:space:]]*(Q|CSQ|CSP)-[A-Z0-9-]*[0-9]{4}[[:space:]]*\|' "$questions" \
      | grep -oE '(Q|CSQ|CSP)-[A-Z0-9-]*[0-9]{4}')
  awk -F'|' '
    /^\|[[:space:]]*(Q|CSQ|CSP)-/ {
      for (i=1;i<=NF;i++) gsub(/^ +| +$/, "", $i)
      if ($3 == "resolved" || $3 == "discarded")
        if ($8 == "" || $9 == "" || $10 == "" || $11 == "") { print "incomplete terminal Question: " $2 > "/dev/stderr"; exit 1 }
    }' "$questions" || fail=1
fi

# ---- (IMPROVEMENT-0149) forward-link resolution + typing ----
for id in "${!rec_fwd[@]}"; do
  for ref in ${rec_fwd[$id]}; do
    ref=${ref// /}
    [[ -n $ref ]] || continue
    case "$ref" in
      Q-*|CSQ-*|CSP-*)
        [[ -n ${qseen[$ref]+x} ]] || { echo "unresolved question_ref '$ref' on $id" >&2; fail=1; } ;;
      *)
        [[ -n ${seen[$ref]+x} ]] || { echo "unresolved forward link '$ref' on $id" >&2; fail=1; } ;;
    esac
  done
done

# ---- (IMPROVEMENT-0149) no self-referential or cyclic source_ids ----
# self-reference
for id in "${!rec_src[@]}"; do
  for s in ${rec_src[$id]}; do s=${s// /}; [[ $s == "$id" ]] && { echo "self-referential source_ids on $id" >&2; fail=1; }; done
done
# cycle: topological peel over the source_ids edge set; anything left is in a cycle
declare -A indeg=() adj=()
for id in "${!rec_src[@]}"; do
  : "${indeg[$id]:=0}"
  for s in ${rec_src[$id]}; do
    s=${s// /}; [[ -n $s && -n ${rec_seen_type[$s]+x} ]] || continue
    adj[$id]+=" $s"; indeg[$s]=$(( ${indeg[$s]:-0} + 1 ))
  done
done
queue=(); for id in "${!indeg[@]}"; do (( indeg[$id] == 0 )) && queue+=("$id"); done
removed=0
while (( ${#queue[@]} )); do
  n=${queue[0]}; queue=("${queue[@]:1}"); removed=$(( removed + 1 ))
  for m in ${adj[$n]:-}; do
    indeg[$m]=$(( indeg[$m] - 1 )); (( indeg[$m] == 0 )) && queue+=("$m")
  done
done
if (( removed < ${#indeg[@]} )); then
  echo "cyclic source_ids detected among $(( ${#indeg[@]} - removed )) record(s)" >&2; fail=1
fi

if (( fail )); then exit 1; fi
echo "harness check passed"
