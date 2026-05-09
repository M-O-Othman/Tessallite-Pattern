# Tessallite Pattern Lifecycle Guide

Status: active
Last meaningful update: 2026-05-09

This guide describes the end-to-end feature lifecycle used by the Tessallite
Pattern. It turns the pattern into an executable workflow with artefacts,
owners, gates, and exit conditions.

## Lifecycle Overview

The canonical lifecycle has six stages:

1. High-level requirements conversation
2. First open-questions pass
3. Design specification and second open-questions pass
4. Implementation planning
5. Phase delivery with adversarial review
6. Session close and continuity update

Not every change needs every stage. The lifecycle scales by risk.

## Stage 1: High-Level Requirements

Goal: describe the feature in business terms before implementation detail
appears.

Inputs:

- user request
- product goal
- known constraints
- existing docs and code references
- examples of expected behavior

Output:

- requirements document

The requirements document should answer:

- What problem is being solved?
- Who uses the feature?
- What is in scope?
- What is out of scope?
- What systems or modules are touched?
- What would success look like?
- What must not break?

Gate:

- architect confirms the requirement document is an accurate statement of the
  feature intent

Exit condition:

- the feature can be described without implementation guesses

## Stage 2: First Open-Questions Pass

Goal: surface ambiguity before design begins.

The LLM must list every assumption it would otherwise make. This is not a
brainstorm. It is a gate.

Question categories:

- actors and permissions
- workflows and state transitions
- external integrations
- source-of-truth conflicts
- acceptance criteria
- data ownership
- security and governance rules
- failure behavior
- non-goals and exclusions

Output:

- open-questions file with status `pending`

Gate:

- all questions are answered, narrowed, or explicitly deferred

Exit condition:

- the requirements are clear enough to produce a detailed design spec

## Stage 3: Design Specification

Goal: create the contract that implementation must follow.

The design spec turns the clarified requirements into concrete design:

- architecture
- components
- schemas
- APIs
- validation rules
- permission behavior
- data flow
- error handling
- compatibility concerns
- migration strategy
- observability
- test strategy
- rejected alternatives

After the draft spec is written, run the second open-questions pass.

Second-pass categories:

- exact field names and data types
- nullability
- uniqueness and constraint rules
- ordering of validation checks
- exact HTTP status codes or error identifiers
- compatibility with existing clients
- race conditions
- partial failure behavior
- migration rollback behavior
- cross-module ownership
- examples that contradict the design

Output:

- active design spec
- optional architecture decision record
- updated open-questions file with second-pass answers

Gate:

- architect approves the spec after second-pass questions are resolved

Exit condition:

- implementation can be planned without inventing contracts

## Stage 4: Implementation Plan

Goal: convert the frozen spec into small executable tasks.

A good implementation plan:

- is phase-based
- has exact file paths where known
- maps tasks to spec sections
- gives verification commands
- defines phase exit conditions
- identifies dependency order
- separates risky changes into smaller phases
- names docs that must be updated

Task size:

- each task should be executable in a short, focused interval
- if a task hides several decisions, split it
- if a task requires new design judgment, return to questions or spec

Output:

- implementation plan or action plan

Gate:

- architect confirms the plan implements the spec and can be reviewed phase by
  phase

Exit condition:

- phase 1 can begin without reinterpreting the design

## Stage 5: Phase Delivery And Review

Goal: implement one bounded phase, verify it, and close it only when the
evidence is strong.

For each phase:

1. Read the relevant spec and plan sections.
2. Implement only the scoped phase.
3. Update tests.
4. Update docs if behavior changed.
5. Run local verification commands.
6. Run adversarial review in fresh context.
7. Fix findings or log them.
8. Run the phase gate checklist.
9. Mark the phase complete.

The adversarial auditor should search for:

- unwired code
- incomplete stubs
- spec drift
- missing validation
- missing tests
- incorrect assumptions
- overcomplication
- dead code
- duplicate behavior
- weak error handling
- docs that no longer match behavior

Output:

- code changes
- tests
- documentation updates
- adversarial review report
- issue registry updates

Gate:

- phase gate checklist passes

Exit condition:

- the phase is integrated, tested, documented, and reviewed

## Stage 6: Session Close

Goal: preserve continuity.

Before ending a meaningful session:

1. Create or update the session handout.
2. Record what was completed.
3. Record what was attempted and failed.
4. Record current state.
5. Record blockers.
6. Record next steps.
7. Record key files.
8. Append release history if the session changed direction, delivered a
   significant feature, or revealed important reasoning.

Output:

- session handout at `work/sessions/<date>.md`
- release history entry

Gate:

- another session could resume without reconstructing the conversation

Exit condition:

- continuity is preserved outside the chat transcript

## Lightweight Bug-Fix Path

Use this for small, low-risk fixes.

1. State the bug and expected behavior.
2. Inspect affected code and docs.
3. Implement the fix.
4. Add or update focused tests.
5. Run verification.
6. Update issue registry if the bug was already tracked or not fixed
   immediately.
7. Write a short session handout if the fix involved investigation.

Skip requirements, full spec, and implementation plan unless the bug reveals
larger ambiguity.

## Medium Feature Path

Use this for bounded feature work.

1. Requirements summary
2. First open-questions pass
3. Short design spec
4. Second open-questions pass
5. Action plan
6. One or more reviewed phases
7. Session handout

## Large Subsystem Path

Use this for high-risk or multi-module work.

1. Full requirements
2. First open-questions pass
3. Full design spec
4. Architecture decision record
5. Second open-questions pass
6. Multi-phase implementation plan
7. Per-phase adversarial audit
8. Issue registry updates
9. Documentation index updates
10. User guide or help updates
11. Session handout
12. Release history entry

## Traceability Matrix

For large work, add a traceability table to the implementation plan.

| Spec Section | Plan Task | Test | Documentation | Status |
| --- | --- | --- | --- | --- |
| Example: 4.2 Validation | Phase 2 Task 3 | `test_validation_rules.py` | User guide validation section | pending |

This prevents the plan from becoming detached from the spec.

## Lifecycle Health Signals

Healthy:

- questions become more specific in the second pass
- auditor finds real issues sometimes
- issue registry contains current ownership
- handouts make the next session faster
- docs index check is boring and green

Unhealthy:

- questions are generic
- every review is clean
- phases close without tests
- docs are updated only after release
- handouts say "continue work" without exact next steps
- active indexes point to stale or archived files
