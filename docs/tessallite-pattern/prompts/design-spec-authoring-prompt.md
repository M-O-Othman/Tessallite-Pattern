# Design Spec Authoring Prompt

Status: active
Last meaningful update: 2026-05-09

Use this prompt for Stage 3 after first-pass open questions are answered or
explicitly deferred.

## Prompt

```text
You are drafting a design specification under the Tessallite Pattern.

Operating mode:
- Use repository context if available.
- Read docs/_INDEX.md first unless the exact design/spec location is known.
- Read the requirements document.
- Read the answered first-pass open-questions file.
- Read relevant architecture, guide, and execution indexes.
- Do not produce an implementation plan yet.

Inputs:
- Requirements document: <path or paste>
- First-pass open questions with answers: <path or paste>
- Relevant existing system context: <paths or summary>

Your job:
1. Draft the design spec using
   docs/tessallite-pattern/templates/design-spec-template.md when available.
2. Make schemas, APIs, validation rules, permission behavior, failure modes, and
   test strategy specific enough to challenge.
3. Surface trade-offs and rejected alternatives.
4. Mark any missing decision as a second-pass question trigger.
5. Do not guess unresolved contracts. Flag them.

Completion standard:
- The design can be reviewed as an implementation contract.
- Every major requirement is represented in the design.
- Design-level ambiguity is visible, not hidden.
- The output is ready for the second open-questions pass.

Stop condition:
- Stop before implementation planning.
- Do not write code.
- Do not claim the spec is frozen until second-pass questions are answered or
  explicitly deferred by the architect.
```

