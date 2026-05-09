# Requirements Template

Status: draft
Last meaningful update: YYYY-MM-DD

Use this template before detailed design begins. Keep it business-facing. Do not
hide implementation decisions inside vague requirements.

## 1. Feature Name

`<feature-name>`

## 2. Summary

Describe the feature in 5 to 10 sentences.

Include:

- the problem
- the user or system affected
- the desired outcome
- why now

## 3. Primary Users And Actors

| Actor | Goal | Permission Or Constraint |
| --- | --- | --- |
| Example: Workspace admin | Configure the feature | Must have admin role |

## 4. Scope

### In Scope

- `<capability>`
- `<workflow>`
- `<integration>`

### Out Of Scope

- `<explicit non-goal>`
- `<future work>`

## 5. User Workflows

### Workflow 1: `<name>`

1. User starts at `<screen/API/process>`.
2. User performs `<action>`.
3. System responds with `<result>`.
4. User sees or receives `<outcome>`.

## 6. External Systems And Dependencies

| System | Interaction | Constraint |
| --- | --- | --- |
| `<system>` | `<read/write/sync/query>` | `<rate limit/auth/format>` |

## 7. Data And Contract Expectations

List known entities, fields, identifiers, APIs, file formats, or message types.

Do not invent details. Mark unknowns for the open-questions pass.

## 8. Acceptance Criteria

- Given `<context>`, when `<action>`, then `<expected result>`.
- Given `<failure condition>`, when `<action>`, then `<error behavior>`.

## 9. Risks

| Risk | Impact | Mitigation |
| --- | --- | --- |
| `<risk>` | `<impact>` | `<mitigation>` |

## 10. Non-Functional Requirements

- Performance:
- Security:
- Accessibility:
- Observability:
- Reliability:
- Compatibility:

## 11. Open Areas For Question Pass

- `<known ambiguity>`
- `<missing policy>`
- `<unclear edge case>`

## 12. Architect Approval

Approved by:
Date:
Notes:

