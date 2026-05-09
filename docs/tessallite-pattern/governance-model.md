# Tessallite Pattern Governance Model

Status: active
Last meaningful update: 2026-05-09

This document defines the rules that keep the Tessallite Pattern operational:
ownership, gate enforcement, artefact status, documentation governance, and
exceptions.

## Governance Objective

The governance model exists to protect one property: trustworthy context. The
mechanism is tiered documentation governance with CI enforcement; the reason is
that future LLM sessions will treat project documentation as a working cache.

If the artefacts are current, routed, and reviewed, the LLM has a reliable
working cache. If the artefacts drift, the model will retrieve old assumptions
and produce plausible errors.

## Ownership

| Area | Owner | Responsibility |
| --- | --- | --- |
| Requirements | Architect | Confirms the business problem and scope. |
| Open questions | Architect | Answers, defers, or narrows ambiguity. |
| Design spec | Architect | Approves technical contract. |
| Implementation plan | Implementer plus architect | Ensures tasks map to the approved spec. |
| Phase review | Auditor plus architect | Finds defects and decides closure. |
| Issue registry | Delivery owner | Tracks unresolved problems to closure. |
| Documentation indexes | Documentation steward | Keeps docs discoverable and statuses accurate. |
| Session handout | Current session owner | Preserves working state. |
| Project journal | Architect or lead | Captures durable reasoning and course changes in `work/logs/project-journal.md`. |

## Gate Policy

### Gate A: Requirements Approval

Required before first open-questions pass is treated as complete.

Evidence:

- requirements document exists
- scope and non-goals are named
- known systems and actors are listed

### Gate B: First Questions Closure

Required before design spec.

Evidence:

- open-questions file exists
- every question has an answer, deferral, or scope narrowing
- unresolved questions have owner and review date

### Gate C: Design Freeze

Required before implementation plan.

Evidence:

- design spec is active
- second-pass questions are complete
- major trade-offs are recorded
- contracts are specific enough to test

### Gate D: Plan Approval

Required before implementation.

Evidence:

- plan is phase-based
- tasks have file targets where possible
- exit criteria are explicit
- verification commands are named
- docs updates are identified

### Gate E: Phase Closure

Required before moving to the next phase.

Evidence:

- scoped implementation is complete
- tests run or the reason they could not run is recorded
- adversarial review is complete
- findings are fixed, accepted, or logged
- docs and indexes are updated if affected

### Gate F: Session Closure

Required before stopping significant work.

Evidence:

- session handout exists or is updated
- next steps are specific
- blockers are explicit
- `work/logs/project-journal.md` is appended if the session was significant

## Artefact Status Rules

Every durable artefact should begin with:

```markdown
Status: draft
Last meaningful update: YYYY-MM-DD
```

Allowed statuses:

- `draft`: not authoritative
- `pending`: awaiting answers, review, or decision
- `active`: authoritative for current work
- `closed`: complete and retained
- `superseded`: replaced by newer artefact
- `duplicate`: retained for traceability only
- `archived`: removed from active routing

Status changes should be meaningful. Do not update the date for whitespace-only
changes.

## Documentation Naming Rules

Recommended file name pattern:

```text
<domain>_<descriptive-name>.md
```

Rules:

- lowercase
- hyphens between words
- no spaces
- no brackets
- no capitals
- archived files should include a visible reason suffix when useful, such as
  `__superseded` or `__duplicate`

## Index Governance

### L0 Index

`docs/_INDEX.md` lists domain folders only. It should not become a dumping
ground of every file.

### L1 Index

`docs/<domain>/_INDEX.md` lists active files in that folder and gives a domain
summary.

Update L1 when:

- a file is created
- a file is archived
- a file's purpose changes
- the domain summary becomes inaccurate

Do not update L1 for routine edits that do not change the file purpose.

### L2 Documents

Every L2 document starts with:

- title
- status
- last meaningful update
- 3 to 5 line summary where useful

## Issue Registry Rules

An issue registry entry should include:

- ID
- date opened
- severity
- status
- owner
- source
- affected files
- description
- evidence
- recommended fix
- resolution notes

No issue should remain open without an owner.

Severity:

- `critical`: blocks release or risks data/security failure
- `high`: likely user-visible defect or serious integration risk
- `medium`: correctness, maintainability, or test gap that should be fixed soon
- `low`: minor improvement or documentation gap

Status:

- `open`
- `in-progress`
- `fixed`
- `accepted-risk`
- `duplicate`
- `wont-fix`

## Exception Policy

Exceptions are allowed, but must be visible.

Use an exception when:

- change is low-risk and full lifecycle is disproportionate
- urgent production fix must move before full documentation
- external dependency blocks a gate
- a question is intentionally deferred by narrowing scope

Each exception must include:

- what gate was skipped or shortened
- why
- who approved it
- what follow-up is required
- review date

## CI Governance

Minimum CI check:

```bash
bash scripts/check-docs-index.sh
```

The check should fail when an active Markdown file in a domain folder is not
listed in that domain's `_INDEX.md`.

Recommended additional checks:

- markdown linting
- link checking
- status vocabulary check
- orphaned issue registry entries without owner
- stale pending question files older than a chosen threshold

## Governance Review Cadence

For active projects:

- review open questions weekly
- review issue registry weekly
- review docs index failures on every PR
- review `work/logs/project-journal.md` at sprint or milestone boundaries
- archive superseded artefacts monthly

For solo projects:

- review pending questions before each major session
- run docs index check before commits
- append `work/logs/project-journal.md` after meaningful changes

## Governance Health Questions

Ask these regularly:

- Can a new session find the authoritative design without chat history?
- Are active docs actually active?
- Do pending questions block implementation?
- Are review findings tracked to closure?
- Are indexes useful, or just decorative?
- Does `work/logs/project-journal.md` explain why the project changed course?
- Can the architect defend the latest spec against the latest code?
