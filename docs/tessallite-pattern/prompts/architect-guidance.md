# Architect Guidance

Status: active
Last meaningful update: 2026-05-09

The Tessallite Pattern depends on a strong architect. These instructions define
what useful architect input looks like.

## Answering Open Questions

Good answers are concrete enough to implement and test.

Weak:

```text
Do whatever makes sense.
```

Strong:

```text
Duplicate refresh requests for the same dataset return the existing job with
200. Do not enqueue a second job. Add an idempotency test for this behavior.
```

Each answer should:

- choose one behavior
- name the affected user, field, API, or workflow when relevant
- state error behavior if the question concerns failure
- state whether the answer blocks design or implementation
- avoid ranges unless the implementation is explicitly allowed to choose within
  the range

## Deferrals

If a question cannot be answered now, mark it as a deferral.

Each deferral must include:

- owner
- reason
- review date
- scope narrowing
- what must not be built until the question is answered

## Approving Specs

Before approving a design spec, confirm:

- requirements are represented
- first-pass questions are answered or explicitly deferred
- schemas and contracts are specific enough to test
- failure modes are named
- validation order is clear
- rejected alternatives are recorded
- second-pass questions have been run

## Approving Phase Closure

Before closing a phase, confirm:

- planned actions are complete, deferred, replaced, or skipped with reason
- tests were run or the reason they could not run is recorded
- adversarial review findings are fixed, accepted, or logged
- docs and indexes are updated
- issue registry has owner, severity, and next action for open issues

