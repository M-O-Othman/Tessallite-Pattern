# Prompts Orchestration Guide

Status: active
Last meaningful update: 2026-05-09

Use this file to run the Tessallite Pattern prompts in the right order. The
prompt folder is not a menu of independent prompts. It is an operating sequence
that follows the lifecycle and gate model.

## Quick Flow

| Stage | Goal | Prompt | Output Format / Gate |
| --- | --- | --- | --- |
| Bootstrap | Install project memory and docs structure. | [bootstrap-greenfield-project-prompt.md](bootstrap-greenfield-project-prompt.md) or [bootstrap-existing-codebase-prompt.md](bootstrap-existing-codebase-prompt.md) | [agent-memory-instructions.md](agent-memory-instructions.md) |
| Session start | Rebuild context before work. | [session-continuity-prompts.md](session-continuity-prompts.md) | Orientation before implementation |
| Feature continuation | Resume an existing multi-session feature. | [feature-continuation-prompt.md](feature-continuation-prompt.md) | Active spec, plan, phase, and issues confirmed |
| Stage 1 | Draft requirements. | [requirements-authoring-prompt.md](requirements-authoring-prompt.md) | [requirements-template.md](../templates/requirements-template.md) |
| Stage 2 | First ambiguity gate. | [open-questions-prompts.md](open-questions-prompts.md) | [open-questions-template.md](../templates/open-questions-template.md) |
| Stage 3 | Draft design spec. | [design-spec-authoring-prompt.md](design-spec-authoring-prompt.md) | [design-spec-template.md](../templates/design-spec-template.md) |
| Stage 3b | Second ambiguity gate. | [open-questions-prompts.md](open-questions-prompts.md) | [open-questions-template.md](../templates/open-questions-template.md) |
| Stage 4 | Create phased implementation plan. | [implementation-plan-authoring-prompt.md](implementation-plan-authoring-prompt.md) | [implementation-plan-template.md](../templates/implementation-plan-template.md) |
| Stage 5 | Implement one phase. | [phase-implementation-prompt.md](phase-implementation-prompt.md) | Scoped code, tests, docs |
| Stage 5 gate | Close or hold phase. | [phase-closure-prompt.md](phase-closure-prompt.md) and [adversarial-auditor-prompt.md](adversarial-auditor-prompt.md) | [phase-gate-checklist.md](../checklists/phase-gate-checklist.md), [adversarial-review-report-template.md](../templates/adversarial-review-report-template.md) |
| Stage 6 | Close session. | [session-continuity-prompts.md](session-continuity-prompts.md) | [session-handout-template.md](../templates/session-handout-template.md), [release-history-entry-template.md](../templates/release-history-entry-template.md) |
| Architect decisions | Answer questions and approve gates. | [architect-guidance.md](architect-guidance.md) | Concrete answers, approvals, deferrals |

## Gate Rules

- Requirements must exist before first-pass open questions.
- First-pass questions must be answered or explicitly deferred before design.
- Design spec must exist before second-pass open questions.
- Second-pass questions must be answered or explicitly deferred before planning.
- Implementation plan must exist before phase implementation.
- Phase implementation must be reviewed before phase closure.
- Session closure must preserve current state before work stops.

## If You Only Use Three Files

For a quick start, use:

1. [agent-memory-instructions.md](agent-memory-instructions.md)
2. One bootstrap prompt:
   - [bootstrap-greenfield-project-prompt.md](bootstrap-greenfield-project-prompt.md)
   - [bootstrap-existing-codebase-prompt.md](bootstrap-existing-codebase-prompt.md)
3. This orchestration guide.

