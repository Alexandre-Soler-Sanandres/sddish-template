---
id: LF-<APP>-NNN         # e.g. LF-TW-ENGINE-001; app findings use the app slug, cross-system findings use LF-CROSS-NNN
type: legacy-finding
status: draft            # draft | reviewed | converted | archived | rejected
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
legacy_source: []        # paths in legacy/imported/
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

(quote or reference the specific legacy source — file path, line numbers, snippet)

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

(list `Q-<APP>-NNN` IDs from `QUESTIONS.md` still open against this finding — empty means no open
question-blockers on this finding)

## Resolved Questions

(for each `Q-<APP>-NNN` ID that used to be listed above and has since been resolved in `QUESTIONS.md`'s `Resolved
Decisions`, move it here with the resolution text copied in directly — e.g. `` `Q-<APP>-NNN`: decision text `` — so
this finding is self-contained without re-opening `QUESTIONS.md`)
