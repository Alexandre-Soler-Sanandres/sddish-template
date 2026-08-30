# SDD-ish Template

This is the project README for this reusable SDD-ish Agent Harness template.

The harness spans two top-level roots so projects created from this template can keep their own project README
and root documentation separate from harness guidance:

- **`agent-harness/`** — the portable harness definition: modes, artifact specs, shared procedures, templates, and
  core rules. Template creation copies it, but does not establish automatic later synchronization.
- **`harness-data/`** — each project's own data once adopted: filled-in reference config, Legacy Discovery
  findings, and every artifact the harness produces (Use Cases, Specs, Tasks, Plans, Reviews, Improvements,
  Transcripts, Ideas, Questions). Ships here as an empty skeleton; nothing in it is ever copied back into this
  template. The initial skeleton is copied during template creation and then belongs to the new project.

## Harness

| Resource | Purpose |
| --- | --- |
| [agent-harness/README.md](agent-harness/README.md) | Harness overview and operating model |
| [agent-harness/docs/](agent-harness/docs/) | Harness documentation and human guides |
| [AGENTS.md](AGENTS.md) | Agent entry instructions for repositories using the harness |
| [CLAUDE.md](CLAUDE.md) | Claude entry file; defers to `AGENTS.md` |
| [agent-harness/CATALOG.md](agent-harness/CATALOG.md) | Universal artifact-location index |
| [harness-data/CATALOG.md](harness-data/CATALOG.md) | Generated, read-only convenience index |
| [agent-harness/LICENSE](agent-harness/LICENSE) | Harness content license |

Start with the [adoption guide](agent-harness/docs/07-adoption.md) when applying the template to a project.
