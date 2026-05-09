# Repository System Map

Status: active
Last meaningful update: 2026-05-09

This document maps the current Tessallite Pattern framework kit repository as an
existing codebase. It is an adoption orientation for future agent sessions and
maintainers.

## Summary

This repository is primarily a documentation and visual-asset kit. It contains
the Tessallite Pattern source article, framework handbook, lifecycle docs,
templates, prompts, governance material, illustrations, a synthetic greenfield
walkthrough, and lightweight scripts for documentation governance and screenshot
generation.

It is not an application runtime. There is no package manifest, server process,
database, compiled binary, or test suite beyond repository maintenance scripts.

## Main Entry Points

| Entry Point | Purpose |
| --- | --- |
| `README.md` | Public starting point and repository map. |
| `docs/_INDEX.md` | L0 documentation router for all documentation domains. |
| `docs/tessallite-pattern/_INDEX.md` | L1 index for the framework kit materials. |
| `walk-through/walkthrough.md` | Visual macOS/Codex greenfield bootstrap walkthrough. |
| `scripts/check-docs-index.sh` | Documentation index consistency guard. |
| `scripts/generate-walkthrough-assets.js` | Deterministic screenshot generator for the walkthrough PNGs. |
| `scripts/bootstrap-tessallite-pattern.sh` | macOS/Linux bootstrap script for applying the pattern to a target project. |
| `scripts/bootstrap-tessallite-pattern.bat` | Windows bootstrap launcher for applying the same scaffold through PowerShell. |

## Primary Modules

| Path | Role |
| --- | --- |
| `docs/tessallite-pattern/` | Canonical framework kit: handbook, lifecycle, governance, prompts, templates, examples, and training. |
| `docs/architecture/` | Operational system map for this repository. |
| `docs/questions/` | Adoption open questions and pending decisions for repository maintenance. |
| `docs/execution/` | Repository issue registry and delivery tracking. |
| `docs/guides/` | Maintainer/developer guidance for the repository. |
| `illustrations/` | Tessallite-branded visual assets used by the README and docs. |
| `walk-through/` | Synthetic macOS/Codex greenfield bootstrap walkthrough and generated screenshots. |
| `scripts/` | Maintenance scripts. |
| `work/logs/` | Project journal for significant repository maintenance work. |
| `work/sessions/` | Session handouts for long-running maintenance work. |

## Data Stores

No application data stores exist. Repository state is represented by Markdown
documents, PNG assets, shell scripts, JavaScript generation scripts, and git
history.

## External Integrations

| Integration | Use | Notes |
| --- | --- | --- |
| GitHub | Remote repository and publishing target. | Remote is `origin`. |
| Headless Chrome | Screenshot generation for walkthrough images. | Used by `scripts/generate-walkthrough-assets.js`. |
| Node.js | Runs the walkthrough screenshot generator. | No `package.json`; the generator uses Node built-ins. |
| Bash | Runs docs index guard. | `scripts/check-docs-index.sh` is the primary verification command. |

## Public Workflows

| Workflow | Command Or Path | Expected Result |
| --- | --- | --- |
| Verify documentation indexes | `bash scripts/check-docs-index.sh` | Fails if active Markdown files are missing from domain or nested indexes. |
| Bootstrap target project on macOS/Linux | `bash scripts/bootstrap-tessallite-pattern.sh /path/to/project --greenfield` | Creates persistent memory, docs domains, starter questions, command registry, journal, and index guard. |
| Bootstrap target project on Windows | `scripts\bootstrap-tessallite-pattern.bat C:\path\to\project -Greenfield` | Creates the same scaffold using Windows batch plus PowerShell. |
| Regenerate walkthrough screenshots | `node scripts/generate-walkthrough-assets.js` | Rewrites PNGs under `walk-through/illustrations/`. |
| Read greenfield adoption path | `walk-through/walkthrough.md` | Shows macOS/Codex setup from project directory creation through initial questions. |
| Find framework prompts | `docs/tessallite-pattern/prompts/_INDEX.md` | Routes prompts by lifecycle stage and inventory. |

## Test And Verification Commands

```bash
bash scripts/check-docs-index.sh
node scripts/generate-walkthrough-assets.js
```

For screenshot work, also inspect representative PNGs after regeneration. The
script depends on a local Chrome or Chromium binary.

## Build Commands

There is no build. The closest production command is the screenshot generator,
which produces static PNG assets.

## Deployment Or Runtime Assumptions

- The repository is consumed as Markdown, static images, and scripts.
- GitHub rendering is the primary reader environment.
- Shell examples assume Unix-like paths; the walkthrough intentionally uses
  macOS zsh.
- Generated walkthrough screenshots are committed, so readers do not need to run
  the generator.

## Known Risks And Unclear Areas

| Risk | Impact | Current Guardrail |
| --- | --- | --- |
| Documentation index drift | Agents may miss authoritative files or retrieve stale context. | `scripts/check-docs-index.sh` checks domain and nested indexes. |
| Screenshot generator depends on local Chrome | Regeneration may fail on machines without Chrome/Chromium. | Developer guide names the dependency. |
| No markdown link checker | Broken links outside index coverage may slip through. | Manual review and targeted `rg` checks for now. |
| No package manifest | Node version expectations are implicit. | Generator uses Node built-ins only. |
| Source article and kit docs may diverge | Readers may see different levels of process maturity. | The article is treated as field report; kit docs are operating truth. |

## Recommended First Adoption Step

Keep future changes inside the Tessallite lifecycle:

1. For documentation-only fixes, use a lightweight path: inspect, edit, run
   `bash scripts/check-docs-index.sh`, and update the issue registry if a
   process gap was found.
2. For new framework capabilities, create requirements, run open questions,
   draft a design/spec or guide change, plan phases, and use adversarial review
   before closure.
