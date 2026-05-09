# Adversarial Review Report Template

Status: active
Last meaningful update: YYYY-MM-DD

This report is written by a reviewer who did not author the implementation.

Feature:
Phase:
Reviewer:
Implementation owner:
Related spec:
Related plan:
Diff or commit:
Tests reviewed:

## 1. Review Scope

Files inspected:

- `<path>`

Artefacts inspected:

- `<spec>`
- `<plan>`
- `<tests>`
- `<issue registry>`

Out of scope:

- `<item>`

## 2. Executive Finding

Choose one:

- pass
- pass with non-blocking findings
- blocked

Short explanation:

## 3. Findings

| ID | Severity | File/Line | Finding | Evidence | Recommendation | Status |
| --- | --- | --- | --- | --- | --- | --- |
| AR-001 | high | `<path:line>` | `<problem>` | `<evidence>` | `<fix>` | open |

Severity:

- critical: blocks phase closure
- high: must be fixed before phase closure unless accepted by architect
- medium: should be fixed or logged before next phase
- low: can be deferred with owner

## 4. Spec Drift Check

| Spec Requirement | Implementation Evidence | Result |
| --- | --- | --- |
| `<requirement>` | `<file/test>` | pass/fail/unclear |

## 5. Wiring And Integration Check

- entry points wired:
- config updated:
- migrations included:
- API routes registered:
- UI navigation updated:
- tests connected to suite:

## 6. Test Adequacy

Commands reviewed or run:

```bash
<command>
```

Coverage gaps:

- `<gap>`

## 7. Documentation Check

- user-facing docs updated:
- internal docs updated:
- indexes updated:
- stale docs archived:

## 8. Duplicate Or Known Issues

| Finding | Existing Issue | Action |
| --- | --- | --- |
| `<finding>` | `<issue id>` | duplicate/new/update |

## 9. Reviewer Notes

What did the reviewer try to disprove?

- `<challenge>`

## 10. Architect Disposition

Approved to close phase:
Required fixes:
Accepted risks:
Issue registry updates:

