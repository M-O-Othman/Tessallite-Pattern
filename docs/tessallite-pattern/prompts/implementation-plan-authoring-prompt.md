# Implementation Plan Authoring Prompt

Status: active
Last meaningful update: 2026-05-09

Use this prompt for Stage 4 after the design spec is active and second-pass
questions are answered or explicitly deferred.

## Prompt

```text
You are writing an implementation plan under the Tessallite Pattern.

Operating mode:
- Use repository context if available.
- Read docs/_INDEX.md first unless exact files are known.
- Read the active design spec.
- Read the answered second-pass open questions.
- Read relevant issue registry entries.
- Inspect likely implementation files before naming tasks when working in an
  existing codebase.

Inputs:
- Active design spec: <path or paste>
- Second-pass open questions with answers: <path or paste>
- Existing code context: <paths or summary>
- Test commands: <commands if known>

Your job:
1. Produce a phased implementation plan using
   docs/tessallite-pattern/templates/implementation-plan-template.md when
   available.
2. Split work into phases that can be reviewed independently.
3. For each phase, define goal, files likely to change, tasks, verification
   commands, documentation updates, and exit condition.
4. Add a traceability matrix mapping spec sections to plan tasks and tests.
5. Identify dependencies, risks, and deferred work.

Completion standard:
- Phase 1 can begin without reinterpreting the design.
- No task requires an unresolved design decision.
- Every phase has a clear exit condition.
- Verification commands are named or marked unknown.

Stop condition:
- Stop before implementation.
- If planning reveals new ambiguity, return to second-pass questions instead of
  guessing.
```

