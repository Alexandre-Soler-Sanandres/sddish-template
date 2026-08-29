#!/usr/bin/env bash
# Template-maintainer-only structural evaluator for harness-evals. It does not run agents or mutate adopters.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"
mode="${1:---check}"
case "$mode" in --check|--baseline) ;; *) echo "usage: $0 [--check|--baseline]" >&2; exit 2;; esac

scenarios=(fast-documentation standard-bugfix ambiguous-feature cross-service-contract database-migration security-sensitive-change interrupted-resume material-scope-change overlapping-work harness-improvement)
required=("## Prompt and Input State" "## Allowed Mutations" "## Prohibited Mutations" "## Minimum Lane" "## Durable Artifacts" "## Approval Points" "## Risk Controls" "## Verification Evidence" "## Expected Stop Paths" "## Objective Assertions")
failed=0
for name in "${scenarios[@]}"; do
  file="harness-evals/scenarios/${name}.md"
  if [[ ! -f "$file" ]]; then echo "FAIL missing scenario: $file"; failed=1; continue; fi
  for heading in "${required[@]}"; do
    grep -Fqx "$heading" "$file" || { echo "FAIL $name lacks $heading"; failed=1; }
  done
done
[[ -f harness-evals/SUITE.md && -f harness-evals/BASELINE.md ]] || { echo "FAIL suite or baseline missing"; failed=1; }
if [[ "$mode" == --baseline ]]; then
  grep -Fq '| harness-improvement |' harness-evals/BASELINE.md || { echo "FAIL baseline does not cover all scenarios"; failed=1; }
fi
[[ "$failed" -eq 0 ]] && echo "OK harness evaluation suite structure is valid"
exit "$failed"
