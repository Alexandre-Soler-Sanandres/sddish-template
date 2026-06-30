---
id: LEGACY-FINDING-001
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

(what needs further investigation before converting to a formal artifact)
