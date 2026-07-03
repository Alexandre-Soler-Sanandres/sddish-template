# Security Review

## Use When

- reviewing changes to auth, access control, or session handling
- reviewing changes that touch secrets, credentials, or sensitive data handling
- reviewing input validation, external input trust boundaries, or injection risk
- assessing security impact of a dependency, config, or infrastructure change

## Do Not Use For

- general code review without a security-relevant surface (see code-review.md)
- performance-only or style-only changes
- purely internal refactors with no change to trust boundaries or data handling

## Required Inputs

- changed files or diff
- affected trust boundaries: what data or actors cross in and out
- known sensitive areas: auth, secrets, payments, PII, admin access

## Agent Procedure

1. Confirm the security-relevant surface: what boundary, data, or privilege the change touches.
2. Identify all trust boundaries crossed: user input, external services, third-party data, privilege changes.
3. Check input handling: validation, sanitization, encoding, and injection risk at each boundary.
4. Check authorization and authentication: who can trigger the change, and whether access checks are correct and unchanged in intent.
5. Check secrets and sensitive data handling: no secrets in code or logs, correct storage, correct transmission.
6. Check for unsafe defaults, missing checks on error paths, and privilege escalation through edge cases.
7. Record findings in severity order with file references, distinguishing confirmed issues from suspected ones.

## Required Checks

- every crossed trust boundary is identified and checked
- input validation and injection risk are addressed at each boundary
- authorization checks are correct on both the happy path and error paths
- no secrets, tokens, or sensitive data are exposed in code, logs, or output
- findings are backed by the actual change, not generic security advice

## Required Output

- security-relevant surface and trust boundaries identified
- findings in severity order with file references
- explicit note when no findings were found
- residual risks or areas that need dedicated security testing

## Escalate When

- the change affects authentication, authorization, or privilege boundaries broadly
- a credential, secret, or sensitive data exposure is found
- the risk requires expertise or tooling beyond code review (e.g. cryptography design, pen testing)
- the finding suggests an existing vulnerability already in production
