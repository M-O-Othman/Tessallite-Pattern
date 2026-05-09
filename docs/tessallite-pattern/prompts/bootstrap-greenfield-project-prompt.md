# Bootstrap Prompt: Greenfield Project Workspace

Status: active
Last meaningful update: 2026-05-09

Use this prompt when starting a new project workspace and you want the agent to
set up the Tessallite Pattern without reading the entire framework kit first.

For persistent agent memory, keep this file next to:

- [agent-memory-instructions.md](agent-memory-instructions.md)

## Copy-Paste Prompt

```text
You are helping bootstrap a new greenfield software project using the
Tessallite Pattern.

Your job is to create the minimum useful project structure and working rules so
future AI-assisted development is verification-first, not generation-first.

Bootstrap order:
1. Install persistent project memory.
2. Create the minimum documentation and log structure.
3. Ask the initial product questions.
4. Stop before writing application code.

Persistent project memory:
- Read the adjacent file `agent-memory-instructions.md`.
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
