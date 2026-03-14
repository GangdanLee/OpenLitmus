# Security Baseline Checklist

9-item checklist for OpenLitmus Dimension ② Indicator 2.2.

Each item passed = 1 point (scaled to 10). 🔴 items that fail incur an extra -1 penalty.

---

## Checklist

| # | Check | Expected | Severity | How to Verify |
|---|-------|----------|----------|--------------|
| 1 | **Secret Management** | No hardcoded default keys; secrets from env vars | 🔴 Critical | `grep -r "SECRET\|PASSWORD\|API_KEY" --include='*.py'` in config files |
| 2 | **Auth/Authz** | JWT/Session + RBAC fully implemented | 🔴 Critical | Read auth module, check for role checks on protected endpoints |
| 3 | **Input Validation** | All endpoints use schema (Pydantic/Zod), no raw dict | 🟡 Medium | Search for `data: dict` in API handlers |
| 4 | **Rate Limiting** | Auth endpoints have throttling | 🟡 Medium | Search for rate limit middleware or decorators |
| 5 | **CORS Config** | Not `*`, restricted to known origins | 🟡 Medium | Check CORS middleware configuration |
| 6 | **CSRF Protection** | State-changing operations protected | 🟡 Medium | Check for CSRF tokens or SameSite cookies |
| 7 | **SSRF Protection** | Outbound HTTP validates URLs | 🟡 Medium | Search for URL validation before `httpx`/`requests` calls |
| 8 | **SQL Injection** | Uses parameterized queries / ORM | 🔴 Critical | Search for raw SQL string concatenation |
| 9 | **SECURITY.md** | Vulnerability disclosure process exists | 🟢 Low | `ls SECURITY*` in repo root |

## Scoring Formula

```
raw_score = items_passed
penalty = count(🔴 items failed) × 1
final_score = max(0, (raw_score / 9) × 10 - penalty)
```
