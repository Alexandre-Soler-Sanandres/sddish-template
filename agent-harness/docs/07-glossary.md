# Glossary

**Artifact**  
A Markdown file representing a structured unit of work or knowledge, such as an Idea, Use Case, Spec, Task, Plan, Review, or Improvement.

**Mode**  
A bounded agent behavior profile that defines what the agent may do. Only one mode is active at a time.

**Partnering**  
Conversational mode for capture, clarification, and idea formation. The front door for unclear thinking.

**Use Case**  
A behavioral anchor that describes who does what, under what conditions, and with what observable outcome. Created from Ideas, Transcripts, or Partnering discussions.

**Spec**  
The source of truth for desired behavior. Always created from a Use Case. Defines problem, goal, scope, requirements, acceptance criteria, and risks.

**Task**  
An optional executable work unit derived from an approved Spec when smaller, traceable slices are needed.

**Implementation Plan**  
A required plan that defines how implementation will proceed before any code is changed. Must be approved before Implementation mode may start.

**Validation**  
A mode that checks artifacts, plans, and implementations against process and behavioral criteria. Does not run technical checks.

**Review**  
A structured assessment of an artifact, implementation, or process result. How process problems are discovered.

**Harness Improvement**  
A controlled change to the harness itself, derived from Review findings.

**Legacy Discovery**  
A mode for analyzing existing code and documentation to derive artifacts without implementing. The legacy project is evidence, not authority.

**Frontmatter**  
YAML metadata at the top of Markdown artifacts, used for IDs, status, traceability, and context loading.

**Input Channel**  
Voice, chat, or text — the mechanism by which input is received. Not a mode. Partnering is the mode regardless of input channel.

**Mode Transition**  
Switching from one mode to another. Only happens when the user explicitly requests it. Ambiguous intent must be clarified first.

**Inline Plan**  
An Implementation Plan that contains steps without separate Task artifacts — valid for small, low-risk, single-area Specs.

**technical_refs**  
A Spec frontmatter field for linking to external technical artifacts (OpenAPI specs, database schemas, contracts) that live outside `agent-harness/`.

**SUMMARY.md**  
An optional lightweight navigation file created per artifact directory when the number of artifacts makes discovery difficult.

**CATALOG.md**  
A tiny harness navigation file listing artifact locations. Not a god-index.

**God-Index Anti-Pattern**  
The failure mode where an agent loads a massive index of every artifact instead of navigating from a specific referenced artifact. Causes context collapse and loss of precision.
