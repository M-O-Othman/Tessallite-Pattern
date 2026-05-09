# Command Registry Template

Status: draft
Last meaningful update: YYYY-MM-DD

Use this template to record the commands and wrappers that assistants are
allowed or expected to use in a project. The registry prevents assistants from
inventing unsafe bare commands or skipping required verification.

Project:
Owner:
Last reviewed:

## Command Policy

Default rule:

- Use the commands in this registry.
- Prefer project wrappers over bare tool commands.
- Do not run destructive, publishing, deployment, or production-affecting
  commands without explicit approval.
- If a needed command is missing, ask the architect or add it here before using
  it as a phase gate.

## Verification Commands

| Purpose | Command | When To Run | Notes |
| --- | --- | --- | --- |
| Docs index check | `bash scripts/check-docs-index.sh` | Before committing docs changes. | Replace or remove if the project uses a different docs guard. |
| Targeted tests | `<command>` | During implementation after focused changes. |  |
| Full tests | `<command>` | At phase close, before commit when requested, or when risk requires. |  |
| Build | `<command>` | Before phase close when build output is affected. |  |
| Lint/typecheck | `<command>` | Before phase close when language/tooling supports it. |  |

## Generated Assets And Help

| Purpose | Command | Output | Notes |
| --- | --- | --- | --- |
| Screenshots | `<command>` | `<path>` | Use the shared screenshot helper if one exists. |
| Help build | `<command>` | `<path>` | Register new pages in the help index and navigation chain. |

## Data And Smoke Checks

| Purpose | Command | Environment | Notes |
| --- | --- | --- | --- |
| Seed/reset demo data | `<command>` | `<environment>` | Use only safe demo or local environments. |
| Smoke test | `<command>` | `<environment>` |  |

## Deploy And Publish Wrappers

| Purpose | Approved Command | Commands Not To Run Bare | Notes |
| --- | --- | --- | --- |
| Deploy | `<wrapper command>` | `<bare command>` |  |
| Publish/push | `<wrapper command>` | `<bare command>` |  |

## Approval Required

| Command Or Class | Why Approval Is Required | Approver |
| --- | --- | --- |
| `<command>` | `<reason>` | `<role>` |

## Unknown Commands

| Need | Proposed Command | Risk | Owner | Status |
| --- | --- | --- | --- | --- |
| `<need>` | `<command>` | `<risk>` | `<owner>` | pending |
