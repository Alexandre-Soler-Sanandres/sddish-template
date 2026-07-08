---
id: LF-<APP>-NNN         # e.g. LF-BILLING-001; app findings use the app slug, cross-system findings use LF-CROSS-NNN
type: legacy-finding
status: draft            # draft | reviewed | converted | archived | rejected
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
legacy_source: []        # paths in harness-data/artifacts/legacy/imported/
evidence_type: ""        # observed | documented | inferred | uncertain
confidence: medium       # low | medium | high
area: ""                 # domain area, e.g. user-management | payments | reporting
candidate_artifacts: []  # e.g. [UC-001, SPEC-001, IDEA-001]
risk: low                # low | medium | high
tags: []                 # include `bug` when this finding documents a confirmed defect or dead/wired-but-inert
                          # code — as distinct from an unresolved fork (raise a Question instead) or
                          # future-facing intent (raise an Idea candidate instead)
---

## Finding

(describe what was found in the legacy code or documentation; when the evidence clearly supports a rewrite-facing
conclusion, state that conclusion here too, not only the narrow local fact)

## Evidence

(quote or reference the specific legacy source — file path, line numbers, snippet. For cross-system findings, cite the
contributing app finding IDs and the underlying source evidence they synthesize.)

## Classification

- **Observed behavior**: (what the code actually does)
- **Documented behavior**: (what the docs say it does)
- **Inferred intent**: (what it was probably meant to do)
- **Accidental complexity**: (anything that looks unintentional or unclear)
- **Operator/runtime visibility**: (if relevant, what operators, scripts, endpoints, dashboards, or diagnostics use to
  observe or trust this behavior today)
- **Persistence/data-model shape**: (if relevant, what storage shape, schema choice, read-model, key typing, or
  migration-authority boundary this finding establishes)
- **Architectural boundary implication**: (if relevant, what cross-layer or cross-subsystem contract inside the app
  this finding establishes)

## Evidence Conflict

(if sources disagree, record the conflict here: which sources conflict, and which was treated as authoritative and
why — e.g. "current code contradicts stale README; current code is authoritative")

## Candidate Artifacts

(what Use Cases, Specs, or Ideas this finding could inform — for documented future/roadmap intent that isn't an
unresolved fork per `LD-02-020`/`COR-01-110`, note a candidate `IDEA-*.md` here rather than only describing it in
prose)

## Open Questions

(list open question IDs from `QUESTIONS-OPEN.md` still open against this finding — `Q-<APP>-NNN` for app findings,
`CSQ-NNN` for cross-system findings. Empty means no open question-blockers on this finding. Before leaving this
empty, re-read this finding's own `Classification`/`Evidence Conflict` text against `QST-06-010`'s Question test
— "we haven't decided whether/how to X." If the finding's own wording already reads that way (e.g. "worth
tracking so a rewrite standardises on X"), or the finding clearly implies a `preserve-vs-adapt`, `scope-v1`,
`fidelity`, or `naming` fork, raise a registry row instead of leaving it as prose.)

## Resolved Questions

(for each question ID that used to be listed above and has since been resolved in `QUESTIONS-RESOLVED.md`, move it
here with the resolution text copied in directly — e.g. `` `Q-<APP>-NNN`: decision text `` or
`` `CSQ-NNN`: decision text `` — so this finding is self-contained without re-opening the registry)
