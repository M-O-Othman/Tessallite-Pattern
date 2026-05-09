# Quality Cycle Readiness

Status: active
Last meaningful update: 2026-05-09

This document checks whether the Tessallite Pattern kit now contains a complete
cycle for developing high-quality code with AI assistance. It also explains why
the generalized skills and command rules matter.

## Readiness Summary

The cycle is complete enough to use for serious feature delivery:

1. Bootstrap persistent assistant memory and project docs.
2. Install project-specific feedback skills and command constraints.
3. Capture requirements.
4. Run first-pass open questions.
5. Draft a design spec.
6. Run second-pass open questions.
7. Create a phased implementation plan with traceability.
8. Implement one phase at a time.
9. Run targeted verification during implementation and broader verification at
   phase close.
10. Run adversarial review.
11. Fix or log findings.
12. Update docs, help, indexes, and issue registry.
13. Preserve session handout and project journal.

The important improvement from the skills layer is that it turns repeated
review feedback into standing project behavior. Without that layer, the pattern
has gates but can still forget local rules such as command wrappers, screenshot
generation, help navigation, terminology, SQL architecture, or publishing
scripts.

## Skills Layer

Use [prompts/project-feedback-rules.md](prompts/project-feedback-rules.md) at
bootstrap and whenever a project imports memory from another coding assistant.
The skills are important because they protect the parts of quality that generic
LLM prompts usually miss.

| Skill Area | Why It Matters |
| --- | --- |
| Plan and master-plan hygiene | Keeps decisions, answers, supporting docs, and execution state in one durable route instead of scattered chat memory. |
| Failing-test and bug discipline | Prevents assistants from explaining away broken behavior as pre-existing, unrelated, or ignorable. |
| Preserve test intent | Stops the easiest false fix: weakening tests until incorrect code passes. |
| Judgement-based test cadence | Balances safety with speed by running focused checks while iterating and broad checks at risk points. |
| Command wrappers | Prevents environment loss, wrong deploy paths, unsafe bare compose commands, and incorrect publishing routes. |
| Configuration and secrets | Keeps deploy-specific values out of source and protects real credentials from being written into tracked docs. |
| UI, help, and screenshot rules | Keeps user-facing documentation aligned with product changes, including navigation chains and refreshed evidence. |
| Terminology and glossary rules | Prevents assistants from reintroducing old or forbidden language after a project standard has changed. |
| SQL and source-query architecture | Keeps cross-connector behavior centralized instead of scattering dialect branches through the codebase. |
| Session continuity | Makes work resumable across models, tools, days, and context compaction. |
| Code review workflow | Forces findings, evidence, tests, docs, and issues to be checked before commit or phase close. |

## Command Discipline

The pattern should not hard-code one universal command set. Each project needs a
small command registry that names the approved commands and wrappers.

Use [templates/command-registry-template.md](templates/command-registry-template.md)
to record:

- targeted test commands
- full test commands
- build, lint, typecheck, and formatting commands
- docs index checks
- screenshot or help-generation commands
- seed/reset/smoke-test commands
- deploy and publish wrappers
- commands that must never be run bare

The default command provided by this kit is:

```bash
bash scripts/check-docs-index.sh
```

That command verifies documentation routing. It is not a substitute for a
project's tests, builds, linting, typechecking, security checks, screenshot
refresh, or deployment wrappers.

## Complete Cycle Check

| Cycle Step | Current Kit Coverage | Status |
| --- | --- | --- |
| Persistent memory | `agent-memory-instructions.md` and bootstrap prompts. | ready |
| Project feedback skills | `project-feedback-rules.md`. | ready |
| Command registry | `command-registry-template.md`. | ready as template |
| Requirements | Requirements prompt and template. | ready |
| First open questions | Open-question prompt and template. | ready |
| Design spec | Design-spec prompt and template. | ready |
| Second open questions | Open-question prompt supports second pass. | ready |
| Implementation plan | Plan prompt and template with traceability. | ready |
| Phase implementation | Phase implementation prompt. | ready |
| Tests and verification | Lifecycle and phase gate require verification, but project-specific commands must be registered. | ready with project setup |
| Adversarial review | Auditor prompt and review report template. | ready |
| Phase closure | Phase closure prompt and checklist. | ready |
| Issue tracking | Issue registry template and governance rules. | ready |
| Docs/help updates | Governance model, phase gate, and feedback skills. | ready |
| Session continuity | Session prompts, handout template, journal template. | ready |
| CI enforcement | Docs index guard exists; project CI must wire it in. | partial |

## Remaining Recommendations

The kit is ready for high-quality code delivery, but these additions would make
it stronger:

1. Add a CI workflow example that runs `scripts/check-docs-index.sh` plus a
   placeholder for project test/build commands.
2. Add an optional markdown link checker or link-checking recommendation.
3. Add a status vocabulary checker so docs cannot invent new statuses silently.
4. Add a command-registry check that fails when the phase plan references an
   unregistered command.
5. Add a release or pull-request checklist that bundles docs index, tests,
   adversarial review, issue registry, and session handout evidence.
