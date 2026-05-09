# Session Continuity Prompts

Status: active
Last meaningful update: 2026-05-09

Use these prompts to preserve state across sessions.

## Session Start Prompt

```text
Before doing new work:
1. Read docs/_INDEX.md.
2. Read the relevant L1 domain indexes for the work area.
3. Read the latest relevant session handout in work/sessions/.
4. Read the latest relevant project journal entries from
   work/logs/project-journal.md.
5. If a feature is active, read its active requirements, open questions, design
   spec, implementation plan, and issue registry.

Then produce a brief orientation:
- current project state
- last completed work
- known blockers
- next planned action
- files that need attention
- any risks from the previous session
- active feature, active phase, and exit condition when applicable

Do not start implementation until this orientation is complete.
```

## Session Close Prompt

```text
Prepare session close outputs for the next session.

Use docs/tessallite-pattern/templates/session-handout-template.md for the
handoff when available.

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

Also append a dated project journal entry to work/logs/project-journal.md when
the session changed direction, completed significant work, revealed a useful
surprise, or created a decision future sessions need.

For the project journal entry, use a measured 17th-century English ship
captain's log style: factual, compressed, understated, and memorable. The style
is a technical constraint: it forces the entry to name the course, obstruction,
correction, and remaining risk without filler.

Use docs/tessallite-pattern/templates/release-history-entry-template.md when
available.
```

## Project Journal Prompt

```text
Append a dated project journal entry for this session in work/logs/project-journal.md.

Write in a measured 17th-century English ship captain's log style: factual,
compressed, understated, and memorable. Capture:
- what course was set
- what was completed
- what broke or surprised us
- how the course was corrected
- what remains next

Keep it concise. Do not write a chat summary. Write durable project memory.
```
