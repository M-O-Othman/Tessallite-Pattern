# Bootstrap Prompt: Existing Software Codebase

Status: active
Last meaningful update: 2026-05-09

Use this prompt when applying the Tessallite Pattern to an existing project that
already has source code, tests, build tools, and possibly stale or incomplete
documentation.

## Copy-Paste Prompt

```text
You are helping adopt the Tessallite Pattern in an existing software codebase.

Your job is to orient yourself, map the current system, and install
verification-first working discipline without disrupting unrelated code.

Core principle:
- The bottleneck is verification, not generation.
- Existing code is the current source of behavior.
- Existing documentation may be stale until verified against code.

Use these four structural elements:
1. Two-level open-questions gate.
2. Mandatory adversarial review at every non-trivial phase boundary.
3. Session continuity infrastructure.
4. Tiered documentation governance with CI enforcement.

First, inspect before changing:
- repository file tree
- README and existing docs
- package/build/test configuration
- source module boundaries
- test structure
- CI or scripts
- current git status

Do not overwrite or reorganize existing files blindly. If the worktree is dirty,
identify unrelated changes and preserve them.

Create or adapt this documentation structure:
- docs/_INDEX.md
- docs/architecture/_INDEX.md
- docs/questions/_INDEX.md
- docs/execution/_INDEX.md
- docs/guides/_INDEX.md
- docs/archive/_INDEX.md
- work/sessions/
- scripts/check-docs-index.sh

If equivalent folders already exist, reuse them and map them into the L0/L1/L2
router instead of creating duplicates.

Create starter adoption documents:
- docs/architecture/architecture_system-map.md
- docs/questions/questions_adoption-open-questions.md
- docs/execution/execution_issue-registry.md
- docs/execution/execution_release-history.md
- docs/guides/guides_developer-guide.md

The system map should summarize:
- main entry points
- primary modules
- data stores
- external integrations
- public APIs or user workflows
- test commands
- build commands
- deployment or runtime assumptions
- known risks and unclear areas

Before changing product behavior:
1. Produce an adoption orientation from the existing codebase.
2. Identify documentation gaps and stale-doc risks.
3. Create a first-pass open-questions file for the adoption effort.
4. Propose the smallest safe documentation governance setup.
5. Run the docs index checker if available.

For new feature work after adoption:
- write requirements
- run first-pass open questions
- draft design spec
- run second-pass open questions
- create phased implementation plan
- deliver one phase at a time
- run adversarial review before phase closure
- log unresolved findings

For bug fixes:
- inspect the affected code and tests first
- state expected behavior
- make the smallest safe fix
- add or update focused tests
- update issue registry if the bug is not fixed immediately
- write a session handout if investigation was non-trivial

At session end:
- create a handout under work/sessions/<date>.md
- record what was done, what failed, current state, blockers, next steps, and
  key files
- append release history for significant discoveries or changes

First task:
Orient yourself in the codebase and report:
- detected stack
- important directories
- test/build commands
- existing docs
- missing docs
- risks
- recommended first adoption step

Do not make broad refactors. Do not start feature implementation until the
adoption orientation and open questions are complete.
```

## When To Use

Use this prompt when:

- code already exists
- documentation may be incomplete or stale
- you need to retrofit the Tessallite Pattern safely
- you want the agent to inspect before proposing structural changes

## Expected First Output

The agent should produce:

- a codebase orientation
- detected test/build commands
- documentation gap list
- adoption open questions
- no broad code changes

