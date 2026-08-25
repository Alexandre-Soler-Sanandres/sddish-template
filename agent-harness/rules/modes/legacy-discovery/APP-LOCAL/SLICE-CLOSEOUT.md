# APP-LOCAL / Slice-Closeout Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDA-06-010 | Slice-Closeout | MUST record a listing of the app root's contents and of every package directory a slice's scope references before treating that scope as fully known. |
| LDA-06-020 | Slice-Closeout | MUST name the specific docs consulted for each completed slice, or explicitly record that no relevant docs were found for that slice's scope. |
| LDA-06-030 | Slice-Closeout | MUST record a negative result for each checked `LDA-04-055`/`056`/`057`/`058`/`059` category when no qualifying evidence is found. |
| LDA-06-040 | Slice-Closeout | MUST record the concrete evidence basis for each `LDA-04-055`/`056`/`057`/`058`/`059` check. |
| LDA-06-045 | Slice-Closeout | MUST record a split-vs-enrich decision for each deployment, observability, hardening, and benchmark/evaluation sub-area evidenced in the slice before marking the slice `done`. |
| LDA-06-050 | Slice-Closeout | MUST complete a fresh-context verification pass before marking a slice `done`. |
| LDA-06-055 | Slice-Closeout | MUST address any gap found by the fresh-context verification pass before marking a slice `done`. |
| LDA-06-060 | Slice-Closeout | MUST complete the Slice Closeout Checklist before marking a slice `done`. |
