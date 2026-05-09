# Bootstrap Prompt: Greenfield Project Workspace

Status: active
Last meaningful update: 2026-05-09

Use this prompt when starting a new project workspace and you want the agent to
set up the Tessallite Pattern without reading the entire framework kit first.

## How To Use This File

1. Open your agentic coding tool in the target project workspace.
2. Make `agent-memory-instructions.md` available to the agent by either:
   - copying it into the target workspace next to this prompt,
   - attaching it to the chat, or
   - pasting its contents after the prompt when the agent asks for it.
3. Paste the prompt below into the agent chat.
4. The agent should create the persistent memory file in the target project,
   usually `AGENTS.md`, by copying the contents of
   `agent-memory-instructions.md`.

For persistent agent memory, keep this file next to:

- [agent-memory-instructions.md](agent-memory-instructions.md)

## Prompt To Paste Into The Agent Chat

```text
You are helping bootstrap a new greenfield software project using the
Tessallite Pattern.

Run this from the root of the target project workspace.

Your job is to create the minimum useful project structure and working rules so
future AI-assisted development is verification-first, not generation-first.

Bootstrap order:
1. Install persistent project memory.
2. Create the minimum documentation and log structure.
3. Ask the initial product questions.
4. Stop before writing application code.

Persistent project memory:
- Read the adjacent file `agent-memory-instructions.md`. If it is not present,
  ask me to provide it before continuing.
- Copy its contents into the target project's persistent agent-memory file.
- Use `AGENTS.md` by default.
- If this project already uses another memory file, preserve it and add a
  clearly marked Tessallite Pattern section there instead.
- Do not duplicate the same rules into many files unless I ask for that.

Core principle:
- The bottleneck is verification, not generation.
- Do not start coding until ambiguity is surfaced and the first delivery path is
  clear.

Set up this minimum documentation structure:
- docs/_INDEX.md
- docs/architecture/_INDEX.md
- docs/questions/_INDEX.md
- docs/execution/_INDEX.md
- docs/guides/_INDEX.md
- docs/strategy/_INDEX.md
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
- docs/strategy/: roadmap, positioning, and non-implementation strategy.
- docs/archive/: superseded, duplicate, or closed documents.
- work/sessions/: one handout per meaningful work session.
- work/logs/project-journal.md: durable project journal for significant work,
  discoveries, and course changes.
- scripts/check-docs-index.sh: local guard that checks active docs are listed
  in their domain index.

Create starter documents:
- docs/architecture/architecture_project-overview.md
- docs/questions/questions_initial-project.md
- docs/execution/execution_issue-registry.md
- docs/guides/guides_developer-guide.md
- work/logs/project-journal.md

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

Maintenance rules:
- When a doc is created, add it to its domain `_INDEX.md` immediately.
- When a doc is superseded, move or mark it and update the relevant index.
- When behavior, setup, contracts, or architecture change, update the relevant
  docs in the same phase.
- At session end, write `work/sessions/<date>.md`.
- After significant work or discoveries, append `work/logs/project-journal.md`.
- Before committing documentation changes, run `scripts/check-docs-index.sh`.

Before implementation planning:
1. Produce a short requirements summary.
2. Run a first open-questions pass.
3. Draft architecture/design only after required questions are answered.
4. Run a second open-questions pass after the design draft.
5. Create a phased implementation plan only after required second-pass
   questions are closed or explicitly deferred.

First task:
Ask me only the minimum questions needed to define the greenfield project:
- product goal
- primary users
- core workflows
- target stack
- external systems
- non-goals
- initial delivery milestone

Do not write application code yet. Install project memory first, then bootstrap
the documentation structure and initial open questions.
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
- persistent project memory location and contents installed
- created documentation and log paths
- initial project questions
- proposed docs structure
- no application code
