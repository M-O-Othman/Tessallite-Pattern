# Phase Closure Prompt

Status: active
Last meaningful update: 2026-05-09

Use this prompt at the end of an implementation phase. This is separate from
session close because phases and sessions are not the same thing.

## Prompt

```text
You are evaluating whether a Tessallite Pattern implementation phase can close.

Operating mode:
- Use repository context if available.
- Read the active design spec.
- Read the implementation plan.
- Read the phase implementation summary.
- Read the adversarial review report.
- Read the issue registry.
- Use docs/tessallite-pattern/checklists/phase-gate-checklist.md as the closure
  checklist when available.

Inputs:
- Feature: <name>
- Phase: <phase>
- Spec: <path>
- Plan: <path>
- Implementation summary or diff: <path/summary>
- Adversarial review report: <path/summary>
- Test results: <commands/results>

Your job:
1. Review every planned action for the phase and mark it completed, deferred,
   replaced, skipped with reason, or still pending.
2. Confirm spec alignment.
3. Confirm tests and docs were updated where needed.
4. Confirm review findings are fixed, accepted by the architect, or logged.
5. Confirm unresolved issues have owner, severity, and next action.
6. Decide whether the phase is ready to close.

Output:
- Closure decision: close, close with accepted risk, or keep open.
- Evidence summary.
- Remaining actions.
- Issue registry updates needed.
- Next phase readiness.

Stop condition:
- Do not start the next phase.
- If evidence is incomplete, keep the phase open.
```

