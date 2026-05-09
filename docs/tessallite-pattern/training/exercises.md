# Tessallite Pattern Exercises

Status: active
Last meaningful update: 2026-05-09

These exercises help teams practice the pattern before applying it to critical
work.

## Exercise 1: Rewrite Vague Requirements

Input:

```text
Add a dashboard export feature so users can export reports.
```

Task:

Rewrite this into a requirements summary with:

- actors
- scope
- non-goals
- workflows
- acceptance criteria
- known unknowns

Success criteria:

- no implementation details are invented
- at least five open areas are identified

## Exercise 2: First-Pass Questions

Input:

```text
Users should be able to share saved queries with their team.
```

Task:

Write first-pass open questions.

Include questions about:

- ownership
- permissions
- sharing scope
- revocation
- editing rights
- audit history
- deletion behavior

Success criteria:

- each question explains the risk of guessing
- questions are specific enough for an architect to answer

## Exercise 3: Second-Pass Questions

Input design excerpt:

```text
The share API accepts a query ID and a list of recipients. It creates share
records and sends notifications. Users without access receive an error.
```

Task:

Write second-pass questions.

Look for ambiguity in:

- recipient identity format
- partial success
- duplicate shares
- notification failure
- error codes
- transaction behavior
- permission evaluation time

Success criteria:

- questions focus on implementation-level contracts
- no question is purely generic

## Exercise 4: Phase Plan

Task:

Turn the saved-query sharing feature into a four-phase implementation plan.

Each phase must include:

- goal
- files likely to change
- tasks
- verification
- exit condition

Success criteria:

- phases are reviewable independently
- docs updates are included
- tests map to risks

## Exercise 5: Adversarial Review

Input flawed implementation summary:

```text
The implementation stores share records with query_id and recipient_email.
It checks whether the sender owns the query. It sends notification emails after
the database transaction commits. It returns 200 with all recipient emails.
```

Task:

Audit the implementation against likely requirements.

Find issues related to:

- recipient identity
- team membership
- permission changes
- duplicate shares
- partial failures
- audit logs
- privacy leakage in response body

Success criteria:

- findings have severity
- findings include evidence
- recommendations are actionable

## Exercise 6: Session Handout

Task:

Write a session handout for a day where:

- phase 1 was completed
- phase 2 failed because the API contract was ambiguous
- two tests were added
- one issue remains open
- next session must resolve Q2-004 before coding continues

Success criteria:

- next steps are concrete
- failed attempt is useful
- key files are listed

## Exercise 7: Documentation Routing

Task:

Given a repo with these docs:

```text
docs/_INDEX.md
docs/architecture/_INDEX.md
docs/architecture/architecture_saved-query-sharing.md
docs/execution/_INDEX.md
docs/execution/execution_issue-registry.md
docs/questions/_INDEX.md
docs/questions/questions_saved-query-sharing.md
```

Explain which file an LLM should read first when asked:

1. "What is the status of saved-query sharing?"
2. "Where are open questions tracked?"
3. "What domains exist?"
4. "What bugs are unresolved?"

Success criteria:

- answers follow shortest-path routing
- no unrelated docs are loaded

