# Open Questions Prompts

Status: active
Last meaningful update: 2026-05-09

These prompts force uncertainty to the surface before the model starts filling
gaps with plausible guesses.

## First-Pass Prompt

Use after high-level requirements and before detailed design.

```text
You are helping prepare a feature for rigorous AI-assisted delivery.

Read the requirements below. Do not design the solution yet. Your task is to
surface every ambiguity that would cause you to guess during design.

Produce an open-questions file with:
- question ID
- question
- why it matters
- risk if guessed
- suggested owner
- whether the answer blocks design or can be deferred

Use docs/tessallite-pattern/templates/open-questions-template.md as the output
structure when available.

Focus on:
- scope
- actors and permissions
- workflows
- source of truth
- external integrations
- security and governance
- failure behavior
- acceptance criteria
- non-goals

Do not answer your own questions unless the answer is explicitly stated in the
requirements. If something is unclear, mark it unclear.

Gate enforcement:
- If the architect's answer is vague, partial, contradictory, or says "do what
  makes sense," return a follow-up question naming exactly what is still
  unclear.
- Do not mark a blocking question closed until it has a concrete answer or an
  explicit deferral.
- A deferral must include owner, reason, scope narrowing, and review date.
- Do not proceed to design while required first-pass questions remain pending.

Requirements:
<paste requirements>
```

## Second-Pass Prompt

Use after the design spec draft and before implementation planning.

```text
You are reviewing a draft design spec before implementation planning.

Do not praise the spec. Do not write implementation tasks. Your job is to find
the lower-level ambiguity that appears only after schemas, APIs, validation
rules, data flows, and contracts have been written down.

Produce second-pass open questions with:
- question ID
- spec section
- exact ambiguity
- why it matters
- risk if guessed
- suggested owner
- whether it blocks planning

Use docs/tessallite-pattern/templates/open-questions-template.md as the output
structure when available.

Challenge:
- field names and data types
- nullability
- uniqueness and constraints
- validation order
- error codes and messages
- partial failure behavior
- rollback behavior
- concurrency
- compatibility with existing behavior
- examples that contradict the design
- cross-module ownership

Do not resolve ambiguity yourself. Surface it.

Gate enforcement:
- If the architect's answer is vague, partial, contradictory, or says "do what
  makes sense," return a follow-up question naming exactly what is still
  unclear.
- Do not mark a blocking design-level question closed until it has a concrete
  answer or an explicit deferral.
- A deferral must include owner, reason, scope narrowing, and review date.
- Do not proceed to implementation planning while required second-pass
  questions remain pending.

Design spec:
<paste or reference design spec>
```

## Question Quality Test

A good question:

- cannot be answered by generic software knowledge
- names the affected workflow, field, contract, or user
- explains the consequence of guessing
- gives the architect a clear decision to make

Weak:

```text
How should errors be handled?
```

Strong:

```text
Q2-014: In the metric cache refresh API, should a duplicate refresh request for
the same dataset return 409, return the existing job with 200, or enqueue a
second job? This affects idempotency, UI retry behavior, and cache consistency.
```
