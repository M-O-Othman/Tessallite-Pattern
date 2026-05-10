# Agent Memory Instructions

Status: active
Last meaningful update: 2026-05-09

Use this file as the persistent working-rules block for agentic coding tools.
During bootstrap, copy this file's contents into the target project's
persistent memory/instructions location.

Recommended default:

- `AGENTS.md`

Use a tool-specific memory file only when the project already standardizes on
one. Examples include `CLAUDE.md`, Codex project instructions, Cursor rules,
Copilot instructions, or another tool-specific memory file.

## Tessallite Pattern Working Rules

This project uses the Tessallite Pattern for AI-assisted delivery.

### Core Rule

- Optimize for verification, not generation.
- Do not treat generated code, specs, tests, or docs as correct until they pass
  the relevant gate.
- If required information is missing, ask questions instead of guessing.

### Project Feedback Rules

- During bootstrap, ask whether project-specific feedback rules, tool-specific
  memories, or reference pointers already exist.
- Convert tool-specific wording into assistant-neutral project rules that any
  coding assistant can follow.
- Keep short behavioral rules in this persistent memory file.
- Keep long references, API details, credentials, and command recipes in indexed
  docs, then link to them from memory.
- Use `docs/tessallite-pattern/prompts/project-feedback-rules.md` as the
  generic conversion guide when bootstrapping from an existing memory pack.
- Project-specific feedback rules may override default artefact placement only
  when the verification gate is preserved and the architect approves the
  convention.
- Do not copy tool-specific permission bypasses, model choices, plugin lists,
  local home-directory paths, or automatic publishing settings into project
  rules unless the architect explicitly wants them documented as local setup.
- When feedback rules conflict, prefer safety, verification, and explicit user
  approval over convenience automation.

### Documentation Routing

- Read `docs/_INDEX.md` first unless you already know the exact document path.
- Use `docs/<domain>/_INDEX.md` to find domain documents.
- Do not bulk-load unrelated docs.
- Treat active docs as current working truth.
- Treat draft docs as provisional.
- Treat archived, superseded, or duplicate docs as historical unless the task
  explicitly asks for history.

### Before Feature Implementation

- Produce requirements before design.
- Run a first open-questions pass after requirements.
- Do not proceed to design while required questions are pending.
- Run a second open-questions pass after detailed design and before planning.
- Do not create an implementation plan while required design-level questions are
  pending.

### Existing Codebase Adoption

When working in an existing codebase:

- Inspect current git status before editing.
- Preserve unrelated user changes.
- Existing code is the current source of behavior until documentation is
  verified against it.
- Prefer existing codebase patterns, frameworks, and helper APIs.
- Identify stale or missing documentation before relying on it.

### Implementation

- Work one phase at a time.
- Implement only the scoped phase.
- Add or update tests for the risk introduced.
- Run the smallest relevant verification command first, then broaden if risk
  requires it.
- Update documentation when behavior, contracts, setup, or architecture changes.
- Log unresolved bugs, risks, missing wiring, or review findings in
  `docs/execution/execution_issue-registry.md`.
- Do not silently skip planned tasks; mark them completed, deferred, replaced,
  or skipped with reason.

### Phase Closure

- A non-trivial phase requires adversarial review before closure.
- The reviewer must be independent of the writing context where possible.
- The review must check spec drift, wiring, tests, docs, known issues, and
  unverifiable assumptions.
- Findings must be fixed, accepted by the architect, or logged before the phase
  closes.

### Documentation Governance

- `docs/_INDEX.md` is the L0 router and lists documentation domains.
- `docs/<domain>/_INDEX.md` is the L1 router and lists active files in that
  domain.
- Durable docs must include title, Status, Last meaningful update, and a short
  summary where useful.
- When creating a doc, add it to the relevant L1 index immediately.
- When creating a doc inside a nested folder that has its own `_INDEX.md`, update
  both the domain L1 index and the nested index.
- Run `scripts/check-docs-index.sh` before committing documentation changes.

### Session Continuity

- At session start, read the latest relevant handout in `work/sessions/` and
  the latest relevant project journal entries in `work/logs/project-journal.md`
  when they exist.
- At session end, create `work/sessions/<date>.md` with goal, completed work,
  failed attempts, current state, blockers, next steps, and key files.
- Append `work/logs/project-journal.md` after significant work, discoveries, or
  course changes.

### Architect Authority

- The architect answers ambiguity and approves gate closure.
- If a gate must be bypassed, record the exception, reason, approver,
  follow-up, and review date.


## Cross-Agent Review Bridge

When the review-bridge MCP server is connected (check with /mcp), use these tools
for cross-agent code review:

- bridge_get_plan: Read the execution plan before reviewing
- bridge_submit_review: Submit review findings with severity counts
- bridge_get_review: Read the latest approved review
- bridge_approve_round: Approve a review for the implementer to act on
- bridge_submit_fixes: Report fixes applied, skipped, and remaining
- bridge_status: Check current round, history, and severity trends
- bridge_stop: End the review cycle

Reviewer agent constraints:
- Write ONLY to work/external-review/
- Do NOT modify source code, tests, or config

Implementer agent constraints:
- Validate each finding before acting
- Fix root cause across all affected files
- Run full test suite before submitting fixes

Prompt templates: docs/tessallite-pattern/guides/cross-agent-review-workflow.md
Report template: docs/tessallite-pattern/templates/external-review-report-template.md