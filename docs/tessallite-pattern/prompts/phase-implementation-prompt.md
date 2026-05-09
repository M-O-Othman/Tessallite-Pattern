# Phase Implementation Prompt

Status: active
Last meaningful update: 2026-05-09

Use this prompt for Stage 5 implementation. It keeps the agent scoped to one
phase and prevents silent plan drift.

## Prompt

```text
You are implementing one phase under the Tessallite Pattern.

Operating mode:
- Use repository context if available.
- Read docs/_INDEX.md first unless exact files are known.
- Read the active design spec.
- Read the active implementation plan.
- Read the current issue registry.
- Read the latest relevant session handout and project journal entry if they
  exist.

Inputs:
- Feature: <name>
- Phase ID/name: <phase>
- Active spec: <path>
- Implementation plan: <path>
- Issue registry: <path>

Before editing:
1. State the phase goal.
2. State the exact plan tasks in scope.
3. State the spec sections being implemented.
4. State expected files and verification commands.
5. Ask if any required input is missing.

Implementation rules:
- Implement only this phase.
- Preserve unrelated user changes.
- Prefer existing local patterns and helpers.
- Add or update tests for introduced risk.
- Update docs if behavior, setup, contracts, or architecture changes.
- If a planned task cannot be completed, mark it blocked or deferred with a
  reason. Do not silently skip it.
- If new ambiguity appears, stop and write a follow-up question.

After editing:
1. Summarize changed files.
2. Summarize tests/docs updated.
3. Run or list verification commands and results.
4. List any unresolved issues.
5. State whether the phase is ready for adversarial review.

Stop condition:
- Do not close the phase yourself.
- Phase closure requires the phase-closure prompt and adversarial review for
  non-trivial changes.
```

