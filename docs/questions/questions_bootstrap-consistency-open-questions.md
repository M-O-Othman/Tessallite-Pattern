# Bootstrap Consistency Open Questions

Status: pending
Last meaningful update: 2026-05-10

These questions must be answered before the consistency fix plan can be executed.
They affect which files, names, and content sections become the canonical standard.

## Architect Decisions Required

| ID | Question | Why It Matters | Options | Default If Deferred |
| --- | --- | --- | --- | --- |
| Q-BC-001 | What should the canonical AGENTS.md content be: the short form (6 sections, currently in scripts) or the full form (10 sections + review bridge, currently in agent-memory-instructions.md)? | The scripted and manual paths install different rule sets. Users who pick the script path get fewer gates. | A) Full form everywhere. Scripts install everything that agent-memory-instructions.md has. B) Short form everywhere. Scripts keep current content. agent-memory-instructions.md is trimmed. C) Tiered: script installs core, manual prompt installs full. | A (full form everywhere) |
| Q-BC-002 | For the --existing mode, should the script create `architecture_system-map.md` (as the existing-codebase prompt does) or `architecture_project-overview.md` (as the script currently does)? | The existing-codebase prompt and the script disagree on the starter architecture file name. | A) `architecture_system-map.md` for --existing, `architecture_project-overview.md` for --greenfield. B) Same name for both modes: `architecture_project-overview.md`. C) Same name for both modes: `architecture_system-map.md`. | A (mode-dependent names) |
| Q-BC-003 | Should the --existing mode create `questions_adoption-open-questions.md` (as the existing-codebase prompt does) or `questions_initial-project.md` (as the script currently does)? | Same naming conflict as Q-BC-002 but for the questions starter file. | A) Mode-dependent: adoption questions for --existing, initial-project for --greenfield. B) Same file name for both. | A (mode-dependent names) |
| Q-BC-004 | Where should the cross-agent review prompts live? Currently there is a guide at `docs/guides/cross-agent-review-prompts.md`, but `AGENTS.md` references `docs/tessallite-pattern/prompts/cross-agent-review-prompts.md` which does not exist. | The link is broken. The material needs one canonical location. | A) Keep in `docs/guides/`, fix the AGENTS.md reference. B) Move to `docs/tessallite-pattern/prompts/`, update the guides index. | A (keep in guides, fix reference) |
| Q-BC-005 | Should the `docs/tessallite-pattern/templates/_index.md` file (lowercase) be renamed to `_INDEX.md` and populated with all templates, or should it be removed and the templates listed only in the parent domain index? | The current file is lowercase, only lists one template, and fails the index check. | A) Rename to `_INDEX.md`, list all templates. B) Remove the file, list templates in the parent `_INDEX.md` only. | A (proper nested index) |
| Q-BC-006 | Should the `review-bridge-v2-patch.tar.gz` at the repo root be documented, moved, or removed? | It is an untracked artifact of unclear purpose sitting at the top level. | A) Document its purpose in the system map and leave it. B) Move to `tools/review-bridge/`. C) Remove if obsolete. | C (remove if obsolete) |
| Q-BC-007 | Should the scripted path create `docs/strategy/` domain for --existing mode? The manual existing-codebase prompt omits it. | Greenfield gets strategy, existing codebase does not. Inconsistent. | A) Add strategy domain to both existing-codebase prompt and script --existing mode. B) Remove strategy from greenfield too. C) Keep as-is (greenfield only). | A (add to both) |

## Closure Rule

Do not start fixing files until Q-BC-001 through Q-BC-007 are answered or deferred with a chosen default.
## Archietct Answers
Here are my recommendations:

Q-BC-001: Option A. Full form everywhere. The short form creates a false economy. Users who start with the script and later discover they're missing gates will blame the pattern, not the install path. One rule set, one experience.

Q-BC-002: Option C. Same name for both modes: `architecture_system-map.md`. The content differs between greenfield and existing, but the file name should be stable. "System map" is more accurate than "project overview" for what the file contains (components, boundaries, data flows). Mode-dependent naming creates confusion when someone switches modes or reads docs written for the other path.

Q-BC-003: Option B. Same file name for both. Use `questions_initial-project.md`. Whether you're starting fresh or retrofitting, the first questions file serves the same purpose: surface unknowns before planning. "Adoption" is too narrow; it implies the questions are about adopting the pattern rather than about the project itself.

Q-BC-004: Option B. Move to `docs/tessallite-pattern/guides/cross-agent-review-workflow.md`. Not under prompts (it's a workflow guide, not a raw prompt). Not under `docs/guides/` (that's for project-specific guides, not pattern kit guides). Fix the AGENTS.md reference to point there.

Q-BC-005: Option A. Rename to `_INDEX.md`, list all templates. Every other domain has a proper index. The templates subdirectory has 11 files and deserves its own navigable index. Removing it pushes clutter into the parent.

Q-BC-006: Option C. Remove it. It was a one-time patch artifact from our session. The source files are already in `tools/review-bridge/src/`. The tarball serves no ongoing purpose.

Q-BC-007: Option A. Add strategy domain to both modes. Strategy documents (competitive positioning, roadmap rationale, build-vs-buy decisions) are as relevant when retrofitting as when starting fresh. Omitting it from existing mode implies existing projects don't need strategic documentation, which is wrong.
additional points to review :
I can see the issues. Let me map them before proposing a plan.

Problems I can identify from the listing:

1. The cross-agent review workflow file landed in `docs/guides/` instead of `docs/tessallite-pattern/guides/`. The pattern's own guides live under `docs/tessallite-pattern/`, but the project-level guides live under `docs/guides/`. The new file is at the wrong level.

2. The old `cross-agent-review-prompts.md` you said you deleted is still showing at `docs/guides/cross-agent-review-prompts.md`, not under `docs/tessallite-pattern/prompts/` where we originally placed it. Looks like it got moved at some point or placed in the wrong spot.

3. The `templates/_index.md` has a lowercase `_index.md` while every other index file is `_INDEX.md`. Inconsistent casing.

4. The `docs/tessallite-pattern/_INDEX.md` references `walk-through/walkthrough.md` with a relative path going up two levels (`../../walk-through/`), mixing pattern docs with repo-root content.

5. The `external-review-report-template.md` is in `templates/` but not listed in the `_INDEX.md` templates table.

 the Tessallite Pattern repo meant to be a standalone reusable kit that people copy into their own projects, 