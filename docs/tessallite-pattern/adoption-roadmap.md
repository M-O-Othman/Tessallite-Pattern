# Tessallite Pattern Adoption Roadmap

Status: active
Last meaningful update: 2026-05-09

This roadmap helps a project adopt the Tessallite Pattern without stopping all
delivery work. It is organized as progressive levels so teams can add discipline
where the risk justifies it.

## Adoption Principle

Do not begin by creating a large process museum. Begin by adding the gates that
catch the failures you are already experiencing.

For the full prompt set, use [prompts/_INDEX.md](prompts/_INDEX.md). The roadmap
names prompt categories, while the prompt index is the canonical inventory.

For a practical first adoption session, use
[bootstrap-user-journey.md](bootstrap-user-journey.md). It explains when to run
the scripts, when to follow the walkthrough, and when to use the manual
bootstrap prompts.

When a project already has assistant memories, command wrappers, help-system
rules, UI standards, deployment scripts, or repeated review feedback, also use
[prompts/project-feedback-rules.md](prompts/project-feedback-rules.md). Those
skills are part of the adoption surface because they preserve the local
engineering judgment that generic prompts do not know.

## Level 0: Baseline

Use when the project is still experimenting.

Practices:

- keep a short requirements note for each non-trivial change
- write down open questions before asking the model to implement
- run tests after code generation
- keep a short session note when work spans more than one day

Exit signal:

- the team is building features that touch more than one module or session

## Level 1: Question Discipline

Goal: stop the model from silently filling gaps.

Add:

- first open-questions pass
- open-questions template
- rule that pending questions block planning

Minimum artefacts:

- requirements document
- open-questions file

Success criteria:

- requirements conversations produce fewer surprise assumptions
- architects answer explicit questions instead of correcting hidden guesses

## Level 1b: Project Skills And Command Discipline

Goal: preserve local engineering rules before implementation starts.

Add:

- project feedback rules from
  [prompts/project-feedback-rules.md](prompts/project-feedback-rules.md)
- command registry from
  [templates/command-registry-template.md](templates/command-registry-template.md)
- references for UI, help, deploy, publishing, configuration, test, screenshot,
  and data-seeding conventions where they exist

Minimum artefacts:

- persistent memory entry for project-specific behavioral rules
- command registry or developer guide section naming approved commands
- linked references for longer command recipes and local conventions

Success criteria:

- assistants do not run unsafe bare commands when wrappers exist
- repeated feedback becomes a standing project rule
- tool-specific settings are separated from reusable project policy
- command and skill conflicts are resolved before phase delivery

## Level 2: Spec And Plan Discipline

Goal: make design and execution separable.

Add:

- design spec template
- second open-questions pass
- implementation plan template
- traceability from spec sections to plan tasks

Minimum artefacts:

- active design spec
- closed open-questions file
- implementation plan

Success criteria:

- implementation plans no longer invent major design decisions
- tasks can be reviewed phase by phase

## Level 3: Adversarial Review

Goal: catch drift at phase boundaries.

Add:

- adversarial auditor prompt from [prompts/_INDEX.md](prompts/_INDEX.md)
- review report template
- phase gate checklist
- issue registry

Minimum artefacts:

- phase review report
- issue registry
- test evidence

Success criteria:

- reviewers sometimes find real defects
- phase closure requires evidence
- bugs are tracked rather than remembered informally

## Level 4: Session Continuity

Goal: preserve working memory across days and agents.

Add:

- session handout
- session start prompt from [prompts/_INDEX.md](prompts/_INDEX.md)
- session close prompt from [prompts/_INDEX.md](prompts/_INDEX.md)
- project journal entry for significant work

Minimum artefacts:

- `work/sessions/<date>.md`
- `work/logs/project-journal.md`

Success criteria:

- next sessions start faster
- decisions from prior sessions are recoverable
- failed attempts are not repeated accidentally

## Level 5: Documentation Governance

Goal: keep docs trustworthy as an LLM context cache.

Add:

- L0 docs index
- L1 domain indexes
- L2 summaries and statuses
- archive discipline
- `scripts/check-docs-index.sh`
- CI job for the docs guard

Minimum artefacts:

- `docs/_INDEX.md`
- `docs/<domain>/_INDEX.md`
- CI configuration that runs the script

Success criteria:

- new docs are discoverable immediately
- stale docs are archived or marked superseded
- missing index entries fail CI

## 30-Day Rollout Plan

### Week 1: Install The Core Gates

- choose one active feature
- install project feedback rules and command registry if prior assistant
  memories or command wrappers exist
- create requirements and open-questions files
- block planning until questions are answered
- write a short design spec
- run a second open-questions pass

Deliverable:

- one feature has passed both question gates

### Week 2: Add Phase Review

- create implementation plan
- implement one phase
- run adversarial review
- log findings
- close phase only after checklist passes

Deliverable:

- one reviewed phase with evidence

### Week 3: Add Continuity

- create session handout after each working session
- start each session by reading the latest handout
- append `work/logs/project-journal.md` for significant work

Deliverable:

- work can resume from artefacts rather than chat memory

### Week 4: Add Documentation Governance

- create `docs/_INDEX.md`
- add one L1 domain index
- update active L2 summaries
- run index checker locally
- add CI job if the repo has CI

Deliverable:

- active docs are routed through indexes

## Adoption Anti-Patterns

| Anti-Pattern | Why It Fails | Better Move |
| --- | --- | --- |
| Creating every template before using the pattern | Produces unused process files. | Apply templates to one real feature first. |
| Letting the LLM answer its own open questions | Replaces surfacing with guessing. | Architect answers or narrows scope. |
| Treating auditor as a ceremonial step | Produces false confidence. | Require evidence, severity, and file references. |
| Writing handouts only when convenient | Continuity fails exactly when work is messy. | Make session handout a close ritual. |
| Indexing docs once | Index decays as soon as files move. | Run the docs checker in CI. |

## Adoption Metrics

Track these lightly:

- percent of non-trivial features with open-questions files
- percent of large features with second-pass questions
- percent of phases with adversarial review reports
- number of review findings caught before merge
- number of open issue registry entries without owner
- number of docs index failures per week
- time needed for a new session to regain context

The goal is not process volume. The goal is fewer silent assumptions, fewer
late surprises, and faster recovery of project state.
