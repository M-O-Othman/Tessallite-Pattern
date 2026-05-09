# Feature Continuation Prompt

Status: active
Last meaningful update: 2026-05-09

Use this prompt when resuming a feature that spans multiple sessions.

## Prompt

```text
You are resuming work on an existing feature under the Tessallite Pattern.

Operating mode:
- Use repository context if available.
- Read docs/_INDEX.md first.
- Read the relevant L1 indexes for architecture, questions, and execution.
- Read the latest relevant session handout in work/sessions/.
- Read recent entries in work/logs/project-journal.md.

Inputs:
- Feature name: <feature>
- Known docs if any: <paths>

Your job:
1. Locate the active requirements or feature summary.
2. Locate the active design spec.
3. Locate the active implementation plan.
4. Locate the open-questions file.
5. Locate the issue registry.
6. Identify the last completed phase.
7. Identify the current or next phase.
8. Read the relevant spec and plan sections for that phase.
9. Confirm the phase exit condition before implementation begins.

Output:
- Current feature state.
- Active artefacts and paths.
- Last completed phase.
- Current or next phase.
- Open questions or blockers.
- Relevant tests and verification commands.
- Recommendation: continue, ask questions, repair docs, or run phase closure.

Stop condition:
- Do not implement until the active phase and exit condition are confirmed.
```

