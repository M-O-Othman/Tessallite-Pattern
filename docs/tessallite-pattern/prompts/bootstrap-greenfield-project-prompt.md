# Bootstrap Prompt: Greenfield Project Workspace

Status: active
Last meaningful update: 2026-05-09

Use this prompt when starting a new project workspace and you want the agent to
set up the Tessallite Pattern without reading the entire framework kit first.

This is the manual prompt path. For the full choice between scripted, guided,
and manual bootstrap, see
[bootstrap-user-journey.md](../bootstrap-user-journey.md). If you already ran a
bootstrap script, use the generated `work/sessions/bootstrap-next-prompt.md` in
the target project instead of asking the assistant to recreate the scaffold.

## How To Use This File

1. Create or open the target project directory in your normal shell.
2. Copy this prompt, `agent-memory-instructions.md`, and optionally
   `project-feedback-rules.md` into the target project, attach those files to
   the agent chat, or be ready to paste their contents when the agent asks for
   them.
3. Open your agentic coding tool from the target project root.
4. Send the prompt below into the agent chat. In a terminal-based tool such as
   Codex or Claude Code, this is chat input, not a shell command.
5. The agent should create the persistent memory file in the target project,
   usually `AGENTS.md`, by copying the contents of
   `agent-memory-instructions.md`.

For a concrete macOS/Codex example, see
[walk-through/walkthrough.md](../../../walk-through/walkthrough.md).

Make `agent-memory-instructions.md` available to the agent by either:
   - copying it into the target workspace next to this prompt,
   - attaching it to the chat, or
   - pasting its contents after the prompt when the agent asks for it.

If the project already has feedback memories, tool-specific rules,
configuration scripts, local tool settings, or reference pointers from another
assistant, also make `project-feedback-rules.md` available so the agent can
convert them into generic project rules.

For persistent agent memory, keep this file next to:

- [agent-memory-instructions.md](agent-memory-instructions.md)
- [project-feedback-rules.md](project-feedback-rules.md)

## Prompt To Send Into The Agent Chat

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

Project feedback rules:
- Ask whether I have existing feedback memories, coding-assistant rules,
  glossary constraints, test rules, UI rules, deployment command constraints,
  publishing scripts, local tool settings, or reference pointers to install.
- If I provide any, convert tool-specific or first-person wording into generic
  project rules that any coding assistant can follow.
- Use `project-feedback-rules.md` as the conversion guide when available.
- Keep short behavioral rules in persistent memory.
- Put long references in indexed docs and link them from memory.
- Keep tool-specific settings such as model choice, plugin lists, permission
  modes, local home-directory paths, and automatic publishing toggles out of
  project memory unless I explicitly ask to document them as local setup.
- If a project-specific feedback rule conflicts with the default Tessallite
  artefact layout, preserve the verification gate and ask me to choose the
  authoritative convention.

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
  in their domain index, and in nested indexes when a nested folder has one.

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
- When a doc is created inside a nested folder with its own `_INDEX.md`, update
  both the domain index and the nested index.
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
- project-specific feedback rules installed or explicitly absent
- created documentation and log paths
- initial project questions
- proposed docs structure
- no application code
