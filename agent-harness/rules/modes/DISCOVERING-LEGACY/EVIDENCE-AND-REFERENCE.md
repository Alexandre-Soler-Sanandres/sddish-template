# DISCOVERING-LEGACY / Evidence-and-Reference Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-08-010 | Evidence-Precedence | Every finding MUST state whether it is based on observed behavior, documented behavior, or inference, and record which source was treated as authoritative when evidence conflicts. |
| LD-08-020 | Evidence-Precedence | SHOULD default to the order given in `DISCOVERING-LEGACY.md`'s `### Evidence Precedence` when sources conflict, and record any deviation and why. |
| LD-09-010 | Reference-Enrichment | MUST NOT enrich references with unresolved, uncertain, cross-system-before-synthesis, or speculative findings. |
| LD-09-020 | Reference-Enrichment | MUST NOT write target-decision language into `## Discovered` — write reference-doc enrichment there from findings, citing the specific `LF-*` ID; a settled target decision belongs under `## Decisions` instead, added when the decision is actually made (via Question Clarification outcome or a later ADR), not during Legacy Discovery itself. |
| LD-09-030 | Reference-Enrichment | Before closing out a slice, MUST check every `bug`-tagged finding from that slice against `DISCOVERING-LEGACY.md`'s `### Reference Enrichment` routing table and confirm it was written into at least one reference doc's `## Discovered` section. The tag flags a finding for this check; the finding's actual content still decides which doc(s) it belongs in per the routing table — a `bug` tag does not mean it must go in `QUALITY.md` specifically. |
