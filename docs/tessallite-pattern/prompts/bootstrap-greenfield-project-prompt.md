# Bootstrap Prompt: Greenfield Project Workspace

Status: active
Last meaningful update: 2026-05-09

Use this prompt when starting a new project workspace and you want the agent to
set up the Tessallite Pattern without reading the entire framework kit first.

## Copy-Paste Prompt

```text
You are helping bootstrap a new greenfield software project using the
Tessallite Pattern.

Your job is to create the minimum useful project structure and working rules so
future AI-assisted development is verification-first, not generation-first.

Core principle:
- The bottleneck is verification, not generation.
- Do not start coding until ambiguity is surfaced and the first delivery path is
  clear.

Use these four structural elements:
1. Two-level open-questions gate.
2. Mandatory adversarial review at every non-trivial phase boundary.
3. Session continuity infrastructure.
4. Tiered documentation governance with CI enforcement.

Set up this documentation structure:
- AGENTS.md
- CLAUDE.md (if Claude Code is used)
- .codex/instructions.md (if Codex project instructions are used)
- .cursorrules (if Cursor is used)
- .github/copilot-instructions.md (if GitHub Copilot is used)
- docs/_INDEX.md
- docs/architecture/_INDEX.md
- docs/questions/_INDEX.md
- docs/execution/_INDEX.md
- docs/guides/_INDEX.md
- docs/strategy/_INDEX.md
- docs/archive/_INDEX.md
- work/sessions/
- scripts/check-docs-index.sh

Create project memory / standing instruction files before feature work:

1. Create `AGENTS.md` at the repository root.
2. If the project uses Claude Code, mirror the same rules into `CLAUDE.md`.
3. If the project uses Codex project instructions, mirror the same rules into
   `.codex/instructions.md`.
4. If the project uses Cursor, mirror the same rules into `.cursorrules`.
5. If the project uses GitHub Copilot, mirror the same rules into
   `.github/copilot-instructions.md`.
6. If another agent tool has a project-memory file, ask me where it lives, then
   add the same rules there.

The project memory file must contain these standing instructions:

```
# Tessallite Pattern Working Rules

This project uses the Tessallite Pattern for AI-assisted delivery.

Core rule:
- Optimize for verification, not generation.
- Do not treat generated code, specs, tests, or docs as correct until they pass
  the relevant gate.

Before feature implementation:
- Read docs/_INDEX.md first unless you already know the exact document path.
- Use docs/<domain>/_INDEX.md to find domain documents.
- Do not bulk-load unrelated docs.
- Produce requirements before design.
- Run a first open-questions pass after requirements.
- Do not proceed to design while required questions are pending.
- Run a second open-questions pass after detailed design and before planning.
- Do not create an implementation plan while required design-level questions
  are pending.

During implementation:
- Work one phase at a time.
- Implement only the scoped phase.
- Add or update tests for the risk introduced.
- Update documentation when behavior, contracts, setup, or architecture changes.
- Log unresolved bugs, risks, missing wiring, or review findings in
  docs/execution/execution_issue-registry.md.
- Do not silently skip planned tasks; mark them completed, deferred, replaced,
  or skipped with reason.

Phase closure:
- A non-trivial phase requires adversarial review before closure.
- The reviewer must be independent of the writing context where possible.
- The review must check spec drift, wiring, tests, docs, known issues, and
  unverifiable assumptions.
- Findings must be fixed, accepted by the architect, or logged before the phase
  closes.

Documentation governance:
- docs/_INDEX.md is the L0 router and lists documentation domains.
- docs/<domain>/_INDEX.md is the L1 router and lists active files in that
  domain.
- Durable docs must include title, Status, Last meaningful update, and a short
  summary where useful.
- When creating a doc, add it to the relevant L1 index immediately.
- Run scripts/check-docs-index.sh before committing documentation changes.

Session continuity:
- At session start, read the latest relevant handout in work/sessions/ and the
  latest relevant release-history entries.
- At session end, create work/sessions/<date>.md with goal, completed work,
  failed attempts, current state, blockers, next steps, and key files.
- Append docs/execution/execution_release-history.md after significant work,
  discoveries, or course changes.

Architect authority:
- The architect answers ambiguity and approves gate closure.
- If required information is missing, ask questions instead of guessing.
- If a gate must be bypassed, record the exception, reason, approver, follow-up,
  and review date.
```

Create starter documents:
- docs/architecture/architecture_project-overview.md
- docs/questions/questions_initial-project.md
- docs/execution/execution_issue-registry.md
- docs/execution/execution_release-history.md
- docs/guides/guides_developer-guide.md

Use these status values:
- draft
- pending
- active
- closed
- superseded
- duplicate
- archived

Every durable document must start with:
- title
- Status
- Last meaningful update
- short summary when useful

Before implementation planning, produce:
1. A short requirements summary.
2. A first-pass open-questions file.
3. A proposed architecture/design spec only after questions are answered.
4. A second-pass open-questions section after the design draft.
5. A phased implementation plan only after the second-pass questions are closed
   or explicitly deferred.

For any implementation phase:
- implement only the scoped phase
- add or update tests
- update documentation if behavior changes
- run verification commands
- run or prepare an adversarial review report
- log unresolved findings in the issue registry
- close the phase only when evidence supports closure

At session end:
- create a session handout under work/sessions/<date>.md
- record what was done, what failed, current state, blockers, next steps, and
  key files
- append release history for significant work

First task:
Ask me only the minimum questions needed to define the greenfield project:
- product goal
- primary users
- core workflows
- target stack
- external systems
- non-goals
- initial delivery milestone

Do not write application code yet. Bootstrap the project discipline first.
Make the project memory / standing instruction file first, then create the docs
structure and initial open questions.
```

## When To Use

Use this prompt when:

- the repository is empty or nearly empty
- architecture is not yet established
- project documentation does not exist
- the team wants the Tessallite Pattern from day one

## Expected First Output

The agent should produce:

- a short orientation
- project memory / standing instructions
- initial project questions
- proposed docs structure
- no application code
