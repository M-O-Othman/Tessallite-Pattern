# Tessallite Pattern Index

Status: active
Last meaningful update: 2026-05-10

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

For first use, start with
[bootstrap-user-journey.md](bootstrap-user-journey.md). It explains when to use
the fast scripts, the guided walkthrough, or the manual bootstrap prompts
without mixing the paths.

## Core Framework Documents

| File | Purpose |
| --- | --- |
| [framework-handbook.md](framework-handbook.md) | Full explanation of the pattern, principles, roles, gates, artefacts, and operating rules. |
| [bootstrap-user-journey.md](bootstrap-user-journey.md) | Canonical scripted, guided, and manual bootstrap paths for new and existing projects. |
| [bootstrap-file-manifest.md](bootstrap-file-manifest.md) | Canonical file list that every bootstrap path must produce. |
| [lifecycle-guide.md](lifecycle-guide.md) | End-to-end feature delivery lifecycle from high-level requirements through session close. |
| [quality-cycle-readiness.md](quality-cycle-readiness.md) | Readiness check for the complete high-quality code development cycle, including skills and command discipline. |
| [adoption-roadmap.md](adoption-roadmap.md) | Practical rollout plan for teams adopting the pattern gradually. |
| [governance-model.md](governance-model.md) | Rules for ownership, documentation status, gate enforcement, issue registries, and exceptions. |
| [issue-registry.md](issue-registry.md) | Kit-level documentation, governance, and process issues found while maintaining the pattern. |
| [comparison.md](comparison.md) | Comparison against other LLM coding framework categories and when this pattern is worth the overhead. |
| [origin.md](origin.md) | Discovery story showing how the pattern emerged from concrete failures while building Tessallite. |

## Templates

| File | Purpose |
| --- | --- |
| [templates/requirements-template.md](templates/requirements-template.md) | Draft high-level requirements before detail design begins. |
| [templates/open-questions-template.md](templates/open-questions-template.md) | Capture first-pass and second-pass ambiguity before planning freezes. |
| [templates/design-spec-template.md](templates/design-spec-template.md) | Create a frozen implementation contract with schemas, APIs, validation, and trade-offs. |
| [templates/architecture-decision-template.md](templates/architecture-decision-template.md) | Record important architectural choices and alternatives. |
| [templates/implementation-plan-template.md](templates/implementation-plan-template.md) | Convert a frozen spec into sequential implementation phases and tasks. |
| [templates/command-registry-template.md](templates/command-registry-template.md) | Register approved verification, generated-asset, deploy, publish, and wrapper commands. |
| [templates/adversarial-review-report-template.md](templates/adversarial-review-report-template.md) | Report findings from an independent phase auditor. |
| [templates/issue-registry-template.md](templates/issue-registry-template.md) | Track bugs, risks, missing wiring, and unresolved findings. |
| [templates/session-handout-template.md](templates/session-handout-template.md) | Preserve session state for the next working session. |
| [templates/release-history-entry-template.md](templates/release-history-entry-template.md) | Append a durable project journal entry after significant work. |
| [templates/domain-index-template.md](templates/domain-index-template.md) | Create an L1 documentation index for a domain folder. |
| [templates/external-review-report-template.md](templates/external-review-report-template.md) | Report template for cross-agent review findings submitted through the Review Bridge. |

## Checklists

| File | Purpose |
| --- | --- |
| [checklists/phase-gate-checklist.md](checklists/phase-gate-checklist.md) | Decide whether a phase is allowed to close. |
| [checklists/documentation-governance-checklist.md](checklists/documentation-governance-checklist.md) | Keep indexes, summaries, statuses, and archives trustworthy. |
| [checklists/adoption-maturity-scorecard.md](checklists/adoption-maturity-scorecard.md) | Score how strongly a project applies the pattern. |

## Prompts

| File | Purpose |
| --- | --- |
| [prompts/_INDEX.md](prompts/_INDEX.md) | Nested prompt inventory and orchestration guide mapping prompts to lifecycle stages and gates. |
| [prompts/agent-memory-instructions.md](prompts/agent-memory-instructions.md) | Shared persistent project-memory rules for agentic coding tools. |
| [prompts/project-feedback-rules.md](prompts/project-feedback-rules.md) | Generic bootstrap supplement for converting tool-specific feedback memories and reference pointers into assistant-neutral project rules. |
| [prompts/bootstrap-greenfield-project-prompt.md](prompts/bootstrap-greenfield-project-prompt.md) | Quick-start prompt for applying the Tessallite Pattern to a new empty or greenfield workspace. |
| [prompts/bootstrap-existing-codebase-prompt.md](prompts/bootstrap-existing-codebase-prompt.md) | Quick-start prompt for retrofitting the Tessallite Pattern into an existing software codebase. |
| [prompts/requirements-authoring-prompt.md](prompts/requirements-authoring-prompt.md) | Prompt for drafting requirements before the first open-questions gate. |
| [prompts/open-questions-prompts.md](prompts/open-questions-prompts.md) | Prompts for first-pass and second-pass uncertainty surfacing. |
| [prompts/design-spec-authoring-prompt.md](prompts/design-spec-authoring-prompt.md) | Prompt for drafting a design spec after first-pass questions are resolved. |
| [prompts/implementation-plan-authoring-prompt.md](prompts/implementation-plan-authoring-prompt.md) | Prompt for turning an active design spec into a phased implementation plan. |
| [prompts/phase-implementation-prompt.md](prompts/phase-implementation-prompt.md) | Prompt for implementing one scoped phase without drifting from the plan. |
| [prompts/phase-closure-prompt.md](prompts/phase-closure-prompt.md) | Prompt for phase closure and planned-action review. |
| [prompts/adversarial-auditor-prompt.md](prompts/adversarial-auditor-prompt.md) | Independent review prompt for phase-boundary audits. |
| [prompts/feature-continuation-prompt.md](prompts/feature-continuation-prompt.md) | Prompt for resuming a multi-session feature safely. |
| [prompts/session-continuity-prompts.md](prompts/session-continuity-prompts.md) | Prompts for session start, session close, and handout review. |
| [prompts/documentation-router-prompt.md](prompts/documentation-router-prompt.md) | Prompt for using the L0/L1/L2 documentation hierarchy efficiently. |
| [prompts/architect-guidance.md](prompts/architect-guidance.md) | Guidance for architect answers, deferrals, spec approval, and phase closure approval. |

## Guides

| File | Purpose |
| --- | --- |
| [guides/_INDEX.md](guides/_INDEX.md) | Nested index for kit-level workflow guides. |
| [guides/cross-agent-review-workflow.md](guides/cross-agent-review-workflow.md) | Structured cross-agent code review using the Review Bridge MCP server. |

## Examples

| File | Purpose |
| --- | --- |
| [examples/worked-feature-example.md](examples/worked-feature-example.md) | A sample feature moving through requirements, questions, spec, plan, review, and session close. |
| [examples/claude-code-setup-example.md](examples/claude-code-setup-example.md) | Complete CLAUDE.md with Tessallite rules and review bridge workflow. |
| [examples/codex-setup-example.md](examples/codex-setup-example.md) | Complete .codex/config.toml with reviewer instructions and MCP config. |
| [examples/mcp-config-example.md](examples/mcp-config-example.md) | Complete .mcp.json for connecting Claude Code to the review bridge. |
| [walk-through/walkthrough.md](../../walk-through/walkthrough.md) | Synthetic macOS/Codex greenfield bootstrap walkthrough with terminal screenshots. Repository-level asset, not part of the portable kit. |

## Bootstrap Scripts

| File | Purpose |
| --- | --- |
| [scripts/bootstrap-tessallite-pattern.sh](../../scripts/bootstrap-tessallite-pattern.sh) | macOS/Linux bootstrap script for new or existing target projects. |
| [scripts/bootstrap-tessallite-pattern.bat](../../scripts/bootstrap-tessallite-pattern.bat) | Windows bootstrap launcher using the same scaffold through PowerShell. |

## Training

| File | Purpose |
| --- | --- |
| [training/workshop-facilitator-guide.md](training/workshop-facilitator-guide.md) | A half-day workshop plan for teaching the pattern. |
| [training/exercises.md](training/exercises.md) | Hands-on exercises for architects, developers, and auditors. |
