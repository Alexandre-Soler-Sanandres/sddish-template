# APP-LOCAL / Slice-Roundtrip Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDA-04-010 | Slice-Roundtrip | Reference enrichment MAY be deferred across blockwise work only when the source map says so. |
| LDA-04-020 | Slice-Roundtrip | MUST review every new or updated finding for downstream artifact candidates before closing the slice. |
| LDA-04-021 | Slice-Roundtrip | MUST record each clearly supported candidate found per `LDA-04-020` in that finding's `## Candidate Artifacts` section at authoring time. |
| LDA-04-025 | Slice-Roundtrip | MUST leave a finding's `## Candidate Artifacts` section empty only after checking that no plausible downstream Use Case, Idea, Spec, proof surface, or other durable follow-on artifact is clearly indicated by the evidence. |
| LDA-04-030 | Slice-Roundtrip | MUST NOT invent a new per-slice `"Candidate <Something>"` list in `SOURCE-MAP.md`'s slice notes under any label; that is the same duplication. When a candidate spans multiple findings from the same slice, record it in each contributing finding's `Candidate Artifacts`, not as a new shared list. |
| LDA-04-035 | Slice-Roundtrip | SHOULD use a finding's `## Candidate Artifacts` section to note meaningful cross-finding impact when that traceability will materially help later synthesis or prioritization. Record each such note as a flat bullet in the form `- Affects: <LF-ID> — <short reason>`. Frontmatter `candidate_artifacts` remains for artifact IDs only. |
| LDA-04-040 | Slice-Roundtrip | MUST test each finding for a material unresolved target choice before leaving its `## Open Questions` empty, not only its own `Classification`/`Evidence Conflict` prose. |
| LDA-04-041 | Slice-Roundtrip | If `LDA-04-040`'s test finds a fork that satisfies `QST-06-010` and `QST-06-020`, whether explicit or latent after applying engineering judgment, MUST raise or update a `Q-<APP>-NNN` registry row instead of leaving the fork only as prose in the finding. |
| LDA-04-050 | Slice-Roundtrip | MUST NOT mark a slice `done` until at least one finding records what the slice's area concretely contains or does, independent of anomaly, conflict, or edge-case behavior. |
| LDA-04-055 | Slice-Roundtrip | MUST check each completed slice for material operational or manual surfaces in scope — including CLI/operator tools, health/readiness/metrics surfaces, SQL diagnostics, or comparable observability paths. |
| LDA-04-056 | Slice-Roundtrip | MUST check each completed slice for material data-model shape choices in scope — including storage topology, JSON-vs-typed structure, DB views as read models, key typing, or migration-authority boundaries. |
| LDA-04-057 | Slice-Roundtrip | MUST check each completed slice for material provider-set shape in scope — including primary, fallback, overlapping, deferred, or disabled-but-wired providers. |
| LDA-04-058 | Slice-Roundtrip | MUST check each completed slice for material non-error runtime states in scope — including warmup, degraded-but-expected, or long-running intermediate states. |
| LDA-04-059 | Slice-Roundtrip | MUST check each completed slice for target-design forks implied by the evidence — including `preserve-vs-adapt`, `scope-v1`, `fidelity`, `naming`, and `deferred-feature` forks, plus visible-behavior questions, release-scope questions, configurability-vs-fixed-policy questions, deployment/runtime-policy questions, quality/acceptance-surface questions, and operator- or consumer-priority questions when the current evidence establishes the surface but not the target decision. |
| LDA-04-071 | Slice-Roundtrip | MUST use engineering judgment to identify materially unresolved forks per `LDA-04-059` even when no direct artifact conflict states them. |
| LDA-04-072 | Slice-Roundtrip | MUST write a new finding or update an existing finding when `LDA-04-055`/`056`/`057`/`058` finds a qualifying surface present. |
| LDA-04-073 | Slice-Roundtrip | MUST create a new Question or update an existing Question when `LDA-04-059` finds a qualifying fork present. |
| LDA-04-060 | Slice-Roundtrip | Reference enrichment MUST be complete before `app-local-complete`. |
| LDA-04-062 | Slice-Roundtrip | MUST check each completed slice for unresolved release, deployment, observability, benchmark, documentation-surface, and acceptance-policy forks established by in-scope deployment files, checked-in contracts, or historical docs. |
| LDA-04-074 | Slice-Roundtrip | MUST create a new Question or update an existing Question when `LDA-04-062` finds a qualifying fork present. |
| LDA-04-065 | Slice-Roundtrip | MUST check each completed slice for sub-area-local fidelity that would be lost if the slice were represented only by a broader family summary. |
| LDA-04-075 | Slice-Roundtrip | MUST write a new finding or update an existing finding when `LDA-04-065` finds such a sub-area present. |
| LDA-04-066 | Slice-Roundtrip | MUST check each completed slice for concrete runtime-correctness defects, stale-code conclusions, or dead/wired-but-inert behavior that deserves first-class preservation. |
| LDA-04-076 | Slice-Roundtrip | MUST write a new finding or update an existing finding when `LDA-04-066` finds such evidence present. |
| LDA-04-070 | Slice-Roundtrip | MUST NOT treat the baseline-finding requirement alone as sufficient when a slice also clearly establishes rewrite-facing conclusions, operational/manual surfaces, data-model shape, provider-set shape, non-error runtime states, sub-area-local fidelity worth preserving separately, concrete defect-shaped evidence worth preserving separately, or target-design forks; those evidence classes still need their own finding or Question coverage in the same pass. |
