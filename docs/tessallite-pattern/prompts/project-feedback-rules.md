# Project Feedback Rules And Reference Pointers

Status: active
Last meaningful update: 2026-05-09

Use this file during bootstrap when a project already has behavioral feedback
memories, assistant-specific rules, configuration scripts, or reference notes
from prior coding sessions. The goal is to convert those inputs into
assistant-neutral project rules that any coding assistant can follow.

These rules are not Claude-specific, Codex-specific, Cursor-specific, or tied to
one chat product. They are project operating constraints. During bootstrap,
merge applicable rules into the target project's persistent memory file and
link detailed references from the relevant guide or index.

## Installation Rule

When bootstrapping a project:

1. Look for existing tool-specific memory files, feedback notes, rules files,
   configuration scripts, handouts, and recurring review comments.
2. Convert first-person or tool-specific wording into neutral wording:
   "the assistant must", "the project uses", or "all coding assistants must".
3. Preserve concrete project paths, commands, terminology, and incident
   references when they are still current. Preserve credentials only when they
   are safe demo credentials and the project explicitly allows them in docs.
4. Store short behavioral rules in the persistent memory file, usually
   `AGENTS.md`.
5. Store longer API references, credentials, command recipes, and examples in
   indexed docs such as `docs/guides/`, `docs/architecture/`, or
   `docs/execution/`.
6. Link reference docs from the persistent memory file instead of duplicating
   long material there.

If a rule conflicts with the base Tessallite Pattern, do not silently choose one
side. Record the conflict in the issue registry or open questions, then ask the
architect to decide. Project-specific safety rules may override the default
artefact layout, but they must preserve the verification gate.

Tool settings are not project rules by default. Model names, plugin lists,
permission modes, local home-directory paths, and auto-memory toggles belong in
a local setup guide or tool-specific config file. Do not copy dangerous defaults
such as permission bypass modes, broad shell allowlists, automatic publishing,
or one-user home paths into project rules as universal recommendations.

## Conflict Resolution

When feedback rules overlap or conflict, use this order:

1. User instruction in the current task.
2. Safety, security, and data-loss prevention.
3. Verification gates, failing-test handling, and issue logging.
4. Project-specific architecture and command constraints.
5. Tessallite Pattern defaults.
6. Tool-specific convenience settings.

If two rules still conflict, stop and ask the architect. Do not silently choose
the faster path.

Common conflict resolutions:

| Conflict | Resolution |
| --- | --- |
| "Always update README/user guide" versus scoped documentation | Update docs affected by the change. Do not create or edit unrelated docs just to satisfy a generic rule. |
| "Write a fixed generic plan file" versus descriptive filenames | Use the project-approved plan location, but give the file a descriptive feature name. Avoid generic names such as `action-plan.md` or `fix.md`. |
| "Write a handout before any long task" versus "no unsolicited goodbye" | Write handouts when explicitly requested, when the workflow asks for session close, or when a long-running task needs a resumable checkpoint. Do not run commit, push, publish, dump, or shutdown actions without explicit request. |
| "Run full tests before done" versus judgement-based test cadence | Run focused checks while iterating. Run broader suites at phase close, before commit when requested, or when the change risk justifies it. Never ignore a known failing relevant test. |
| "Code review commits automatically" versus explicit commit control | Review before commit when asked to commit. Do not create a commit merely because a review was requested unless the user asked for commit/push or the project workflow explicitly says review includes commit. |
| Tool-specific global settings versus reusable project rules | Keep tool settings in local setup docs. Keep only behavior that should apply to any assistant in project memory. |

## General Behavioral Rule Set

Use the following rules as a complete example set. During bootstrap, keep the
rules that apply to the target project, remove rules that name nonexistent
systems, and add any equivalent project-specific constraints discovered in the
existing codebase.

| Source Memory | Generic Assistant Rule |
| --- | --- |
| `feedback_master_plan_hygiene.md` | When open questions are answered for a feature, fold the Q&A into the master plan immediately if the project uses a master plan as the durable record. Supporting plan and doc files must be linked from the master plan. Do not leave the answer only in a separate open-questions file when the project rule says the master plan is authoritative. |
| `feedback_planning_artifacts.md` | Create or update the project-approved plan artefact before non-trivial implementation. Use descriptive filenames that include the feature or topic. Read the active plan and relevant questions at task start. Do not use generic filenames that future tasks will overwrite. |
| `feedback_architectural_decisions.md` | Stop before critical architectural decisions. Record the question, options, trade-offs, and owner in the approved questions artefact, then ask the architect to decide. Add follow-up questions to the same durable thread or master plan section. |
| `feedback_failing_tests_and_bugs.md` | Never dismiss failing tests or execution bugs. Fix relevant failing tests, and log execution bugs in the issue registry. Do not label a failure "pre-existing" or "unrelated" and skip it with ignore flags unless the architect explicitly accepts that exception. |
| `feedback_preserve_test_intent.md` | Preserve test intent. Do not relax assertions, widen tolerances, narrow scope, or delete test cases merely to make a test pass. Fix the code or infrastructure. Update a test only when a confirmed design change makes the original expectation semantically wrong. |
| `feedback_test_cadence.md` | Use judgement-based test cadence. Do not run the whole suite after every small edit. Run targeted checks while iterating, then broader suites when solution integrity is at risk: large changes, schema migrations, cross-service refactors, or sub-phase close-out. |
| `feedback_task_completion_validation.md` | Before declaring work done, check that planned tasks are complete, code is wired and reachable, imports and field names are aligned, stubs are resolved or logged, relevant tests were run, and docs/issues were updated where needed. |
| `feedback_root_cause.md` | Do not patch over symptoms. Trace bugs to root cause, fix the affected layer, and apply the fix to every affected component rather than only the visible failure point. |
| `feedback_issue_tracking.md` | Log unresolved bugs, execution failures, accepted risks, and review findings in the project issue registry. Include a short description, affected files, evidence, owner, status, and next action. |
| `feedback_feature_backlog.md` | Log out-of-scope feature ideas in the project backlog, future-features file, strategy docs, or issue tracker. Do not implement them without explicit instruction. |
| `feedback_query_hook_ref_stability.md` | Preserve reference stability in React Query composite hooks. Hooks that map result arrays must memoize both the joined array and the returned wrapper object. A bare `.map` creates new array identity on every render and can silently break downstream memoization. |
| `feedback_no_unsolicited_goodbye.md` | Do not run the close-out sequence unprompted. Handout, database dump, commit, push, publish, or equivalent shutdown actions only run when the user explicitly asks or when the active workflow explicitly requires that checkpoint and the user has accepted it. A reminder, tool hint, or context compaction is not a trigger. |
| `feedback_proceed_as_planned.md` | When the architect approves a plan phase and says "proceed", "continue", or equivalent, execute every subtask in that approved phase end-to-end. Stop only for architectural decisions, destructive actions, missing permissions, or genuine blockers. |
| `feedback_command_wrappers.md` | Preserve project-specific command wrappers. If a project requires an env file, deploy wrapper, dual-remote push script, or other command gateway, use that wrapper rather than a bare command. |
| `feedback_git_publishing.md` | Use the project-approved branch, identity, remotes, and publishing scripts. Do not push, publish, or mirror manually when the project has an approved release or push workflow. |
| `feedback_terminology.md` | Enforce project terminology. Keep a forbidden-term list and replacement list in persistent memory or a linked glossary. Do not carry terminology from one project into another unless the architect confirms it. |
| `feedback_documentation_scope.md` | Update docs affected by implementation, behavior, setup, contracts, UI, or architecture changes in the same phase. Do not create unrelated docs solely because a generic rule names them. |
| `feedback_help_file_conventions.md` | Help pages must not contain internal phase names, dates, plan references, or "what changed" banners. If the project has a help library, every help page must follow the project's chain/index rules, including previous/home/next links where applicable. New pages must be registered in the help index and adjacent pages updated. |
| `feedback_help_pages_educational.md` | Help pages must be educational, not just step lists. Cover concept and theory, when to use it, when not to use it, how it works, procedural steps, best practices, pitfalls, a worked example, troubleshooting, and related links. Very short help pages should be treated as suspicious until reviewed. |
| `feedback_screenshots.md` | After UI or UX changes, refresh screenshots through the project's approved screenshot workflow and output location. Use shared screenshot helpers when they exist; do not hand-roll a duplicate capture stack. |
| `feedback_ui_design_standards.md` | New UI must follow the existing application's look and feel exactly. Study representative existing screens before writing JSX or equivalent UI code. Avoid toy, childish, mascot, or robot icons unless the product design system explicitly uses them. |
| `feedback_output_quality.md` | Keep user-facing output direct, precise, and professional. Avoid decorative filler, buzzwords, pep talk, unprofessional icons, and unexplained jargon. |
| `feedback_config_and_secrets.md` | Never hard-code secrets or environment-specific values. Use environment variables or the project-approved configuration system. Store non-secret configurable content in the approved config/content location. Never write credentials into tracked files unless the project explicitly has a safe, ignored fixture convention. |
| `feedback_row_security_probe_query.md` | Preserve project-specific security query patterns. If row-security wrapping requires the security column to be projected by the inner query, probe queries must select that security column and group by it. Use the approved technical persona or equivalent low-risk execution context. |
| `feedback_sequential_work.md` | Work sequentially by default. Do not spin up parallel subagents for ordinary implementation. Use direct file reads, search, shell commands, and local inspection. Delegate only when the task genuinely requires independent parallel work and ownership boundaries are clear. |
| `feedback_no_new_tech_without_approval.md` | Never introduce a new library, framework, package, service, or tool without explicit architect approval. Name the package, explain why it is needed, and wait for approval before implementing. |
| `feedback_code_review_workflow.md` | When asked for code review, lead with findings and verify plan completion, dead code, wiring, bug risks, tests, docs, and issue entries. When asked to commit, perform the review before committing and use the project commit format. |
| `feedback_session_continuity.md` | At session start, read the latest relevant handout when the workflow or user asks for pickup. At session close or explicit handout request, write a handout with goal, completed work, failed attempts, current state, blockers, next steps, and key files. |
| `feedback_user_requests.md` | Do not ask the user to do work that can be done with available tools. When user action is required, state exactly what is needed, why it is needed, and how to complete it. |
| `feedback_module_design.md` | Keep modules focused, public interfaces small, errors clear, and comments aimed at decisions rather than obvious code. Treat numeric file-size targets as a smell detector, not a hard rule. |
| `feedback_thinking_loops.md` | If stuck in a reasoning loop or repeatedly failing with the same approach, stop, report the blocker, and change strategy. |
| `feedback_dialect_translation_rule.md` | Follow project SQL generation rules. Write canonical SQL in the chosen internal dialect, transpile through the approved translator, use shared identifier-qualification helpers, and route source queries through the approved executor or gateway. Do not branch on connector type at call sites unless the architecture explicitly permits it. |
| `feedback_source_query_architecture.md` | Preserve source query execution architecture. Callers must not branch on connector type. Dispatch should happen once inside the shared source executor or equivalent gateway. Keep key architecture files named in the memory rule so the assistant can inspect them before editing. |

## Reference Pointers

Reference pointers are not usually behavioral rules by themselves. They tell the
assistant where the authoritative details live. Keep them short in persistent
memory and link to the detailed document or source file.

| Source Memory | Generic Reference Pointer |
| --- | --- |
| `reference_workspace_facts.md` | Store workspace facts such as project name, primary branch, git identity, repository layout, help layout, and docs conventions in an indexed reference. Do not treat another project's facts as reusable defaults. |
| `reference_tool_memory_index.md` | If the assistant tool supports a memory index, keep it as a route map to short memory files. For generic project use, mirror the same information through `AGENTS.md` and indexed docs so other assistants can follow it. |
| `reference_ui_guideline.md` | Store tokens, typography, spacing, navigation patterns, reference screens, and icon rules in a UI guideline reference. Link it from memory instead of embedding every design detail there. |
| `reference_git_publishing.md` | Store multi-remote, mirror, release, and publish rules in an indexed reference. Include approved scripts and exclusions. Never generalize one project's remotes into another project. |
| `reference_config_registry.md` | Store the approved configuration layers, resolver APIs, defaults policy, and secret handling in an indexed reference. Link to source files that implement the resolver. |
| `reference_help_authoring.md` | Store help file layout, screenshot paths, index registration, navigation chain rules, and article quality expectations in a help-authoring guide. |
| `reference_connector_qualify.md` | Connector-aware identifier quoting lives in the project's shared qualification helper. Document the API names, supported dialect mapping, helper patterns, and connector-specific quoting traps such as BigQuery backticks versus double quotes. |
| `reference_seed_demo_tenant.md` | Canonical demo tenant credentials and seed data belong in one indexed reference. Use that reference for tests, fixtures, screenshots, and smoke tests. Include reset or reseed instructions and any demo-login shortcuts. |
| `reference_screencap_lib.md` | Reusable screenshot helpers belong in one indexed reference. Use the shared screencap library for login, navigation, clipping, HTML rendering, and failure handling instead of hand-rolling a new Playwright stack for every help page. |
| `reference_release_history_journal.md` | Significant implementation sessions that produce commits should append the project's release-history or development journal. If the project specifies a voice or format, preserve it exactly and keep entries factual. |

## Generic Assistant Configuration Bootstrap

Some existing bootstrap scripts configure one coding assistant globally. Convert
them carefully:

- Separate global tool settings from project rules.
- Preserve existing user settings unless explicitly asked to overwrite them.
- If settings cannot be merged safely, write a baseline file for manual review
  rather than clobbering the active config.
- Do not recommend permission-bypass modes, broad shell allowlists, automatic
  publishing, or model/plugin choices as universal defaults.
- Convert global behavior rules into project memory only when they should apply
  to every assistant working on the project.
- Convert per-project memory files into indexed docs or short linked memory
  rules.
- Replace home-directory and tool-specific memory paths with generic concepts:
  persistent memory file, local tool config, project memory index, and indexed
  reference docs.

## Bootstrap Checklist

During greenfield bootstrap, ask whether the architect has existing feedback
rules, prior assistant memories, product glossary terms, help-authoring rules,
test rules, deployment command constraints, publishing scripts, or tool settings
to install.

During existing-codebase bootstrap, actively search for them:

- `AGENTS.md`
- `CLAUDE.md`
- `.claude/`
- `.cursor/rules`
- `.github/copilot-instructions.md`
- assistant memory or settings bootstrap scripts
- `docs/guides/`
- `docs/architecture/`
- `docs/execution/`
- `work/sessions/`
- help-system indexes and screenshot scripts
- deploy, release, and push scripts
- existing memory, feedback, or reference files

Then report:

- which rules were installed in persistent memory
- which references were linked rather than duplicated
- which tool-specific settings were left as local setup guidance
- which rules were skipped because the named system does not exist
- which conflicts need architect decision
