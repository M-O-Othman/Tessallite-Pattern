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
- docs/_INDEX.md
- docs/architecture/_INDEX.md
- docs/questions/_INDEX.md
- docs/execution/_INDEX.md
- docs/guides/_INDEX.md
- docs/strategy/_INDEX.md
- docs/archive/_INDEX.md
- work/sessions/
- scripts/check-docs-index.sh

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
- initial project questions
- proposed docs structure
- no application code

