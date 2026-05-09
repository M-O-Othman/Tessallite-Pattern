# Bootstrap Prompt: Existing Software Codebase

Status: active
Last meaningful update: 2026-05-09

Use this prompt when applying the Tessallite Pattern to an existing project that
already has source code, tests, build tools, and possibly stale or incomplete
documentation.

## How To Use This File

1. Open your agentic coding tool in the existing project workspace.
2. Make `agent-memory-instructions.md` available to the agent by either:
   - copying it into the target workspace next to this prompt,
   - attaching it to the chat, or
   - pasting its contents after the prompt when the agent asks for it.
3. Paste the prompt below into the agent chat.
4. The agent should create or update the persistent memory file in the target
   project, usually `AGENTS.md`, by copying the contents of
   `agent-memory-instructions.md`.

For persistent agent memory, keep this file next to:

- [agent-memory-instructions.md](agent-memory-instructions.md)

## Prompt To Paste Into The Agent Chat

```text
You are helping adopt the Tessallite Pattern in an existing software codebase.

Run this from the root of the target project workspace.

Your job is to orient yourself, map the current system, and install
verification-first working discipline without disrupting unrelated code.

Bootstrap order:
1. Inspect the worktree and existing conventions.
2. Install or update persistent project memory.
3. Create or map the minimum documentation and log structure.
4. Produce an adoption orientation and open questions.
5. Stop before broad refactors or feature implementation.

Persistent project memory:
- Read the adjacent file `agent-memory-instructions.md`. If it is not present,
  ask me to provide it before continuing.
- Copy its contents into the target project's persistent agent-memory file.
- Use `AGENTS.md` by default when no memory file exists.
- If an existing memory file exists, preserve current project-specific rules and
  add a clearly marked Tessallite Pattern section there.
- If this project uses another memory mechanism, ask me where it belongs.
- Do not duplicate the same rules into many files unless I ask for that.

Core principle:
- The bottleneck is verification, not generation.
- Existing code is the current source of behavior.
- Existing documentation may be stale until verified against code.

First, inspect before changing:
- current git status
- repository file tree
- README and existing docs
- package/build/test configuration
- source module boundaries
- test structure
- CI or scripts

Do not overwrite or reorganize existing files blindly. If the worktree is dirty,
identify unrelated changes and preserve them.

Create or adapt this minimum documentation structure:
- docs/_INDEX.md
- docs/architecture/_INDEX.md
- docs/questions/_INDEX.md
- docs/execution/_INDEX.md
- docs/guides/_INDEX.md
- docs/archive/_INDEX.md
- work/sessions/
- work/logs/
- scripts/check-docs-index.sh

What this structure is for:
- docs/_INDEX.md: L0 router. Lists documentation domains only.
- docs/architecture/: current architecture, design specs, ADRs, and system maps.
- docs/questions/: first-pass and second-pass open-question gates.
- docs/execution/: issue registry, plans, phase work, and delivery tracking.
- docs/guides/: setup guides, developer guides, user guides, and runbooks.
- docs/archive/: superseded, duplicate, or closed documents.
- work/sessions/: one handout per meaningful work session.
- work/logs/project-journal.md: durable project journal for significant work,
  discoveries, and course changes.
- scripts/check-docs-index.sh: local guard that checks active docs are listed
  in their domain index.

If equivalent folders already exist, reuse them and map them into the L0/L1/L2
router instead of creating duplicates.

Create starter adoption documents:
- docs/architecture/architecture_system-map.md
- docs/questions/questions_adoption-open-questions.md
- docs/execution/execution_issue-registry.md
- docs/guides/guides_developer-guide.md
- work/logs/project-journal.md

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

Maintenance rules:
- When a doc is created, add it to its domain `_INDEX.md` immediately.
- When a doc is superseded, move or mark it and update the relevant index.
- When behavior, setup, contracts, or architecture change, update the relevant
  docs in the same phase.
- At session end, write `work/sessions/<date>.md`.
- After significant work or discoveries, append `work/logs/project-journal.md`.
- Before committing documentation changes, run `scripts/check-docs-index.sh`.
- In an existing codebase, verify docs against source before treating them as
  current truth.

Before changing product behavior:
1. Produce an adoption orientation from the existing codebase.
2. Identify documentation gaps and stale-doc risks.
3. Create a first-pass open-questions file for the adoption effort.
4. Propose the smallest safe documentation governance setup.
5. Run the docs index checker if available.

First task:
Orient yourself in the codebase and report:
- persistent project memory location and whether the Tessallite rules were
  installed
- documentation and log paths created or mapped
- detected stack
- important directories
- test/build commands
- existing docs
- missing docs
- risks
- recommended first adoption step

Do not make broad refactors. Do not start feature implementation until the
adoption orientation and open questions are complete.
```

## When To Use

Use this prompt when:

- code already exists
- documentation may be incomplete or stale
- you need to retrofit the Tessallite Pattern safely
- you want the agent to inspect before proposing structural changes

## Expected First Output

The agent should produce:

- persistent project memory location and contents installed
- documentation and log paths created or mapped
- a codebase orientation
- detected test/build commands
- documentation gap list
- adoption open questions
- no broad code changes
