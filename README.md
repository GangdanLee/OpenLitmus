# 🧪 OpenLitmus

**The litmus test for open source.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/GangdanLee/openlitmus)](https://github.com/GangdanLee/openlitmus/releases)

> You found a promising open-source project. Great README, active commits, 2K stars. You integrate it into production. Three months later: zero tests, one maintainer who just quit, and `SECRET_KEY = "change-me-in-production"` hardcoded in the config.
>
> **OpenLitmus exists so you never get burned again.**

🌐 [中文文档](README_zh-CN.md)

---

## What It Does

OpenLitmus is a static analysis framework that evaluates open-source project health across **6 dimensions** and **24 indicators** — without deploying or running the project.

It replaces "read the README and check the stars" with structured, evidence-based assessment.

**Core principles:**
- 🔍 **Adversarial** — Don't trust self-descriptions. Verify claims against source code.
- 📊 **Quantifiable** — Data over gut feelings. Every score has a defined anchor.
- 🎯 **Scenario-aware** — Different weights for research, PoC, production, and fork use cases.
- 🔁 **Reproducible** — Same project → same score, regardless of who runs the evaluation.

---

## Real-World Example

Here's OpenLitmus applied to [Clawith](https://github.com/dataelement/Clawith), a multi-agent collaboration platform:

| Scenario | Score | Grade | Verdict |
|----------|-------|-------|---------|
| Research | 5.3 | 🟡 C | ✅ Worth studying |
| PoC | 4.7 | 🟡 C | ⚠️ Proceed with caution |
| Production | 4.1 | 🔴 D+ | ❌ Not ready |
| Fork/Extend | 4.2 | 🔴 D+ | ❌ High refactor cost |

**Discoveries the README wouldn't tell you:**
- 🚩 All 138 commits pushed within 5 days (private repo dump, not "8 versions of iteration")
- 🚩 Zero test files. Zero CI/CD pipelines.
- 🚩 `SECRET_KEY = "change-me-in-production"` hardcoded in config
- 🚩 A single 4,712-line React component

[→ Full evaluation report](examples/clawith-evaluation.md)

---

## Quick Start

```bash
# 1. Clone the target project
git clone --depth 100 <repo-url> _eval && cd _eval

# 2. Run the data collector
curl -sL https://raw.githubusercontent.com/GangdanLee/openlitmus/main/tools/collect.sh | bash

# 3. Score using the framework
#    → See framework/openlitmus-framework.md for scoring anchors
```

Or read the [full framework](framework/openlitmus-framework.md) to understand the methodology first.

---

## 6 Evaluation Dimensions

| # | Dimension | Key Indicators |
|---|-----------|---------------|
| ① | **Code Scale & Structure** | File granularity, module coupling, dependency management |
| ② | **Code Quality & Security** | Claim verification, security baseline, code smells |
| ③ | **Engineering Maturity** | Test coverage, CI/CD, version management |
| ④ | **Community & Sustainability** | Bus factor, issue ecosystem, git history authenticity |
| ⑤ | **Documentation** | Onboarding, architecture docs, API docs, i18n |
| ⑥ | **Strategy & Ecosystem** | Product positioning, competitive differentiation, team background |

Each indicator has defined **scoring anchors** (not vibes) → [See all anchors](framework/references/scoring-anchors.md)

---

## Scoring

**4 scenarios, different weights:**

| Dimension | Research | PoC | Production | Fork |
|-----------|----------|-----|------------|------|
| ① Structure | 0.10 | 0.10 | 0.15 | 0.20 |
| ② Quality | 0.10 | 0.15 | 0.25 | 0.25 |
| ③ Maturity | 0.05 | 0.15 | 0.25 | 0.20 |
| ④ Community | 0.20 | 0.20 | 0.15 | 0.15 |
| ⑤ Docs | 0.25 | 0.20 | 0.10 | 0.10 |
| ⑥ Strategy | 0.30 | 0.20 | 0.10 | 0.10 |

**Grades:** 🟢 A (8+) Production-ready · 🔵 B (6-8) PoC-ready · 🟡 C (4-6) Research only · 🔴 D (2-4) High risk · ⚫ F (<2) Abandon

---

## For Antigravity Users

OpenLitmus ships as an [Antigravity](https://github.com/google-deepmind/antigravity) skill:

```bash
cp -r skill/openlitmus ~/.gemini/antigravity/scratch/.agent/skills/openlitmus
```

Then just say: *"Evaluate this project: https://github.com/..."*

---

## Docs

| Document | What's inside |
|----------|--------------|
| [Framework](framework/openlitmus-framework.md) | Full methodology, all 24 indicators, scoring system |
| [Scoring Anchors](framework/references/scoring-anchors.md) | Numeric thresholds for dimensions ①-④ |
| [Security Checklist](framework/references/security-checklist.md) | 9-item security baseline check |
| [Example: Clawith](examples/clawith-evaluation.md) | Complete real-world evaluation |

---

## Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md).

**Most wanted:**
- 📊 Scoring calibration data from evaluating more projects
- 🔧 Technology-specific checklists (Go, Rust, Java)
- 🤖 Automated tooling for specific indicators

## License

MIT — See [LICENSE](LICENSE).
