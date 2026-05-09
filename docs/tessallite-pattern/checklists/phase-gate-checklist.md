# Phase Gate Checklist

Status: active
Last meaningful update: 2026-05-09

Use this checklist before closing an implementation phase. A phase should not
close just because code exists.

Feature:
Phase:
Reviewer:
Date:

## 1. Scope

- [ ] The phase goal is stated.
- [ ] The phase only includes work approved for this phase.
- [ ] Any extra work is recorded as a follow-up or explicitly approved.
- [ ] No planned task is silently skipped.

## 2. Spec Alignment

- [ ] The implementation maps to the approved spec.
- [ ] Any spec deviation is documented and approved.
- [ ] Field names, types, validation rules, and contracts match the spec.
- [ ] Error behavior matches the spec.
- [ ] Non-goals remain out of scope.

## 3. Implementation Quality

- [ ] No unwired entry points.
- [ ] No incomplete stubs pretending to be complete.
- [ ] No dead code introduced.
- [ ] No duplicate implementation of existing behavior.
- [ ] Failure paths are handled.
- [ ] Configuration and registration steps are complete.

## 4. Tests

- [ ] Relevant unit tests were added or updated.
- [ ] Integration tests were added or updated where contracts changed.
- [ ] Edge cases from open questions are tested where practical.
- [ ] Verification commands were run.
- [ ] Test failures are fixed or documented with owner and next action.

## 5. Adversarial Review

- [ ] Fresh-context adversarial review was performed.
- [ ] Review report includes findings, severity, evidence, and recommended fix.
- [ ] Known issues were checked to avoid duplicate findings.
- [ ] Blocking findings are fixed.
- [ ] Non-blocking findings are logged or explicitly accepted.

## 6. Documentation

- [ ] User-facing docs are updated if behavior changed.
- [ ] Internal docs are updated if contracts or architecture changed.
- [ ] L1 index entries are added or updated where needed.
- [ ] Superseded docs are archived or marked.
- [ ] The docs index checker passes if enabled.

## 7. Issue Registry

- [ ] New bugs are logged unless fixed immediately and covered by tests.
- [ ] Existing related issues are updated.
- [ ] Every open issue has owner, severity, and next action.

## 8. Closure Decision

Decision:

- [ ] close phase
- [ ] close with accepted risk
- [ ] keep phase open

Architect notes:

Required follow-up:

