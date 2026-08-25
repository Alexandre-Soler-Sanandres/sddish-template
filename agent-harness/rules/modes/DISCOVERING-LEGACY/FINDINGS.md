# DISCOVERING-LEGACY / Findings Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-03-010 | Findings | MUST store each finding as its own file, using `agent-harness/templates/LEGACY-FINDING-template.md` as-is: `harness-data/artifacts/legacy/apps/<app-slug>/findings/active/<LF-ID>.md` for app-scoped findings, `harness-data/artifacts/legacy/cross-system/findings/active/<LF-ID>.md` for cross-system findings. |
| LD-03-020 | Findings | MUST follow the existing `LF-<APP>-NNN` convention for IDs, numbered once per app (or `LF-CROSS-NNN` for cross-system). |
| LD-03-021 | Findings | An `LF-*` ID MUST NOT be reused, even after a finding moves or is merged. |
| LD-03-030 | Findings | MUST move a finding to the matching `findings/archive/<LF-ID>.md` path when its `status` becomes `converted`, `archived`, or `rejected`; findings with `status: draft` or `status: reviewed` stay in `findings/active/`. |
| LD-03-040 | Findings | MUST NOT look up or add a finding except by ID — scan `findings/active/` and `findings/archive/` file names or frontmatter, not by reading through file append order or by creating slice-numbered or subsystem-named headings as a substitute for the ID. |
| LD-03-050 | Findings | MUST tag a finding `bug` in its `tags` frontmatter when it documents a confirmed defect (wrong runtime, dashboard, or metrics behavior) or dead/wired-but-inert code, as distinct from an unresolved fork (`Q-*`/`CSQ-*`) or future-facing intent (`IDEA-*`). This tag exists so bug-shaped findings stay discoverable across an app's full finding set, not to create a new artifact type or lifecycle. |
| LD-03-055 | Findings | MUST preserve a concrete runtime-correctness defect, stale-code conclusion, or dead/wired-but-inert behavior as its own first-class finding when the evidence establishes it, even if a broader subsystem finding covering the same area also exists. |
| LD-03-060 | Findings | MUST treat operational or manual surfaces as first-class findings when they materially define current runtime trust, operator workflow, or observability — including CLI/operator tools, health/readiness/metrics surfaces, SQL diagnostics, and other human-run inspection paths. |
| LD-03-070 | Findings | MUST record material data-model shape choices when evidence establishes them, even without a defect — including storage topology, typed-vs-JSON structure, DB views as read models, key typing, and authority boundaries between ORM metadata and migrations. |
| LD-03-080 | Findings | MUST capture non-error runtime states when they materially affect operator understanding, rewrite fidelity, or target behavior — for example warmup periods, degraded-but-expected modes, or long-running intermediate states. |
| LD-03-085 | Findings | MUST preserve a sub-area as its own finding when its contract shape, fetch/execution pattern, fallback strategy, interaction model, dependency timing, state model, or cost profile would materially affect rewrite fidelity if collapsed into a broader family summary. |
| LD-03-087 | Findings | MUST preserve a sub-area as its own finding when collapsing it into a broader family summary would hide a materially different deployment posture, hardening posture, operator visibility surface, or benchmark/evaluation policy surface. |
| LD-03-088 | Findings | MUST preserve a log-only visibility surface or deployment-file omission as its own first-class finding when in-scope deployment files or runtime evidence establish that it materially affects operator trust, observability expectations, readiness semantics, hardening posture, or rewrite fidelity. |
| LD-03-090 | Findings | MUST capture app-internal architectural boundaries when the evidence clearly establishes a cross-layer or cross-subsystem contract inside one app, not only the files or functions on each side. |
| LD-03-100 | Findings | MUST record provider-set shape when a capability depends on providers and the evidence makes the portfolio materially relevant — including primary, fallback, overlapping, deferred, or disabled-but-wired providers. |
