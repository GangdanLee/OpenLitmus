# OSHEF — Open Source Health Evaluation Framework

> Before adopting an open-source project, give it a thorough health check.

**OSHEF** is a static analysis framework for evaluating the health of open-source projects. It provides a structured, reproducible methodology to assess code quality, security, engineering maturity, community sustainability, documentation, and strategic positioning — all without deploying or running the project.

🌐 [中文文档](README_zh-CN.md)

---

## Why OSHEF?

Most open-source evaluations stop at reading the README and checking the star count. OSHEF goes deeper:

- **Adversarial verification** — Don't trust self-descriptions. Verify claims against source code.
- **Quantifiable metrics** — Use data (commit history, file sizes, dependency counts) instead of gut feelings.
- **Scenario-aware scoring** — Different weights for research, PoC, production, and fork/extend use cases.
- **Reproducible** — Every check has defined tools, commands, and scoring anchors.

---

## 6 Evaluation Dimensions

| # | Dimension | What it measures |
|---|-----------|-----------------|
| ① | **Code Scale & Structure** | Code size, file granularity, module coupling, dependency management |
| ② | **Code Quality & Security** | Claim verification, security baseline, defensive programming, code smells |
| ③ | **Engineering Maturity** | Test coverage, CI/CD, version management, database migrations |
| ④ | **Community & Sustainability** | Bus factor, issue ecosystem, development activity, git history authenticity |
| ⑤ | **Documentation & Accessibility** | Onboarding docs, architecture docs, API docs, i18n |
| ⑥ | **Strategy & Ecosystem** | Product positioning, competitive differentiation, team background, commercial viability |

Each dimension contains 4 sub-indicators with specific scoring anchors. See the [full framework](framework/oshef-framework.md) for details.

---

## Quick Start (5 minutes)

### 1. Clone the target project

```bash
git clone --depth 100 <repo-url> _eval_tmp && cd _eval_tmp
```

### 2. Run the data collection script

```bash
curl -sL https://raw.githubusercontent.com/GangdanLee/oshef/main/tools/collect.sh | bash
```

Or manually run the commands from the [data collection toolkit](framework/oshef-framework.md#数据采集工具链).

### 3. Score each dimension

Use the [scoring anchors](framework/references/scoring-anchors.md) to rate each indicator 0-10.

### 4. Calculate weighted score

Choose your scenario (Research / PoC / Production / Fork) and apply the corresponding weights.

### 5. Generate report

Follow the [report template](framework/oshef-framework.md#step-5-撰写报告) structure. See [Clawith evaluation](examples/clawith-evaluation.md) for a complete example.

---

## Scoring System

### Scenario Weights

| Dimension | Research | PoC | Production | Fork/Extend |
|-----------|----------|-----|------------|-------------|
| ① Code Scale & Structure | 0.10 | 0.10 | 0.15 | 0.20 |
| ② Code Quality & Security | 0.10 | 0.15 | 0.25 | 0.25 |
| ③ Engineering Maturity | 0.05 | 0.15 | 0.25 | 0.20 |
| ④ Community & Sustainability | 0.20 | 0.20 | 0.15 | 0.15 |
| ⑤ Documentation & Accessibility | 0.25 | 0.20 | 0.10 | 0.10 |
| ⑥ Strategy & Ecosystem | 0.30 | 0.20 | 0.10 | 0.10 |

### Grade Scale

| Grade | Score | Meaning |
|-------|-------|---------|
| 🟢 A | 8.0-10.0 | Production-ready, safe to adopt at scale |
| 🔵 B | 6.0-7.9 | Usable for PoC / small-scale production, needs reinforcement |
| 🟡 C | 4.0-5.9 | Valuable but significant risks, research only |
| 🔴 D | 2.0-3.9 | High risk, not recommended for direct use |
| ⚫ F | 0-1.9 | Abandon |

---

## Example: Clawith Evaluation

See [examples/clawith-evaluation.md](examples/clawith-evaluation.md) for a complete evaluation of the [Clawith](https://github.com/dataelement/Clawith) multi-agent collaboration platform, demonstrating all 6 dimensions, quantitative data collection, red flags, and scenario-specific scoring.

**Key findings from the example:**
- Git public history was only 5 days (pushed from private repo)
- Zero test files, zero CI/CD
- Bus Factor = 1 for all core security modules
- Research score: 🟡 C (5.3) | Production score: 🔴 D+ (4.1)

---

## For Antigravity Users

OSHEF is available as an [Antigravity](https://github.com/google-deepmind/antigravity) skill. Copy the `skill/` directory to your `.agent/skills/` folder:

```bash
cp -r skill/oshef ~/.gemini/antigravity/scratch/.agent/skills/oshef
```

Then simply tell Antigravity: *"Evaluate this GitHub project: https://github.com/..."*

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines. Key areas where contributions are welcome:

- **Scoring anchors** — Calibration data from evaluating more projects
- **Technology-specific checklists** — Go, Rust, Java adaptations
- **Automated tooling** — Scripts for specific indicators

---

## License

MIT — See [LICENSE](LICENSE) for details.
