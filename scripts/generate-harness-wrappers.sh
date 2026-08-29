#!/usr/bin/env bash
# Generate the three per-agent entry-point wrapper layers from the single
# authored manifest agent-harness/entrypoints.yaml (IMPROVEMENT-0146).
#
#   .claude/skills/harness/<name>/SKILL.md          (Claude Code)
#   .agents/skills/harness/<name>/SKILL.md          (Codex CLI)
#   .agents/skills/harness/<name>/agents/openai.yaml
#   .github/agents/<name>.agent.md                  (Copilot)
#
# Idempotent: a second run reproduces byte-for-byte. Adopter repos mirror the
# generated output; direct edits to a wrapper fail `scripts/check-harness.sh`.
#
# Usage: scripts/generate-harness-wrappers.sh [repo-root]   (default: repo root)
set -euo pipefail
repo="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
manifest="$repo/agent-harness/entrypoints.yaml"
[[ -f $manifest ]] || { echo "no manifest: $manifest" >&2; exit 1; }

python3 - "$repo" "$manifest" <<'PY'
import os, sys, yaml

repo, manifest = sys.argv[1], sys.argv[2]
doc = yaml.safe_load(open(manifest))
eps = doc["entrypoints"]

def write(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        f.write(text if text.endswith("\n") else text + "\n")

def body_for(ep, placeholder):
    b = ep["body"].rstrip("\n")
    return b.replace("{input}", placeholder)

claude_dir = os.path.join(repo, ".claude/skills/harness")
codex_dir  = os.path.join(repo, ".agents/skills/harness")
gh_dir     = os.path.join(repo, ".github/agents")

managed = {"claude": set(), "codex": set(), "gh": set()}

for ep in eps:
    name = ep["name"]
    desc = ep["description"]
    inp  = ep.get("input")

    # --- Claude Code ---
    fm = ["---", f"description: {desc}", "disable-model-invocation: true"]
    if inp:
        fm.append(f"argument-hint: [{inp}]")
    fm.append("---")
    write(os.path.join(claude_dir, name, "SKILL.md"),
          "\n".join(fm) + "\n\n" + body_for(ep, "$ARGUMENTS") + "\n")
    managed["claude"].add(name)

    # --- Codex CLI ---
    write(os.path.join(codex_dir, name, "SKILL.md"),
          f"---\nname: {name}\ndescription: {desc}\n---\n\n"
          + body_for(ep, "as stated in the user's request.") + "\n")
    write(os.path.join(codex_dir, name, "agents", "openai.yaml"),
          "policy:\n  allow_implicit_invocation: false\n")
    managed["codex"].add(name)

    # --- Copilot ---
    write(os.path.join(gh_dir, f"{name}.agent.md"),
          f"---\nname: {name}\ndescription: {desc}\ntools: [\"*\"]\n"
          f"disable-model-invocation: true\n---\n\n"
          + body_for(ep, "as stated in the user's request.") + "\n")
    managed["gh"].add(name)

# prune wrappers that no longer have a manifest entry
for d in (os.path.join(claude_dir, x) for x in os.listdir(claude_dir)) if os.path.isdir(claude_dir) else []:
    if os.path.isdir(d) and os.path.basename(d) not in managed["claude"]:
        import shutil; shutil.rmtree(d); print("pruned", d)
for d in (os.path.join(codex_dir, x) for x in os.listdir(codex_dir)) if os.path.isdir(codex_dir) else []:
    if os.path.isdir(d) and os.path.basename(d) not in managed["codex"]:
        import shutil; shutil.rmtree(d); print("pruned", d)
if os.path.isdir(gh_dir):
    for fn in os.listdir(gh_dir):
        if fn.endswith(".agent.md") and fn[:-len(".agent.md")] not in managed["gh"]:
            os.remove(os.path.join(gh_dir, fn)); print("pruned", fn)

print(f"generated {len(eps)} entry points x 3 layers")
PY
