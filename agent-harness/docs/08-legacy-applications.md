# Legacy Applications

This guide is for humans using the harness to understand and rewrite legacy applications. It explains how to steer the
work, what to ask for, what to review, and which decisions you should keep in your hands.

The detailed agent rules live in `agent-harness/modes/LEGACY-DISCOVERY.md`. Use this guide as the human playbook.

## Your Role

You are not just asking the agent to summarize old code. You are shaping a reliable evidence trail for future product
and implementation decisions.

As the human, you should:

- choose the legacy app or app group to inspect
- decide how much discovery is enough for the current goal
- keep product decisions separate from observed legacy facts
- challenge claims that do not cite evidence
- approve when discovery can move from app-local work to cross-system synthesis
- decide whether legacy behavior should be preserved, adapted, deferred, or discarded

The agent can inspect files and maintain artifacts. You own scope, priority, target-product intent, and acceptance of
risk.

## How to Start

Start with a concrete app or imported source path:

```text
Please run legacy discovery for `harness-data/legacy/imported/<app-slug>`.
```

If you are unsure about scope, ask for a short discovery proposal first:

```text
Look at the imported app shape and propose the initial discovery slices before creating detailed findings.
```

Ask the agent to avoid broad scans unless needed. A good first pass should identify the app shape, likely entry
points, risk areas, and the first few discovery slices.

## Step 1: Set the Discovery Goal

Before detailed work begins, decide what you want to learn.

Examples:

- "I need enough evidence to rewrite this service."
- "I only want API and deployment boundaries."
- "I want to know whether this app is still relevant."
- "I want app-local discovery now; cross-system synthesis later."

Tell the agent the goal explicitly. It changes how deep the source map needs to go and when the work should stop.

Useful prompt:

```text
Create the initial inventory and source map for this app. Keep service splits provisional and record open questions
instead of deciding target architecture too early.
```

Human check: make sure the proposed scope is neither too broad to finish nor too narrow to support your next decision.

## Step 2: Protect the Imported Snapshot

Legacy source is evidence. During discovery, it should not be rewritten casually.

Ask the agent to check import hygiene:

```text
Check the imported snapshot for nested Git metadata and secret-like files. Inventory risky paths only; do not open
secret contents.
```

The important categories are:

- nested `.git` folders
- `.env`, `.env.*`, `secrets/`, keys, tokens, password files
- logs, caches, virtual environments, coverage output, build output
- generated metadata that may create noise

Human check: decide what to do with noisy or risky imported files. The agent can surface options, but cleanup should
be your call.

## Step 3: Create the App Discovery Workspace

For each app, discovery should live under:

```text
harness-data/legacy/apps/<app-slug>/
```

The important files are:

| Artifact | What you use it for |
| --- | --- |
| `INVENTORY.md` | Understand what exists before interpreting behavior. |
| `SOURCE-MAP.md` | See the discovery plan, slice status, evidence areas, and restart point. |
| `findings/active/LF-<APP>-NNN.md` | Review durable claims backed by evidence. |
| `QUESTIONS.md` | Track decisions discovery cannot settle by itself. |

Ask the agent to use the templates and keep `SOURCE-MAP.md` as the restart point.

Human check: do not let chat become the only plan. If the next step matters, it belongs in `SOURCE-MAP.md`.

## Step 4: Review the Inventory

The inventory should answer: "What is this app made of?"

Review whether it identifies:

- entry points and runtime commands
- main packages, services, jobs, pages, adapters, or scripts
- configuration and environment surfaces
- tests and quality tooling
- deployment files and operational notes
- docs that may explain intent
- inventory gaps

Good human questions:

- "Which files are load-bearing?"
- "Which docs look stale?"
- "Which parts look like runtime behavior and which are setup leftovers?"
- "What is missing before we can choose discovery slices?"

Tip: old READMEs can be useful, but they are lower-confidence evidence than current code and tests.

## Step 5: Shape the Source Map

The source map is the work queue. It should break discovery into small slices.

Good slice boundaries include:

- runtime entry and configuration
- API routes or UI pages
- domain workflows
- persistence and data contracts
- auth, secrets, and trust boundaries
- deployment and operations
- tests, quality gates, and CI

Ask the agent for slices that can be completed and reviewed independently.

Useful prompt:

```text
Propose the next smallest useful discovery slice from the source map, with the files you expect to inspect and the
artifacts you expect to update.
```

Human check: if a slice sounds like "look at everything," ask for it to be split.

## Step 6: Run One Slice or Block at a Time

For each slice or coherent block of related slices, your job is to keep the agent focused and then review the
evidence. Slices remain the durable tracking unit in `SOURCE-MAP.md`; blocks are a convenience when adjacent slices
share the same evidence set.

Ask for:

- the evidence files inspected
- what was observed in current code or tests
- what was only documented
- what was inferred
- what conflicts or uncertainty remain
- which findings, questions, source-map notes, and reference docs changed

Useful prompt:

```text
Run the next source-map slice or coherent block. Inspect code first, then tests, then docs. Update findings,
questions, source-map status, and stable reference docs in the same roundtrip.
```

Human check: each completed slice or block should leave the repo easier to resume. If the agent only reports in chat
and does not update artifacts, the roundtrip is incomplete. When a block runs, every included slice should still be
marked individually.

## Step 7: Review Findings

Findings are the claims you may later rely on.

A finding is useful when it:

- says one clear thing
- cites exact evidence paths
- separates observed behavior, documented behavior, inferred intent, and uncertainty
- records conflicts between sources
- lists candidate Use Cases or Specs only when evidence is strong
- links to open question IDs when decisions are unresolved

Ask skeptical questions:

- "Which line or file proves this?"
- "Is this current runtime behavior or stale documentation?"
- "Is this a target behavior or just legacy drift?"
- "Does this finding duplicate an existing one?"

Tip: if a finding cannot survive those questions, it should stay draft, be narrowed, or become a question.

## Step 8: Keep Questions Decision-Shaped

`QUESTIONS.md` is for decisions, not scratch notes.

Each question should make clear:

- what decision is needed
- whether it is `app-local`, `cross-system`, or `target-product`
- what kind of decision it is: `scope-v1`, `preserve-vs-adapt`, `fidelity`, `naming`, or `deferred-feature`
- which finding raised it
- what evidence or uncertainty matters

Human responsibility: answer target-product decisions when discovery cannot. The agent can propose options, but it
should not silently choose product intent.

Useful prompt:

```text
For each open question, give me options and a recommended proposal. Separate what the legacy evidence proves from
what we need to decide for the target system.
```

Tip: keep question IDs stable. If a question is merged or resolved, preserve the ID and record what happened.

## Step 9: Expect Reference Enrichment

Discovery should improve the living reference docs when evidence is stable.

Check that stable facts are routed to:

| Stable fact | Reference doc |
| --- | --- |
| Architecture boundaries, layer contracts, runtime topology | `harness-data/reference/ARCHITECTURE.md` |
| Domain concepts, rules, terminology, actors, workflows | `harness-data/reference/DOMAIN.md` |
| Commands, ports, services, CI, local validation | `harness-data/reference/TOOLING.md` |
| Quality gates, test expectations, proof standards, hygiene | `harness-data/reference/QUALITY.md` |

Human check: reject reference updates that are speculative, unresolved, or merely old-system noise. References should
help future target work, not preserve every legacy detail.

## Step 10: Decide When App-Local Discovery Is Done

An app is app-local complete when the source map is enough for app-local rewrite planning.

Before accepting `app-local-complete`, check:

- all planned slices are `done`, `not-needed`, or explicitly deferred
- open questions are classified
- stable reference docs were updated
- remaining gaps are either cross-system, target-product, proof work, or explicitly not needed
- the app source map names the next meaningful step

Important distinction: app-local complete is not the same as rewrite-ready. It means local evidence is mapped.
Cross-system synthesis, proof, and target decisions may still be required.

Tip: do not ask for more app-local slices just because there is more code. Ask whether more local discovery changes
the next decision.

## Step 11: Start Cross-System Synthesis Deliberately

Cross-system synthesis is for questions that need more than one app.

Start it only when:

- the active app scope is explicit
- every in-scope app is app-local complete
- you want to understand boundaries, contracts, parity, proof needs, or rewrite readiness across apps

Useful prompt:

```text
Start cross-system synthesis for these app-local-complete apps. Create or update `cross-system/SUMMARY.md` as the
restart point and do not create empty placeholder artifacts.
```

Human check: make sure the scope is named. "All apps" is fine only when that is truly what you mean.

## Step 12: Review Cross-System Claims

Cross-system findings should synthesize, not duplicate.

Ask:

- "Which app findings support this claim?"
- "What boundary or contract does this define?"
- "Is this a real runtime relationship or a documented intention?"
- "Does this belong in `CONTRACTS.md`, `QUESTIONS.md`, `PARITY-MATRIX.md`, or `REWRITE-READINESS.md`?"

Use the artifacts this way:

| Artifact | Human question it helps answer |
| --- | --- |
| `CONTRACTS.md` | What are the producer/consumer, API, data, auth, health, deployment, and ownership boundaries? |
| `findings/active/LF-CROSS-NNN.md` | What cross-app claim is supported by multiple evidence trails? |
| `QUESTIONS.md` | What cross-app or target-product decision remains open? |
| `PARITY-MATRIX.md` | What matches, drifts, or needs executable proof? |
| `REWRITE-READINESS.md` | What is ready for Use Cases/Specs and what still blocks planning? |

Tip: proof IDs should come from `PARITY-MATRIX.md`; readiness should cite them instead of creating another ID system.

## Step 13: Normalize Without Rediscovering

After discovery, ask for normalization before moving into Use Cases or Specs.

Normalization should:

- clean Markdown formatting, heading hierarchy, table consistency, duplicate sections, and stale restart pointers
- preserve evidence paths, finding IDs, question IDs, proof IDs, confidence, and lifecycle metadata
- merge duplicate findings by archiving the weaker duplicate with a pointer to the surviving finding
- collapse source maps and cross-system summaries only after important notes have durable homes

Human check: normalization is not an excuse to add new source findings. If a gap needs more source inspection, ask for
a question or proof item.

## Step 14: Clarify Questions Before Specs

Before Use Cases or Specs, open questions should be resolved, deferred with rationale, marked not-needed, or routed to
proof.

Ask the agent for options:

```text
Walk the open legacy questions. For each one, classify when it must be decided, give options, recommend one, and say
which artifacts need updates if I accept it.
```

As the human, you decide:

- what ships in v1
- what legacy behavior should be preserved or redesigned
- what fidelity matters
- what naming should change
- what can be deferred
- what needs executable proof before planning

Tip: when a cross-system decision answers app-local questions, ask the agent to update all affected artifacts in the
same pass.

## Step 15: Move Toward Use Cases and Specs

Only move forward when the evidence is usable.

You are ready when:

- findings can be cited cleanly
- questions are resolved or intentionally routed
- required proof is complete or explicitly deferred
- candidate Use Cases and Specs have supporting evidence
- the desired target behavior is not being confused with accidental legacy behavior

Useful prompt:

```text
Based on the normalized legacy evidence, propose candidate Use Cases. For each candidate, cite the supporting
findings and call out any target-product decision that must be settled first.
```

Human check: Use Cases and Specs describe the desired system. They can be informed by legacy evidence, but they should
not blindly preserve old behavior.

## Common Human Traps

| Trap | Better move |
| --- | --- |
| Asking the agent to "analyze the app" with no goal | State the decision the discovery should support. |
| Letting discovery sprawl because more files exist | Work from the source map and stop when the next decision is supported. |
| Accepting uncited summaries | Ask for finding IDs and evidence paths. |
| Treating old docs as truth | Ask whether current code or tests confirm them. |
| Deciding target architecture too early | Record open target-product decisions and keep service splits provisional. |
| Letting cross-system work start before app-local completion | Finish in-scope app source maps first, then synthesize. |
| Confusing app-local complete with rewrite-ready | Check cross-system synthesis, proof, and accepted deferrals. |
| Leaving decisions in chat | Ask the agent to update `QUESTIONS.md`, findings, source maps, and readiness notes. |

## Useful Human Review Checklist

Before accepting a discovery slice or block:

- Did the agent inspect the right files for the slice or block?
- Are claims backed by evidence paths?
- Are observed, documented, inferred, and uncertain points separated?
- Are open decisions in `QUESTIONS.md`?
- Are question IDs linked from findings?
- Were stable target-relevant facts routed to reference docs?
- Does `SOURCE-MAP.md` clearly say what is next?
- Did `git diff --check` pass?

Before accepting app-local completion:

- Are all slices done, not-needed, or explicitly deferred?
- Are remaining questions classified?
- Is `proof_needed` accurate?
- Are reference docs enriched where appropriate?
- Is the next step cross-system synthesis, proof, normalization, or downstream Use Cases/Specs?

Before accepting cross-system completion:

- Is the active app scope explicit?
- Are cross-system claims supported by app findings?
- Are contracts, questions, parity rows, and readiness notes linked?
- Are proof IDs canonical in `PARITY-MATRIX.md`?
- Are target-product decisions separated from legacy facts?

## Useful Commands to Ask For

You can ask the agent to run these when relevant:

```sh
git diff --check
find harness-data/legacy/imported/<app-slug> -path '*/.git' -type d
rg --files agent-harness -g 'README.md' -g 'README.*'
```

Expected result for the last command: only `agent-harness/README.md`. Extra directory-scoped harness READMEs should
not appear. Imported application READMEs under `harness-data/legacy/imported/` are source evidence, not harness artifacts.
