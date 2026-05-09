# Workshop Facilitator Guide

Status: active
Last meaningful update: 2026-05-09

This guide runs a half-day workshop for teaching the Tessallite Pattern.

Audience:

- architects
- technical leads
- senior developers
- AI-assisted delivery teams

Duration:

- 3.5 to 4 hours

## Outcomes

Participants should leave able to:

- explain why verification is the bottleneck
- run first-pass and second-pass open questions
- turn a spec into a phase plan
- run an adversarial review
- create a useful session handout
- maintain a tiered docs index

## Agenda

| Time | Segment | Activity |
| --- | --- | --- |
| 00:00-00:20 | Framing | Explain generation vs verification. |
| 00:20-00:50 | Failure modes | Review examples of silent assumptions and spec drift. |
| 00:50-01:25 | Open questions | Group exercise on first-pass questions. |
| 01:25-01:35 | Break |  |
| 01:35-02:15 | Design detail | Run second-pass questions on a sample spec. |
| 02:15-02:50 | Phase planning | Convert spec excerpt into phased plan. |
| 02:50-03:00 | Break |  |
| 03:00-03:30 | Adversarial review | Audit a flawed implementation excerpt. |
| 03:30-03:50 | Continuity | Write a session handout and release note. |
| 03:50-04:00 | Close | Score maturity and choose next adoption step. |

## Materials Needed

- source article or handbook
- worked feature example
- open-questions template
- design-spec template
- implementation-plan template
- adversarial-review template
- phase-gate checklist
- adoption scorecard

## Facilitator Notes

Emphasize that the pattern is not about writing more documents. It is about
making specific failure modes visible early enough to fix.

Watch for these mistakes:

- participants ask vague questions
- participants let the LLM answer its own uncertainty
- participants write a plan before closing questions
- participants treat review as style feedback
- participants skip docs governance because it feels administrative

Correct by asking:

- What would break if the model guessed here?
- Which file or contract would this affect?
- What evidence would close this phase?
- How would a new session find the authoritative answer?

## Closing Exercise

Ask each participant to identify one project where:

- open questions are currently implicit
- docs are likely stale
- review is mostly author self-review
- session context is carried in chat history

Then choose one adoption level from the roadmap and define the first artefact
they will create.

