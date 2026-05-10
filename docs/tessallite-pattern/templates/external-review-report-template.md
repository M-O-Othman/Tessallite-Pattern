# External Review Report Template

Use this template when submitting review findings through the Review Bridge MCP server or when writing review reports manually.

---

```markdown
# External Review Report - Round [N]

Plan reviewed: [path to plan file]
Reviewer: [agent name / model]
Date: [YYYY-MM-DD]

## Summary

[One paragraph: what was reviewed, overall assessment, most significant finding.]

## Findings

### [File or Module Name]

- [CRITICAL/HIGH/MEDIUM/LOW/INFO] Short description of the issue
  Location: [file path]:[line number or function name]
  Expected: [what the plan or correct behavior requires]
  Actual: [what the code does or is missing]
  Recommendation: [specific fix or approach]

- [SEVERITY] Next finding in the same file
  Location: ...
  Expected: ...
  Actual: ...
  Recommendation: ...

### [Next File or Module]

- [SEVERITY] ...

## Unimplemented Plan Items

List any tasks from the execution plan that have no corresponding implementation:

- [ ] [Plan task description] (plan section reference)

## Cross-Cutting Concerns

Issues that span multiple files or modules:

- [SEVERITY] Description
  Affected files: [list]
  Recommendation: ...

## Severity Summary

- Critical: [N]
- High: [N]
- Medium: [N]
- Low: [N]
- Info: [N]
- Total: [N]

## Severity Scale

- Critical: data loss, security vulnerability, crash in production
- High: incorrect behavior, broken feature, missing implementation from plan
- Medium: edge case not handled, inconsistent naming, missing validation
- Low: code style, minor optimization, documentation gap
- Info: observation, suggestion, no action required
```
