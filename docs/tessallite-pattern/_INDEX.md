# Tessallite Pattern Index

Status: active
Last meaningful update: 2026-05-09

This domain contains the full practical framework kit derived from the source
article. It converts the article's field report into reusable operating
materials for AI-assisted software delivery.

## Current State

The framework is organized around four verification-first controls:

- two-level open-questions gate
- adversarial phase review
- session continuity
- tiered documentation governance with CI enforcement

The materials are ready to use as a starting kit. Teams should adapt names and
folder paths to their own repo, but should preserve the gates unless they have
a deliberate replacement.

## Core Framework Documents

| File | Purpose |
| --- | --- |
| [framework-handbook.md](framework-handbook.md) | Full explanation of the pattern, principles, roles, gates, artefacts, and operating rules. |
| [lifecycle-guide.md](lifecycle-guide.md) | End-to-end feature delivery lifecycle from high-level requirements through session close. |
| [adoption-roadmap.md](adoption-roadmap.md) | Practical rollout plan for teams adopting the pattern gradually. |
| [governance-model.md](governance-model.md) | Rules for ownership, documentation status, gate enforcement, issue registries, and exceptions. |

## Templates

| File | Purpose |
| --- | --- |
| [templates/requirements-template.md](templates/requirements-template.md) | Draft high-level requirements before detail design begins. |
| [templates/open-questions-template.md](templates/open-questions-template.md) | Capture first-pass and second-pass ambiguity before planning freezes. |
| [templates/design-spec-template.md](templates/design-spec-template.md) | Create a frozen implementation contract with schemas, APIs, validation, and trade-offs. |
| [templates/architecture-decision-template.md](templates/architecture-decision-template.md) | Record important architectural choices and alternatives. |
| [templates/implementation-plan-template.md](templates/implementation-plan-template.md) | Convert a frozen spec into sequential implementation phases and tasks. |
| [templates/adversarial-review-report-template.md](templates/adversarial-review-report-template.md) | Report findings from an independent phase auditor. |
| [templates/issue-registry-template.md](templates/issue-registry-template.md) | Track bugs, risks, missing wiring, and unresolved findings. |
| [templates/session-handout-template.md](templates/session-handout-template.md) | Preserve session state for the next working session. |
| [templates/release-history-entry-template.md](templates/release-history-entry-template.md) | Append durable narrative history after significant work. |
| [templates/domain-index-template.md](templates/domain-index-template.md) | Create an L1 documentation index for a domain folder. |

## Checklists

| File | Purpose |
| --- | --- |
| [checklists/phase-gate-checklist.md](checklists/phase-gate-checklist.md) | Decide whether a phase is allowed to close. |
| [checklists/documentation-governance-checklist.md](checklists/documentation-governance-checklist.md) | Keep indexes, summaries, statuses, and archives trustworthy. |
| [checklists/adoption-maturity-scorecard.md](checklists/adoption-maturity-scorecard.md) | Score how strongly a project applies the pattern. |

## Prompts

| File | Purpose |
| --- | --- |
| [prompts/open-questions-prompts.md](prompts/open-questions-prompts.md) | Prompts for first-pass and second-pass uncertainty surfacing. |
| [prompts/adversarial-auditor-prompt.md](prompts/adversarial-auditor-prompt.md) | Independent review prompt for phase-boundary audits. |
| [prompts/session-continuity-prompts.md](prompts/session-continuity-prompts.md) | Prompts for session start, session close, and handout review. |
| [prompts/documentation-router-prompt.md](prompts/documentation-router-prompt.md) | Prompt for using the L0/L1/L2 documentation hierarchy efficiently. |

## Examples

| File | Purpose |
| --- | --- |
| [examples/worked-feature-example.md](examples/worked-feature-example.md) | A sample feature moving through requirements, questions, spec, plan, review, and session close. |

## Training

| File | Purpose |
| --- | --- |
| [training/workshop-facilitator-guide.md](training/workshop-facilitator-guide.md) | A half-day workshop plan for teaching the pattern. |
| [training/exercises.md](training/exercises.md) | Hands-on exercises for architects, developers, and auditors. |

