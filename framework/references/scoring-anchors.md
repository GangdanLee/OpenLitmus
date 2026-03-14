# Scoring Anchors Reference

Quick-reference scoring thresholds for OSHEF dimensions ①-④.
For dimensions ⑤-⑥, use the checklist scoring method defined in the main framework.

---

## ① Code Scale & Structure

### 1.1 Code Volume

| Score | Total Lines | Comment Rate | Language Spread |
|-------|-------------|-------------|-----------------|
| 8-10 | 5K-50K | 10-25% | ≤3 main languages |
| 5-7 | 1K-5K or 50K-150K | 5-10% or 25-30% | 4-5 |
| 0-4 | <1K or >150K | <5% or >30% | >5 or indeterminate |

### 1.2 File Granularity

| Score | Largest File | Long Functions (>80 lines) | God Files (>30 imports) |
|-------|-------------|---------------------------|------------------------|
| 8-10 | All <300 lines | 0 | 0 |
| 5-7 | Max <800 lines | ≤3 | ≤1 |
| 0-4 | >1000 lines exist | >5 | >2 |

### 1.3 Module Coupling

| Score | Hottest Module Imports | Circular Deps | Layer Violations |
|-------|----------------------|---------------|-----------------|
| 8-10 | <20 | 0 | None |
| 5-7 | 20-50 | ≤2 | Minor |
| 0-4 | >50 | >2 | Widespread |

### 1.4 Dependency Management

| Score | Total Deps | Version Pinning | Known High CVEs | Stale Deps |
|-------|-----------|----------------|----------------|-----------|
| 8-10 | ≤20 | Upper-bounded (`~=`/`==`) | 0 | 0 |
| 5-7 | 21-35 | Partial | 0 | ≤2 |
| 0-4 | >35 or all `>=` unbounded | None | ≥1 | >3 |

---

## ② Code Quality & Security

### 2.1 Claim-Implementation Consistency

| Score | Claims Verified | Undisclosed Issues |
|-------|----------------|-------------------|
| 8-10 | >90% verifiable in source | Undisclosed items are positive features |
| 5-7 | 70-90% | Minor undisclosed issues |
| 0-4 | <70% or major exaggeration | Serious undisclosed problems |

### 2.2 Security Baseline

Check 9 items. Each pass = 1 point (scaled to 10). 🔴 items that fail: extra -1 penalty.

### 2.3 Defensive Programming

| Score | Bare Except | External Call Timeout | Resource Management |
|-------|-----------|---------------------|-------------------|
| 8-10 | 0 | All have timeout | All use context managers |
| 5-7 | ≤3 | Most have | Mostly correct |
| 0-4 | >5 | Widely missing | Obvious leak risk |

### 2.4 Code Smells

| Score | God Files (>1000 lines) | Inline Imports | Hardcoded Config |
|-------|------------------------|---------------|-----------------|
| 8-10 | 0 | Rare (circular dep avoidance only) | All externalized |
| 5-7 | ≤2 | Scattered | Minor |
| 0-4 | >3 | Widespread | Prevalent |

---

## ③ Engineering Maturity

### 3.1 Test Coverage

| Score | Test Files | Coverage | Critical Path Tests |
|-------|-----------|---------|-------------------|
| 8-10 | Organized test directory | >70% | Auth + core business covered |
| 5-7 | Test files exist | 30-70% | Partial coverage |
| 2-4 | Framework config only, no actual tests | <30% | None |
| 0-1 | Completely absent | 0% | None |

### 3.2 CI/CD

No CI = 0; Lint only = 3; Lint + Test = 6; Lint + Test + Build + Branch protection = 10.

### 3.3 Version Management

| Score | Versioning | Changelog | Breaking Change Labels |
|-------|-----------|----------|----------------------|
| 8-10 | Strict SemVer + complete tags | Detailed per-version changelog | Clear ⚠️ labels |
| 5-7 | Basic SemVer | Has Release Notes | Mentioned but unlabeled |
| 0-4 | No convention or incomplete tags | None | None |

### 3.4 Database Migration

| Score | Migration Tool | Consistency | Data Migration |
|-------|---------------|-------------|---------------|
| 8-10 | Present and sole schema management | No conflicts | Yes |
| 5-7 | Present but coexists with `create_all` | Potential conflicts | No |
| 0-4 | No migration tool | — | — |

---

## ④ Community & Sustainability

### 4.1 Contributor Distribution (Bus Factor)

| Score | Total Contributors | Top Contributor % | External Contributors |
|-------|-------------------|-------------------|---------------------|
| 8-10 | ≥10 | <50% | ≥5 |
| 5-7 | 5-9 | 50-70% | 2-4 |
| 2-4 | 3-4 | 70-90% | 1 |
| 0-1 | ≤2 | >90% | 0 |

### 4.2 Issue Ecosystem

| Score | Close Rate | First Response | Real User Issue % |
|-------|-----------|---------------|------------------|
| 8-10 | >80% | <48h | >70% |
| 5-7 | 50-80% | 2-7 days | 40-70% |
| 0-4 | <50% | >7 days or no response | <40% or bot-heavy |

### 4.3 Development Activity

| Score | Last Commit | Release Interval | Trend |
|-------|-----------|-----------------|-------|
| 8-10 | <1 week | <2 months | Stable or growing |
| 5-7 | 1 week - 1 month | 2-6 months | Flat |
| 0-4 | >3 months | >6 months or none | Declining or stalled |

### 4.4 Git History Authenticity

| Score | History Span | Commit Distribution | Tag Coverage |
|-------|-------------|-------------------|-------------|
| 8-10 | >6 months of continuous public development | Even distribution | All claimed versions have tags |
| 5-7 | 1-6 months | Mostly even | Most versions tagged |
| 0-4 | <1 month or bulk push | Extremely concentrated | Only latest version tagged |
