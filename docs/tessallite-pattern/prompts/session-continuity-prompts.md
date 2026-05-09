# Session Continuity Prompts

Status: active
Last meaningful update: 2026-05-09

Use these prompts to preserve state across sessions.

## Session Start Prompt

```text
Before doing new work, read the latest session handout and the latest relevant
release history entries.

Then produce a brief orientation:
- current project state
- last completed work
- known blockers
- next planned action
- files that need attention
- any risks from the previous session

Do not start implementation until this orientation is complete.
```

## Session Close Prompt

```text
Prepare a session handout for the next session.

Include:
- project
- session goal
- what was done
- what was tried and failed
- current state
- blockers
- next steps
- key files
- commands run and results
- anything the next session must not forget

Be specific enough that a new context can resume without reading the chat.
```

## Planned Action Review Prompt

```text
Review the implementation plan and the work completed in this session.

List every planned action and mark it:
- completed
- skipped with reason
- deferred with owner
- replaced by another action
- still pending

Flag any action that appears to have been silently skipped.
```

## Release History Prompt

```text
Append a dated release history entry for this session.

Write in a measured, factual project-journal voice. Capture:
- what course was set
- what was completed
- what broke or surprised us
- how the course was corrected
- what remains next

Keep it concise. Do not write a chat summary. Write durable project memory.
```

