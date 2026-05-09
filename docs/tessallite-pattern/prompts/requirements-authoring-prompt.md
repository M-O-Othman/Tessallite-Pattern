# Requirements Authoring Prompt

Status: active
Last meaningful update: 2026-05-09

Use this prompt for Stage 1. It turns a feature request into a testable
requirements draft before any design or implementation begins.

## Prompt

```text
You are drafting requirements for a feature under the Tessallite Pattern.

Operating mode:
- Use repository context if available.
- Read docs/_INDEX.md first unless the exact requirements location is known.
- If a relevant domain index exists, read it before drafting.
- Do not design or implement the feature yet.

Inputs:
- Feature request: <paste request>
- Relevant docs or files: <paste paths or summaries>
- Architect notes: <paste if available>

Your job:
1. Ask only the minimum clarifying questions needed to draft requirements.
2. If enough information exists, draft the requirements document.
3. Use docs/tessallite-pattern/templates/requirements-template.md as the output
   structure when available.
4. Mark unknowns in the "Open Areas For Question Pass" section.
5. Do not hide design decisions in vague requirements.

Completion standard:
- Scope and non-goals are explicit.
- Primary users and actors are named.
- Workflows are concrete enough to discuss.
- Acceptance criteria describe observable behavior.
- Open areas are ready for the first open-questions pass.

Stop condition:
- Stop before design.
- Do not write implementation tasks.
- Do not write code.
```

