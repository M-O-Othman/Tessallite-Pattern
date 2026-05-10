# Prompts Orchestration Guide

Status: active
Last meaningful update: 2026-05-09

Use this file to run the Tessallite Pattern prompts in the right order. The
prompt folder is not a menu of independent prompts. It is an operating sequence
that follows the lifecycle and gate model.

For the first setup decision, start with
[bootstrap-user-journey.md](../bootstrap-user-journey.md). The bootstrap
scripts, walkthrough, and manual prompts are alternatives for initial setup, not
steps to run cumulatively.

## Quick Flow

| Stage | Goal | Prompt | Output Format / Gate |
| --- | --- | --- | --- |
| Bootstrap | Install project memory, project feedback rules, and docs structure. | [bootstrap-greenfield-project-prompt.md](bootstrap-greenfield-project-prompt.md) or [bootstrap-existing-codebase-prompt.md](bootstrap-existing-codebase-prompt.md) | [agent-memory-instructions.md](agent-memory-instructions.md), [project-feedback-rules.md](project-feedback-rules.md) |
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

## Supporting Prompts

| Prompt | Use |
| --- | --- |
| [documentation-router-prompt.md](documentation-router-prompt.md) | Navigate the L0/L1/L2 documentation hierarchy before choosing working context. |

## Prompt Inventory

| File | Purpose |
| --- | --- |
| [agent-memory-instructions.md](agent-memory-instructions.md) | Persistent project-memory rules for agentic coding tools. |
| [project-feedback-rules.md](project-feedback-rules.md) | Generic conversion guide for project-specific feedback rules and reference pointers from any coding assistant. |
| [bootstrap-greenfield-project-prompt.md](bootstrap-greenfield-project-prompt.md) | Bootstrap a new project with the Tessallite Pattern. |
| [bootstrap-existing-codebase-prompt.md](bootstrap-existing-codebase-prompt.md) | Retrofit the Tessallite Pattern into an existing codebase. |
| [requirements-authoring-prompt.md](requirements-authoring-prompt.md) | Draft requirements before design begins. |
| [open-questions-prompts.md](open-questions-prompts.md) | Run first-pass and second-pass ambiguity gates. |
| [design-spec-authoring-prompt.md](design-spec-authoring-prompt.md) | Draft a design spec after first-pass questions are resolved. |
| [implementation-plan-authoring-prompt.md](implementation-plan-authoring-prompt.md) | Turn an active design spec into a phased implementation plan. |
| [phase-implementation-prompt.md](phase-implementation-prompt.md) | Implement one scoped phase without plan drift. |
| [phase-closure-prompt.md](phase-closure-prompt.md) | Decide whether a phase can close. |
| [adversarial-auditor-prompt.md](adversarial-auditor-prompt.md) | Review phase work from an independent auditor stance. |
| [feature-continuation-prompt.md](feature-continuation-prompt.md) | Resume a multi-session feature safely. |
| [session-continuity-prompts.md](session-continuity-prompts.md) | Start and close sessions with durable handoffs. |
| [documentation-router-prompt.md](documentation-router-prompt.md) | Navigate the documentation hierarchy efficiently. |
| [architect-guidance.md](architect-guidance.md) | Guide architect answers, deferrals, and approvals. |


## Gate Rules

- Requirements must exist before first-pass open questions.
- First-pass questions must be answered or explicitly deferred before design.
- Design spec must exist before second-pass open questions.
- Second-pass questions must be answered or explicitly deferred before planning.
- Implementation plan must exist before phase implementation.
- Phase implementation must be reviewed before phase closure.
- Session closure must preserve current state before work stops.

## If You Only Use Four Files

For a quick start, use:

1. [agent-memory-instructions.md](agent-memory-instructions.md)
2. [project-feedback-rules.md](project-feedback-rules.md)
3. One bootstrap prompt:
   - [bootstrap-greenfield-project-prompt.md](bootstrap-greenfield-project-prompt.md)
   - [bootstrap-existing-codebase-prompt.md](bootstrap-existing-codebase-prompt.md)
4. This orchestration guide.

