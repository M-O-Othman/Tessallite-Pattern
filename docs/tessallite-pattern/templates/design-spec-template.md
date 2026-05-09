# Design Spec Template

Status: draft
Last meaningful update: YYYY-MM-DD

This document is the implementation contract. Implementation planning begins
only after this spec is active and second-pass questions are closed.

Feature:
Architect:
Related requirements:
Related open questions:
Related ADRs:

## 1. Summary

State the chosen design in 5 to 10 sentences.

## 2. Goals

- `<goal>`

## 3. Non-Goals

- `<non-goal>`

## 4. Existing Context

Describe the current system behavior, relevant modules, current contracts, and
known constraints.

## 5. Proposed Architecture

Describe the architecture and the main components.

```text
<optional ASCII diagram>
```

## 6. Component Responsibilities

| Component | Responsibility | Owner | Notes |
| --- | --- | --- | --- |
| `<component>` | `<responsibility>` | `<owner>` | `<notes>` |

## 7. Data Model

### Entity: `<name>`

| Field | Type | Required | Constraints | Notes |
| --- | --- | --- | --- | --- |
| `id` | `<type>` | yes | unique | `<notes>` |

## 8. API Contracts

### Endpoint Or Method: `<name>`

Request:

```json
{
  "example": "value"
}
```

Response:

```json
{
  "example": "value"
}
```

Errors:

| Condition | Code | Message | Notes |
| --- | --- | --- | --- |
| `<condition>` | `<code>` | `<message>` | `<notes>` |

## 9. Validation Rules

| Rule ID | Rule | Error | Ordering |
| --- | --- | --- | --- |
| VAL-001 | `<rule>` | `<error>` | `<when evaluated>` |

## 10. Security And Governance

- authentication:
- authorization:
- data visibility:
- audit logging:
- sensitive data handling:

## 11. Failure Modes

| Failure | Expected Behavior | User/System Impact | Recovery |
| --- | --- | --- | --- |
| `<failure>` | `<behavior>` | `<impact>` | `<recovery>` |

## 12. Migration And Compatibility

- data migration:
- backward compatibility:
- rollout plan:
- rollback plan:

## 13. Observability

- logs:
- metrics:
- traces:
- alerts:

## 14. Test Strategy

| Risk | Test Type | Test Location | Notes |
| --- | --- | --- | --- |
| `<risk>` | unit/integration/e2e | `<path>` | `<notes>` |

## 15. Alternatives Considered

| Option | Pros | Cons | Decision |
| --- | --- | --- | --- |
| `<option>` | `<pros>` | `<cons>` | accepted/rejected |

## 16. Second-Pass Question Triggers

List areas that must be challenged before the spec freezes.

- `<schema ambiguity>`
- `<contract ambiguity>`
- `<validation ambiguity>`

## 17. Approval

Approved by:
Date:
Conditions:

