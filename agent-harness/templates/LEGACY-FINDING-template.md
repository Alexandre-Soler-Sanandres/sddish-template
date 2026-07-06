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
candidate_artifacts: []  # e.g. [UC-001, SPEC-001]
risk: low                # low | medium | high
tags: []
---

## Finding

(describe what was found in the legacy code or documentation)

## Evidence

(quote or reference the specific legacy source — file path, line numbers, snippet. For cross-system findings, cite the
contributing app finding IDs and the underlying source evidence they synthesize.)

## Classification

- **Observed behavior**: (what the code actually does)
- **Documented behavior**: (what the docs say it does)
- **Inferred intent**: (what it was probably meant to do)
- **Accidental complexity**: (anything that looks unintentional or unclear)

## Evidence Conflict

(if sources disagree, record the conflict here: which sources conflict, and which was treated as authoritative and
why — e.g. "current code contradicts stale README; current code is authoritative")

## Candidate Artifacts

(what Use Cases or Specs this finding could inform)

## Open Questions

(list open question IDs from `QUESTIONS-OPEN.md` still open against this finding — `Q-<APP>-NNN` for app findings,
`CSQ-NNN` for cross-system findings. Empty means no open question-blockers on this finding. Before leaving this
empty, re-read this finding's own `Classification`/`Evidence Conflict` text against `QST-06-010`'s Question test
— "we haven't decided whether/how to X." If the finding's own wording already reads that way (e.g. "worth
tracking so a rewrite standardises on X"), raise a registry row instead of leaving it as prose.)

## Resolved Questions

(for each question ID that used to be listed above and has since been resolved in `QUESTIONS-RESOLVED.md`, move it
here with the resolution text copied in directly — e.g. `` `Q-<APP>-NNN`: decision text `` or
`` `CSQ-NNN`: decision text `` — so this finding is self-contained without re-opening the registry)
