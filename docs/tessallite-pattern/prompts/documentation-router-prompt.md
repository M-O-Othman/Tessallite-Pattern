# Documentation Router Prompt

Status: active
Last meaningful update: 2026-05-09

Use this prompt when asking an LLM to work in a repo that follows the tiered
documentation pattern.

```text
Use the documentation hierarchy as a cache router.

Rules:
1. If you know the exact document path, open that document directly.
2. If you know the domain but not the exact file, read docs/<domain>/_INDEX.md.
3. If you do not know the domain, read docs/_INDEX.md first, choose the domain,
   then read that domain's _INDEX.md.
4. Do not bulk-load unrelated docs.
5. Treat active docs as authoritative.
6. Treat draft docs as provisional.
7. Treat archived, duplicate, and superseded docs as historical unless the task
   explicitly asks for history.
8. If an index entry appears to contradict the document body, stop and report
   the documentation inconsistency before proceeding.

When creating or moving docs:
- update the relevant L1 index immediately
- update L0 only when a new domain is created
- preserve status and last meaningful update fields
- run the docs index checker if available
```

