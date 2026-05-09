# Worked Feature Example: Semantic Metric Cache

Status: active
Last meaningful update: 2026-05-09

This example shows how a fictional feature moves through the Tessallite Pattern.
It is intentionally compact, but it demonstrates the artefact flow and gates.

## Feature Request

The product should cache expensive semantic metric queries so dashboards and
conversational agents can reuse verified aggregate results without rerunning the
same warehouse query.

## Stage 1: Requirements Summary

Feature:

Semantic Metric Cache

Users:

- BI dashboard viewer
- conversational analytics user
- workspace admin
- query router service

In scope:

- cache metric query result sets by semantic model, metric, filters, and user
  visibility context
- refresh expired cache entries asynchronously
- expose cache status to admins
- prevent cross-user data leakage

Out of scope:

- predictive cache warming
- manual SQL cache editing
- cross-tenant cache sharing

Acceptance criteria:

- repeated identical metric request can reuse a valid cache entry
- cache key includes security context
- expired entry triggers refresh
- failed refresh does not serve unauthorized data

## Stage 2: First Open Questions

| ID | Question | Why It Matters | Answer |
| --- | --- | --- | --- |
| Q1-001 | Is cache reuse allowed across users with identical permissions, or only within one user identity? | Determines cache key and leakage risk. | Reuse is allowed only across identical resolved visibility scopes, not raw role names. |
| Q1-002 | Should stale cache entries be served during refresh? | Affects UX and correctness. | Serve stale entries for up to 5 minutes only when marked safe for stale use. |
| Q1-003 | Who can purge cache entries? | Admin workflow and audit logging. | Workspace admins can purge by semantic model or metric. |

Gate result:

First pass closed. Design may begin.

## Stage 3: Design Spec Excerpt

Architecture:

- query router computes canonical metric request
- governance service resolves visibility scope
- cache service computes cache key
- warehouse runner executes refresh job when needed
- admin API exposes cache status and purge

Cache key:

```text
sha256(
  tenant_id +
  semantic_model_id +
  metric_id +
  normalized_filters +
  normalized_time_grain +
  resolved_visibility_scope_hash +
  query_dialect_version
)
```

Cache entry fields:

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `cache_key` | string | yes | primary identifier |
| `tenant_id` | string | yes | tenant isolation |
| `semantic_model_id` | string | yes | model source |
| `metric_id` | string | yes | metric identifier |
| `visibility_scope_hash` | string | yes | resolved access scope |
| `status` | enum | yes | fresh, stale, refreshing, failed |
| `expires_at` | timestamp | yes | freshness boundary |
| `stale_until` | timestamp | no | optional stale serving boundary |

## Stage 3b: Second Open Questions

| ID | Spec Section | Question | Answer |
| --- | --- | --- | --- |
| Q2-001 | Cache key | Should filter ordering be normalized before hashing? | Yes. Sort object keys and normalize date literals to ISO format. |
| Q2-002 | Status | Can `failed` entries still serve stale data? | Only if previous result exists and `stale_until` has not passed. |
| Q2-003 | Purge API | Should purge be synchronous? | API returns accepted job ID. Purge is async and auditable. |

Gate result:

Second pass closed. Spec may freeze.

## Stage 4: Implementation Plan Excerpt

| Phase | Goal | Exit Condition |
| --- | --- | --- |
| 1 | Add cache key normalization utilities and tests. | Same logical request produces same key. |
| 2 | Add cache table and repository methods. | CRUD and expiration behavior tested. |
| 3 | Wire query router cache lookup and refresh enqueue. | Repeated request uses fresh cache. |
| 4 | Add admin status and purge API. | Admin can list and purge with audit event. |
| 5 | Update docs and run adversarial review. | Docs, tests, and issue registry complete. |

Traceability:

| Spec Section | Plan Task | Test |
| --- | --- | --- |
| Cache key | Phase 1 | `test_cache_key_normalization` |
| Stale serving | Phase 3 | `test_stale_entry_served_during_refresh_window` |
| Purge API | Phase 4 | `test_admin_purge_returns_job_id` |

## Stage 5: Adversarial Review Finding Example

Finding:

`AR-003`, high severity.

The implementation hashes role names instead of resolved visibility scopes.
This contradicts Q1-001. Two users with the same role name but different row
filters could share a cache entry.

Recommendation:

Move cache key construction after visibility resolution and include the
visibility scope hash. Add a regression test with two users sharing a role name
but receiving different row filters.

Disposition:

Fixed before phase closure. Added test.

## Stage 6: Session Handout Excerpt

Session goal:

Implement phase 1 and phase 2 of Semantic Metric Cache.

What was done:

- cache key normalizer added
- table migration drafted
- repository tests added

What failed:

- first migration used role name in index comment; corrected to visibility
  scope terminology after review

Current state:

- phase 1 closed
- phase 2 implementation complete
- phase 2 review pending

Next steps:

1. Run adversarial audit for phase 2.
2. Fix or log findings.
3. Start phase 3 only after phase 2 closes.

## Lesson

The important defect was not a syntax error. It was a semantic drift from the
answered question. That is exactly the class of error the pattern is designed to
catch.

