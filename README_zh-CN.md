# 🧪 OpenLitmus

**给开源项目做一次全面体检。**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/GangdanLee/OpenLitmus)](https://github.com/GangdanLee/OpenLitmus/releases)

> 你发现了一个看起来很不错的开源项目。README 写得很好，commit 活跃，两千颗 Star。你集成到了生产环境。三个月后你发现：零测试、唯一的核心开发者刚离职、配置文件里写着 `SECRET_KEY = "change-me-in-production"`。
>
> **OpenLitmus 让你不再踩坑。**

🌐 [English](README.md)

---

## 它做什么

OpenLitmus 是一个纯静态分析框架，通过 **6 个维度 24 个指标** 评估开源项目的健康度——无需部署、无需运行。

用数据和源码验证取代"看看 README、数数 Star"。

---

## 真实案例

用 OpenLitmus 评估 [Clawith](https://github.com/dataelement/Clawith)（多 Agent 协作平台）的结果：

| 场景 | 评分 | 等级 | 建议 |
|------|------|------|------|
| 技术调研 | 5.3 | 🟡 C | ✅ 有研究价值 |
| PoC 试用 | 4.7 | 🟡 C | ⚠️ 谨慎 |
| 生产部署 | 4.1 | 🔴 D+ | ❌ 远未就绪 |
| 二次开发 | 4.2 | 🔴 D+ | ❌ 改造成本极高 |

**README 不会告诉你的事：**
- 🚩 138 条 commit 全部集中在 5 天内（私有仓库一次性推送，并非"迭代了 8 个版本"）
- 🚩 零测试文件、零 CI/CD
- 🚩 配置文件硬编码默认密钥
- 🚩 单个 React 组件 4712 行

[→ 查看完整评估报告](examples/clawith-evaluation.md)

---

## 快速开始

```bash
# 1. 克隆目标项目
git clone --depth 100 <repo-url> _eval && cd _eval

# 2. 运行数据采集脚本
curl -sL https://raw.githubusercontent.com/GangdanLee/OpenLitmus/main/tools/collect.sh | bash

# 3. 对照评分锚点打分
#    → 详见 framework/openlitmus-framework.md
```

---

## 文档

- [完整框架文档](framework/openlitmus-framework.md) — 全部方法论和评分体系
- [评分锚点表](framework/references/scoring-anchors.md) — 量化评分标准
- [安全检查清单](framework/references/security-checklist.md) — 9 项安全基线
- [评估实例：Clawith](examples/clawith-evaluation.md) — 完整真实案例

## 贡献

欢迎贡献！详见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 许可证

MIT
