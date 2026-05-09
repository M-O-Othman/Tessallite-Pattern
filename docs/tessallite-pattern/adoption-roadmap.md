# Tessallite Pattern Adoption Roadmap

Status: active
Last meaningful update: 2026-05-09

This roadmap helps a project adopt the Tessallite Pattern without stopping all
delivery work. It is organized as progressive levels so teams can add discipline
where the risk justifies it.

## Adoption Principle

Do not begin by creating a large process museum. Begin by adding the gates that
catch the failures you are already experiencing.

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

- adversarial auditor prompt
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
- session start prompt
- session close prompt
- release history entry for significant work

Minimum artefacts:

- `work/sessions/<date>.md`
- release history entry

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
- append release history for significant work

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

