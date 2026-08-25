# CROSS-SYSTEM / Slice-Closeout Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDC-06-010 | Slice-Closeout | MUST check each completed cross-system slice for material cross-app parity gaps — operational/observability surfaces, data-model/contract shape, provider-set shape, non-error runtime states, sub-area-local fidelity, and concrete cross-app defects that a broader cross-app summary would lose. |
| LDC-06-011 | Slice-Closeout | MUST write a new cross-system finding or update an existing one when `LDC-06-010` finds a qualifying gap present. |
| LDC-06-020 | Slice-Closeout | MUST review every new or updated cross-system finding's `## Candidate Artifacts` section before closing the slice. |
| LDC-06-021 | Slice-Closeout | MUST leave `## Candidate Artifacts` empty only after confirming that no plausible downstream Use Case, Idea, Spec, or proof surface is clearly indicated by the evidence. |
| LDC-06-030 | Slice-Closeout | MUST run an explicit visible-behavior and scope/policy Question pass for the slice (release scope, configurability vs. fixed policy, visibility/warning behavior, acceptance/proof surface, operator/consumer priority) before marking it done, per `LD-04-050`/`060`. |
| LDC-06-040 | Slice-Closeout | MUST complete a fresh-context verification pass — a separate agent invocation receiving only the slice's recorded evidence, findings, Questions/parity rows, and checklist outputs — before marking a cross-system slice `done`. |
| LDC-06-041 | Slice-Closeout | MUST address any gap the `LDC-06-040` verification pass finds before closing the slice. |
| LDC-06-050 | Slice-Closeout | MUST complete the Cross-System Slice Closeout Checklist before marking a cross-system slice `done`. |
| LDC-06-055 | Slice-Closeout | MUST record a split-vs-enrich decision for each deployment, observability, hardening, and benchmark/evaluation sub-area evidenced in the slice before marking the slice done. |
