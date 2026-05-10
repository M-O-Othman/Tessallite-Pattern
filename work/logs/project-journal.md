# Project Journal

Status: active
Last meaningful update: 2026-05-09

This journal records significant repository maintenance work, discoveries, and
course changes for the Tessallite Pattern framework kit.

## 2026-05-09

Today we set course to apply the Tessallite Pattern to its own framework kit
repository. The first work was not feature code, but the fitting of memory,
routes, and ledgers: `AGENTS.md`, operational docs domains, a system map,
adoption questions, an execution issue registry, a developer guide, and this
journal.

The principal obstruction was that the repository already contained the pattern
as product documentation, but not yet the project-level operating structure the
pattern recommends for an existing codebase. The course was corrected by adding
separate operational domains beside `docs/tessallite-pattern/`, leaving the
framework kit domain intact.

The present state is bootstrap-complete for repository operations. Remaining
attention is due to the pending adoption questions, the open execution issues,
and whether future CI should include link checking or walkthrough regeneration.

Later in the same watch, the bootstrap was extended to handle project feedback
memories from any coding assistant. A new generic prompt support file,
`docs/tessallite-pattern/prompts/project-feedback-rules.md`, now captures the
conversion rule: short behavioral constraints belong in persistent memory, while
long references belong in indexed docs and are linked from memory. The supplied
rules were preserved as a complete example set, but tool-specific wording was
converted into project-level instruction.

The next correction widened that supplement to cover assistant configuration
bootstrap scripts. The important separation is now explicit: reusable behavior
rules may become project memory, but model settings, plugins, broad permission
allowlists, home-directory paths, and automatic publishing toggles remain local
tool setup unless the architect deliberately makes them project policy.

The kit then gained direct bootstrap automation: a macOS/Linux shell script and
a Windows batch launcher. These scripts carry the opening scaffold into a target
project without relying on a specific assistant product. The shell script was
smoke-tested against a temporary project and the generated documentation index
guard passed.

## 2026-05-10

A consistency audit found that the three bootstrap paths (scripted, walkthrough,
manual prompt) produced different file sets, different file names, different
AGENTS.md content, and had broken cross-references. The shell and BAT scripts
also had content parity issues in several generated files.

Seven architect decisions were required. All were answered:

- Full-form AGENTS.md everywhere (10 sections, not 6).
- Same architecture file name for both modes: `architecture_system-map.md`.
- Same questions file name for both modes: `questions_initial-project.md`.
- Cross-agent review workflow moved to `docs/tessallite-pattern/guides/`.
- Templates index renamed to proper casing and populated with all templates.
- Obsolete tarball confirmed removed.
- Strategy domain added to both modes.

All four paths were reconciled against a canonical file manifest. Both scripts
now produce 20 identical files in both modes. The docs index check passes. A
canonical file manifest was created at
`docs/tessallite-pattern/bootstrap-file-manifest.md` to prevent future drift.
