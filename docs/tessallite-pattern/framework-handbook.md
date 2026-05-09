# Tessallite Pattern Framework Handbook

Status: active
Last meaningful update: 2026-05-09

This handbook turns the source article,
[`tessallite-pattern.md`](../../tessallite-pattern.md), into an operating
framework for AI-assisted software delivery. It is written for architects,
technical leads, solo builders, and teams using LLMs on systems where mistakes
compound across many files, contracts, and sessions.

If you are adopting the pattern in a new project, review the
[greenfield walkthrough](../../walk-through/walkthrough.md) first. It shows the
macOS Terminal and Codex sequence for bootstrapping project memory, documentation
indexes, starter docs, and initial product questions before application code.

## 1. Executive Summary

The Tessallite Pattern is a verification-first delivery method for building
software with LLMs.

Its central claim is simple: in serious software work, generation is not the
bottleneck. Verification is.

Modern coding models can generate plans, code, tests, specs, and prose quickly.
The hard work is proving that the output is correct, integrated, consistent with
the design, aligned with existing contracts, and not quietly inventing missing
details. Most AI coding frameworks improve the generation side. The Tessallite
Pattern improves the verification side.

The pattern is not anti-LLM. It assumes LLMs are powerful. It also assumes they
are eager to fill gaps, overstate completeness, and preserve their own mistakes
unless forced through external gates.

## 2. The Problem It Solves

AI coding breaks down at scale for recurring reasons:

- A high-level spec leaves out a detail, and the model silently chooses one.
- A detailed schema exposes new ambiguity after the first requirements pass.
- Generated code implements a slightly different interpretation from the spec.
- Multiple agent roles create the appearance of review without independent
  verification.
- Parallel agents edit overlapping files and create reconciliation work.
- Session context disappears between days.
- Documentation becomes stale, then the model retrieves stale documentation as
  if it were truth.
- Tests exist, but only at the level the model already understood.

The Tessallite Pattern addresses these failure modes directly.

## 3. Design Philosophy

The pattern is built on eight principles.

### Principle 1: Verification Is Load-Bearing

LLM delivery should be designed around proving things, not producing things.
Every important artefact must have a gate that asks whether it is correct,
complete, current, and connected to the rest of the system.

### Principle 2: Ambiguity Must Be Surfaced Twice

One clarification pass is not enough. A high-level feature conversation exposes
one layer of unknowns. A detailed design spec exposes another. Both layers must
be surfaced before implementation planning freezes.

### Principle 3: The Writer Cannot Be The Only Reviewer

The agent that wrote the implementation is biased toward believing it is done.
The pattern uses a fresh-context adversarial reviewer at each phase boundary.

### Principle 4: Parallelism Requires Clear Ownership

Multiple agents can be useful, but only when their ownership boundaries are
clear. The default pattern is sequential implementation with independent audit,
not free-form swarms.

### Principle 5: Documentation Is A Working Cache

Documentation is not a museum. It is the context cache that future LLM sessions
will read. If it drifts, the model's future reasoning drifts with it.

### Principle 6: Session Memory Is An Artefact

The model does not remember yesterday. The team must create durable session
handoffs, journal entries, and action records so reasoning survives.

### Principle 7: Status Must Be Visible

Every important artefact should say whether it is draft, pending, active,
closed, superseded, or archived. Hidden status creates accidental misuse.

### Principle 8: The Architect Owns Judgment

The LLM can draft and audit. The architect decides. The pattern depends on a
human or accountable technical owner who can answer ambiguity, review trade-offs,
and reject plausible but wrong output.

### Principle 9: Local Skills Must Become Project Rules

High-quality code depends on more than generic lifecycle gates. Every serious
codebase has local skills: command wrappers, test expectations, UI standards,
help-file conventions, glossary terms, deployment rules, configuration layers,
SQL architecture, screenshot workflows, and publishing constraints.

During bootstrap, convert those skills into assistant-neutral project rules
using [prompts/project-feedback-rules.md](prompts/project-feedback-rules.md).
Keep short rules in persistent memory and move longer command recipes or
references into indexed docs. This prevents a new coding assistant from
forgetting the hard-won lessons of previous sessions.

## 4. Roles

The pattern uses roles as responsibilities, not theatre. These roles can be
performed by one person, several people, or a human plus LLM assistants.

| Role | Responsibility | Cannot Delegate |
| --- | --- | --- |
| Architect | Owns requirements, trade-offs, gate approval, and final interpretation. | Business judgment, acceptance, priority. |
| Implementer | Converts approved plans into code, docs, and tests. | Claiming phase completion without evidence. |
| Adversarial Auditor | Reviews phase output from fresh context and searches for defects. | Authoring the implementation being reviewed. |
| Documentation Steward | Keeps indexes, statuses, summaries, and archives accurate. | Allowing stale context to remain active. |
| Test Owner | Ensures verification commands and coverage match the risk of the change. | Treating generated tests as proof without inspection. |

In small teams, the architect may wear all human roles. The important rule is
not that every role has a separate person. The important rule is that each
responsibility has a gate and the audit is not performed by the writing context.

## 5. The Four Structural Elements

### 5.1 Two-Level Open-Questions Gate

Most spec-driven workflows ask clarifying questions once, before a spec is
written. The Tessallite Pattern asks twice.

First pass:

- after high-level requirements
- before detailed design
- focused on scope, users, outcomes, integrations, constraints, and policy

Second pass:

- after detailed design draft
- before implementation plan
- focused on schemas, contracts, validation, error handling, data flows,
  ordering rules, compatibility, and edge cases

The model must state what it does not know. The architect must answer. Planning
is blocked until open questions are closed or explicitly deferred.

### 5.2 Mandatory Adversarial Review

At every implementation phase boundary, run an independent review.

The auditor should receive:

- the approved spec or plan
- the changed files or diff summary
- the test files and commands
- known issue registry entries
- relevant documentation indexes

The auditor should produce:

- findings with file paths and line numbers where possible
- severity
- evidence
- recommended fix
- whether the finding appears new, duplicate, or already tracked

The phase closes only after the architect reviews the report, inspects the
diff, runs relevant tests, and logs unresolved findings.

### 5.3 Session Continuity Infrastructure

Every meaningful session should end with a handout. Significant sessions should
also append the project journal at `work/logs/project-journal.md`.

Session handout captures:

- project
- session goal
- work completed
- work attempted and failed
- current state
- blockers
- next steps
- key files

The project journal captures the arc:

- date
- commit hashes or change identifiers
- what was attempted
- what was completed
- what broke
- what was surprising
- what course was set next

The handout is operational state. The journal is reasoning history.

### 5.4 Tiered Documentation Governance For Trustworthy Context

The docs structure acts like a cache hierarchy. The mechanism is tiered
documentation governance with CI enforcement. The goal is trustworthy context:
future LLM sessions should retrieve current, routed, and reviewed docs rather
than stale assumptions.

L0:

- `docs/_INDEX.md`
- lists domains only
- used when the model does not know where to look

L1:

- `docs/<domain>/_INDEX.md`
- summarizes the domain
- lists every active file in the domain, using relative paths for nested files
  when the domain delegates to subfolders
- often enough to answer routing questions without opening L2 files

L2:

- `docs/<domain>/<domain>_<name>.md`
- contains the actual content
- starts with a short summary, status, and last meaningful update

The CI guard checks that L2 files are listed in the domain L1 index and, when a
nested folder has its own `_INDEX.md`, in that nested index too. This turns
documentation hygiene from a preference into a contract and protects the
documentation cache from silent decay.

## 6. Artefact Map

| Stage | Artefact | Status At Creation | Gate |
| --- | --- | --- | --- |
| Requirements | Requirements document | draft | Architect agrees scope is accurate. |
| Questions 1 | Open questions file | pending | Architect answers or defers all items. |
| Design | Design spec | draft | Second-pass questions complete. |
| Decision | Architecture decision record | draft or active | Architect approves selected option. |
| Planning | Implementation plan | active | Tasks map to frozen spec and exit criteria. |
| Delivery | Code, tests, docs | in progress | Phase gate checklist passes. |
| Review | Adversarial review report | active | Findings fixed, accepted, or logged. |
| Registry | Issue registry | active | No untracked blocking issue remains. |
| Continuity | Session handout | closed | Next session can resume from it. |
| History | Project journal entry | active | Significant work has durable narrative. |
| Skills | Project feedback rules | active | Local review feedback, command constraints, and reference pointers are installed as assistant-neutral rules. |
| Commands | Command registry | active | Approved verification, generation, deploy, and publish commands are discoverable before implementation. |

## 7. Status Vocabulary

Use consistent status terms.

| Status | Meaning |
| --- | --- |
| draft | Work is not approved and must not be treated as authoritative. |
| pending | Waiting for answers, review, or decision. |
| active | Authoritative for current work. |
| closed | Complete and retained for history. |
| superseded | Replaced by a newer artefact. |
| duplicate | Kept only to preserve traceability. |
| archived | Removed from active routing. |

## 8. Operating Rules

### Rule 1: No Planning With Pending Questions

If the open-questions file is pending, implementation planning is blocked.
Exceptions must be marked explicitly and revisited before implementation begins.

### Rule 2: No Phase Closure Without Independent Review

A phase can be implemented without an auditor only for trivial changes. The
exception must be written down with the reason.

### Rule 3: No Invisible Bugs

Every defect discovered during implementation or review goes into the issue
registry unless fixed immediately in the same phase and covered by tests.

### Rule 4: No Orphan Documentation

Every active document must be discoverable through its domain index.

### Rule 5: No Stale Summaries

If an L1 index summary materially misrepresents the L2 file, fix the summary
before continuing feature work.

### Rule 6: No Silent Skips

If a planned task is not implemented, mark it skipped, deferred, or replaced.
Do not leave it appearing complete.

### Rule 7: No Unowned Ambiguity

An open question must have an owner. If the architect cannot answer yet, the
question remains pending or the implementation is explicitly narrowed.

### Rule 8: No Unregistered Critical Commands

Critical commands should be discoverable before a phase depends on them. Record
test, build, lint, typecheck, screenshot, help-generation, seed/reset, smoke,
deploy, and publish commands in a command registry such as
[templates/command-registry-template.md](templates/command-registry-template.md).

If a project requires a wrapper, environment file, release script, or
dual-remote publishing command, the assistant must use that approved command
instead of a bare tool invocation.

### Rule 9: No Lost Local Skills

Repeated feedback from prior work should not remain trapped in a single chat or
assistant product. Convert it into project memory:

- short behavioral skills go in the persistent memory file
- long references go in indexed docs
- command recipes go in the command registry or developer guide
- conflicts go to open questions or the issue registry

This includes skills such as preserving test intent, refusing to dismiss failing
tests, using judgement-based test cadence, refreshing screenshots after UI
changes, respecting product terminology, and avoiding new dependencies without
approval.

## 9. When To Use The Pattern

Use the full pattern when:

- a feature touches multiple modules
- a feature creates or changes contracts
- mistakes may corrupt data or user trust
- documentation will be reused by future LLM sessions
- more than one session is needed
- decisions need to be defensible later

Use a lighter version when:

- the change is a small bug fix
- no public contract changes
- no schema or data migration
- blast radius is limited

Do not use the full pattern for:

- throwaway scripts
- one-off experiments
- disposable prototypes
- tasks where formal gates cost more than the failure

## 10. Scaling The Pattern

### Solo Builder

The solo builder acts as architect and steward. Use all templates, but keep
them short. The most important pieces are the two question passes, phase audit,
and session handout.

### Small Team

Assign a human owner for architecture, delivery, testing, and docs. Keep the
gate checklist mandatory. Rotate the adversarial auditor prompt from
[prompts/_INDEX.md](prompts/_INDEX.md) through a fresh LLM session.

### Larger Team

Turn the artefacts into repository policy. Run index checks in CI. Require
issue registry updates in pull requests. Assign documentation ownership per
domain.

## 11. Failure Modes And Corrections

| Failure Mode | Symptom | Correction |
| --- | --- | --- |
| Question pass becomes shallow | Questions are generic and answerable without domain knowledge. | Force examples, field names, contracts, edge cases, and existing module references. |
| Spec becomes decorative | Implementation plan ignores spec details. | Add a traceability section mapping tasks to spec sections. |
| Auditor rubber-stamps work | Review says "looks good" with no evidence. | Require severity table, file references, and "what I tried to disprove" section. |
| Issue registry becomes a backlog dump | Old findings remain open with no owner. | Add owner, next action, and review date fields. |
| Handouts become vague | Next session cannot resume. | Require exact current state, key files, and next command or action. |
| Docs index drifts | File exists but is not discoverable. | Run `scripts/check-docs-index.sh` locally and in CI. |
| Local skills are not installed | A new assistant repeats old mistakes or runs unsafe bare commands. | Bootstrap with [prompts/project-feedback-rules.md](prompts/project-feedback-rules.md) and keep a command registry. |
| Command rules live only in chat | Tests, deploys, screenshots, or publishing are run inconsistently. | Register approved commands and wrappers in [templates/command-registry-template.md](templates/command-registry-template.md). |
| Team overuses the pattern | Small changes become slow. | Apply the lightweight path for low-risk work. |

## 12. Definition Of Done

A feature is done when:

- requirements match the agreed business goal
- both open-question passes are closed or explicitly deferred
- design spec is active and implementation reflects it
- implementation plan tasks are complete, skipped with reason, or superseded
- tests cover the risk introduced
- approved command wrappers and verification commands were used
- adversarial review findings are fixed or tracked
- user-facing and internal docs are updated
- indexes point to the new or changed docs
- session handout records current state
- `work/logs/project-journal.md` captures the work if it was significant

For a full cycle check, use
[quality-cycle-readiness.md](quality-cycle-readiness.md). It maps the lifecycle,
skills layer, command discipline, verification points, and remaining
recommended improvements into one readiness view.

## 13. The Short Version

Name your gates. Run your gates. Keep documentation trustworthy. Make ambiguity
visible before code exists. Make implementation prove itself after each phase.
Treat session memory as an artefact. Do not let generated confidence substitute
for verification.
