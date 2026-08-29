# EXTENSION.md — Legacy Discovery

## Purpose

Legacy Discovery is an **optional Extension**: portable capability, packaged as a self-contained tree under
`agent-harness/extensions/legacy-discovery/`, that a project enables only when it has existing systems to
extract rewrite-quality evidence from. Greenfield projects never load it.

An Extension carries its own workflow, submodes, templates, co-located rules, catalog entries, and entry
point. It MUST NOT weaken or override any CORE (`COR-*`) or Work-Lane (`LAN-*`) invariant.

## Profile gate

Enablement is a closed v2 project-profile override in `harness-data/HARNESS-PROFILE.yaml`:

```yaml
extensions:
  legacy_discovery: enabled   # enabled | disabled
```

The documented default when the key or file is absent is `disabled`. `agent-harness/templates/
HARNESS-PROFILE.example.yaml` ships the example. The `tw` repository sets `enabled` because it has active
Legacy Findings; the canonical template ships this Extension but no live profile.

When `disabled`: CORE, the Catalog, context loading, and wrapper generation ignore this Extension entirely —
base workflows never load or cite anything under `agent-harness/extensions/legacy-discovery/`. Enabling it
adds the entry point and the artifact locations below without changing any base workflow's semantics.

## Contents

| Path | Role |
| --- | --- |
| `DISCOVERING-LEGACY.md` | The Extension's Mode Workflow — boundaries, lifecycle, evidence precedence, reference enrichment, and its own `## Rules` (`LD-*`). |
| `submodes/APP-LOCAL.md` | App-local discovery phase (`LDA-*`). |
| `submodes/CROSS-SYSTEM.md` | Cross-system synthesis phase (`LDC-*`). |
| `submodes/NORMALIZATION.md` | Artifact normalization phase (`LDG-*`). |
| `submodes/CLARIFICATION.md` | Question clarification phase (`LDG-*`). |
| `submodes/IMPORT-HYGIENE.md` | Import-hygiene procedure for freshly imported snapshots (`LD-*`). |
| `agent-harness/extensions/legacy-discovery/templates/LEGACY-FINDING-template.md` | Legacy Finding artifact scaffold. |
| `agent-harness/extensions/legacy-discovery/templates/SOURCE-MAP-template.md` | App-local restart artifact scaffold. |
| `agent-harness/extensions/legacy-discovery/templates/INVENTORY-template.md` | App inventory scaffold. |
| `agent-harness/extensions/legacy-discovery/templates/CROSS-SYSTEM-SUMMARY-template.md` | Cross-system restart artifact scaffold. |
| `GUIDE.md` | Practical guidance for running Legacy Discovery in an existing codebase. |

Every `LD-`, `LDA-`, `LDC-`, and `LDG-` rule ID is preserved verbatim from the pre-Extension layout
(`IMPROVEMENT-0146` co-located them; `IMPROVEMENT-0147` only moved the files). Blockwise coverage,
provenance, Questions, proof/parity, and restart semantics are unchanged — this is packaging, not a change
to evidence quality.

## Entry point

`legacy-discovery` in `agent-harness/entrypoints.yaml`, carrying `condition: extension:legacy_discovery`.
Generated wrappers include it only for a repository whose profile enables the Extension.

## Artifact locations

The Extension's v2 artifact root is **`harness-data/extensions/legacy-discovery/`**, mirroring the previous
layout: per-app `apps/<slug>/` (`INVENTORY.md`, `SOURCE-MAP.md`, `findings/`), `cross-system/` (`SUMMARY.md`,
`CONTRACTS.md`, `findings/`, `REWRITE-READINESS.md`), and `imported/<slug>/` for source snapshots. All new
discovery work writes here (`LD-01-130`).

### Temporary read-only v1 bridge

The pre-migration tree `harness-data/artifacts/legacy/` is an explicitly temporary, **read-only** bridge.
While the Extension is enabled, discovery MAY read that tree for continuity with in-flight work, but MUST NOT
create, update, move, or link any artifact there — `LD-01-130` enforces this. `IMPROVEMENT-0149` performs the
ledgered migration of every bridged record into the v2 root and proves resumability from the v2
representation; `IMPROVEMENT-0150` then deletes the bridge and every remaining v1-specific Legacy Discovery
path and `-v1` rule. The bridge is not a permanent compatibility promise.

## Enabling / disabling / removing

- **Enable:** set `extensions.legacy_discovery: enabled` in `harness-data/HARNESS-PROFILE.yaml`, then
  regenerate wrappers (`scripts/generate-harness-wrappers.sh`).
- **Disable:** set it to `disabled` (or remove the key) and regenerate. Only safe when the repository has no
  active legacy work that depends on the Extension.
- **Remove entirely:** delete `agent-harness/extensions/legacy-discovery/` and the profile key. Do this only
  in a repository with no content under `harness-data/extensions/legacy-discovery/` or the
  `harness-data/artifacts/legacy/` bridge.
