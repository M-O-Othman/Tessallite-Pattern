# Adoption Open Questions

Status: active
Last meaningful update: 2026-05-10

This file captures the first-pass ambiguity found while applying the Tessallite
Pattern to this repository as an existing codebase.

Feature:
Adopt the Tessallite Pattern operationally inside the Tessallite Pattern
framework kit repository.

Owner:
Repository maintainer / architect.

Related docs:

- `docs/architecture/architecture_system-map.md`
- `docs/execution/execution_issue-registry.md`
- `docs/guides/guides_developer-guide.md`
- `walk-through/walkthrough.md`

## Gate Summary

| Pass | Status | Required Before |
| --- | --- | --- |
| First pass | closed | Any broad release, packaging, or governance change |
| Second pass | not started | Implementation plan for a concrete repo feature |

## First Pass: Adoption Questions

| ID | Question | Why It Matters | Owner | Answer | Status |
| --- | --- | --- | --- | --- | --- |
| Q1-001 | Should this repository keep the generic operational domains (`docs/architecture`, `docs/questions`, `docs/execution`, `docs/guides`, `docs/archive`) alongside the framework-kit domain, or should all operational docs live under `docs/tessallite-pattern/`? | This affects L0 routing, future agent context, and whether the repository demonstrates the pattern by using the same folder structure it recommends. | Architect | Keep both layers. The operational domains stay alongside the kit. | resolved |
| Q1-002 | Should walkthrough screenshots be regenerated manually only, or should regeneration be part of a future CI check? | The generator depends on Chrome/Chromium; putting it in CI may add setup cost but catches stale visuals. | Architect | Manual-only for now. Deferred to future CI review. | deferred |
| Q1-003 | Should the repository add markdown link checking in addition to the docs index guard? | The current guard catches missing index entries but not all broken relative links or image references. | Documentation steward | No markdown link checker for now. Deferred. | deferred |
| Q1-004 | Should the source article `tessallite-pattern.md` remain a historical field report even when it diverges from newer kit docs? | The article contains original narrative and may intentionally differ from the operational kit. Future edits need a rule to avoid erasing provenance. | Architect | Source article stays as historical field report. Kit docs are operating truth. | resolved |
| Q1-005 | Should `scripts/generate-walkthrough-assets.js` get a documented Node/Chrome version floor? | The current script uses built-in Node APIs and Chrome flags, but no manifest pins versions. | Maintainer | Document "requires Node 18+ and Chrome/Chromium" in developer guide. | resolved |

## First Pass Closure

Closed by: Architect
Date: 2026-05-10

Remaining deferrals:

- Q1-002 (CI screenshot regeneration): deferred, review when CI is set up.
- Q1-003 (markdown link checker): deferred, review after next doc audit.

## Second Pass: Design-Level Questions

Not started. Run this pass when a concrete repo feature, release process, or CI
change is proposed.
