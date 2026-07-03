# Integration Debugging

## Use When

- a failure spans two or more services, subsystems, or repos
- a contract mismatch is suspected between producer and consumer
- an issue only appears when components interact, not in isolation

## Do Not Use For

- a failure fully contained within one component
- environment or local setup problems without a cross-boundary symptom
- performance issues without a functional integration failure

## Required Inputs

- the interacting components and the boundary between them
- observed failure and where in the interaction it occurs
- available evidence from both sides of the boundary (logs, traces, contracts, payloads)

## Agent Procedure

1. Confirm the components involved and the exact boundary where the failure appears.
2. Establish the expected contract: schema, protocol, ordering, or timing assumptions.
3. Compare actual behavior against the contract on each side of the boundary.
4. Isolate which side deviates from the contract, or whether the contract itself is ambiguous.
5. Check for version skew, environment mismatch, or partial deployment as contributing causes.
6. Recommend the smallest safe next action and identify the owning side for the fix.

## Required Checks

- the failing boundary and both interacting components are named
- the expected contract is stated explicitly
- the deviating side is identified with evidence, not assumption
- ownership of the fix is clear or the ambiguity is stated

## Required Output

- summary of the interaction and where it fails
- expected contract versus observed behavior
- identified deviating side and evidence
- owning component or team for the fix
- recommended next action

## Escalate When

- the two sides are owned by different teams with no clear resolution path
- the contract itself is undocumented or contested
- reproduction requires coordinated multi-service environments
- the mismatch touches security, auth, or data integrity across the boundary
