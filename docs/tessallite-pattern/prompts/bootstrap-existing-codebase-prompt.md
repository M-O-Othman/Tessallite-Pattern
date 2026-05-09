# Bootstrap Prompt: Existing Software Codebase

Status: active
Last meaningful update: 2026-05-09

Use this prompt when applying the Tessallite Pattern to an existing project that
already has source code, tests, build tools, and possibly stale or incomplete
documentation.

## Copy-Paste Prompt

```text
You are helping adopt the Tessallite Pattern in an existing software codebase.

Your job is to orient yourself, map the current system, and install
verification-first working discipline without disrupting unrelated code.

Core principle:
- The bottleneck is verification, not generation.
- Existing code is the current source of behavior.
- Existing documentation may be stale until verified against code.

Use these four structural elements:
1. Two-level open-questions gate.
2. Mandatory adversarial review at every non-trivial phase boundary.
3. Session continuity infrastructure.
4. Tiered documentation governance with CI enforcement.

First, inspect before changing:
- repository file tree
- README and existing docs
- package/build/test configuration
- source module boundaries
- test structure
- CI or scripts
- current git status

Do not overwrite or reorganize existing files blindly. If the worktree is dirty,
identify unrelated changes and preserve them.

Create or adapt this documentation structure:
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
- docs/archive/_INDEX.md
- work/sessions/
- scripts/check-docs-index.sh

If equivalent folders already exist, reuse them and map them into the L0/L1/L2
router instead of creating duplicates.

Create or update project memory / standing instruction files before feature
work:

1. Create or update `AGENTS.md` at the repository root.
2. If the project uses Claude Code, mirror the same rules into `CLAUDE.md`.
3. If the project uses Codex project instructions, mirror the same rules into
   `.codex/instructions.md`.
4. If the project uses Cursor, mirror the same rules into `.cursorrules`.
5. If the project uses GitHub Copilot, mirror the same rules into
   `.github/copilot-instructions.md`.
6. If another agent tool has a project-memory file, ask me where it lives, then
   add the same rules there.
7. If a project memory file already exists, preserve existing project-specific
   rules and add a clearly marked Tessallite Pattern section. Do not delete
   existing instructions unless I approve.

The project memory section must contain these standing instructions:

```
# Tessallite Pattern Working Rules

This project uses the Tessallite Pattern for AI-assisted delivery.

Core rule:
- Optimize for verification, not generation.
- Existing code is the current source of behavior until documentation is
  verified against it.
- Do not treat generated code, specs, tests, or docs as correct until they pass
  the relevant gate.

Before changing behavior:
- Inspect current git status and preserve unrelated user changes.
- Read README and existing docs.
- Read docs/_INDEX.md first if it exists; otherwise create it during adoption.
- Use docs/<domain>/_INDEX.md to find domain documents when available.
- Do not bulk-load unrelated docs.
- Identify stale or missing documentation before relying on it.
- Produce requirements before design for non-trivial feature work.
- Run a first open-questions pass after requirements.
- Do not proceed to design while required questions are pending.
- Run a second open-questions pass after detailed design and before planning.
- Do not create an implementation plan while required design-level questions
  are pending.

During implementation:
- Work one phase at a time.
- Implement only the scoped phase.
- Prefer existing codebase patterns, frameworks, and helper APIs.
- Add or update tests for the risk introduced.
- Run the smallest relevant verification command first, then broaden if risk
  requires it.
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
  latest relevant release-history entries if they exist.
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

Create starter adoption documents:
- docs/architecture/architecture_system-map.md
- docs/questions/questions_adoption-open-questions.md
- docs/execution/execution_issue-registry.md
- docs/execution/execution_release-history.md
- docs/guides/guides_developer-guide.md

The system map should summarize:
- main entry points
- primary modules
- data stores
- external integrations
- public APIs or user workflows
- test commands
- build commands
- deployment or runtime assumptions
- known risks and unclear areas

Before changing product behavior:
1. Produce an adoption orientation from the existing codebase.
2. Identify documentation gaps and stale-doc risks.
3. Create a first-pass open-questions file for the adoption effort.
4. Propose the smallest safe documentation governance setup.
5. Run the docs index checker if available.

For new feature work after adoption:
- write requirements
- run first-pass open questions
- draft design spec
- run second-pass open questions
- create phased implementation plan
- deliver one phase at a time
- run adversarial review before phase closure
- log unresolved findings

For bug fixes:
- inspect the affected code and tests first
- state expected behavior
- make the smallest safe fix
- add or update focused tests
- update issue registry if the bug is not fixed immediately
- write a session handout if investigation was non-trivial

At session end:
- create a handout under work/sessions/<date>.md
- record what was done, what failed, current state, blockers, next steps, and
  key files
- append release history for significant discoveries or changes

First task:
Orient yourself in the codebase and report:
- detected stack
- important directories
- test/build commands
- existing docs
- missing docs
- risks
- recommended first adoption step

Do not make broad refactors. Do not start feature implementation until the
adoption orientation and open questions are complete.
Make or update the project memory / standing instruction file first, then
perform the adoption orientation.
```

## When To Use

Use this prompt when:

- code already exists
- documentation may be incomplete or stale
- you need to retrofit the Tessallite Pattern safely
- you want the agent to inspect before proposing structural changes

## Expected First Output

The agent should produce:

- a codebase orientation
- project memory / standing instructions
- detected test/build commands
- documentation gap list
- adoption open questions
- no broad code changes
