# Documentation Governance Checklist

Status: active
Last meaningful update: 2026-05-09

Use this checklist when creating, editing, moving, or archiving documentation.

## New Document

- [ ] File name follows the project naming rule.
- [ ] File has title, status, and last meaningful update.
- [ ] File has a short summary if it is a durable L2 document.
- [ ] File is in the correct domain folder.
- [ ] Domain L1 index links to the file.
- [ ] L1 entry accurately describes the file purpose.
- [ ] L0 index is updated if a new domain was created.

## Edited Document

- [ ] Status still reflects reality.
- [ ] Last meaningful update changed only if the content changed materially.
- [ ] Summary still matches the body.
- [ ] Related docs are updated if the change affects them.
- [ ] L1 entry is updated if the document purpose changed.

## Archived Or Superseded Document

- [ ] Status changed to `archived`, `superseded`, `duplicate`, or `closed`.
- [ ] Active L1 index no longer routes readers to it as current truth.
- [ ] Archive index records the file if the project uses one.
- [ ] Replacement document is linked where appropriate.
- [ ] Reason for archival is visible.

## Index Health

- [ ] `docs/_INDEX.md` lists only domains, not every file.
- [ ] Every domain has an `_INDEX.md`.
- [ ] Every active L2 document is listed in its L1 index.
- [ ] Nested folder indexes list every active Markdown file in that folder.
- [ ] L1 summaries are short and current.
- [ ] Running `bash scripts/check-docs-index.sh` succeeds.

## LLM Context Health

- [ ] A new LLM session can find the right document without opening many files.
- [ ] Stale drafts are not mixed with active docs.
- [ ] Temporary research is not treated as authoritative.
- [ ] Closed decisions are easy to distinguish from current decisions.
