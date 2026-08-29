#!/usr/bin/env bash
set -euo pipefail

root=${1:-harness-data}
artifacts="$root/artifacts"
fail=0
declare -A seen=()

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

while IFS= read -r -d '' file; do
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
done < <(find "$artifacts" -type f -name '*.md' ! -path '*/questions/QUESTIONS.md' -print0)

questions="$artifacts/questions/QUESTIONS.md"
if [[ -f $questions ]]; then
  awk -F'|' '
    /^\| Q-/ {
      for (i=1;i<=NF;i++) gsub(/^ +| +$/, "", $i)
      if ($3 == "resolved" || $3 == "discarded")
        if ($8 == "" || $9 == "" || $10 == "" || $11 == "") { print "incomplete terminal Question: " $2 > "/dev/stderr"; exit 1 }
    }' "$questions" || fail=1
fi

if (( fail )); then exit 1; fi
echo "harness check passed"
