# OSHEF — 开源项目健康度评估框架

> 在采用开源项目前，用静态分析给它做一次全面体检。

**OSHEF** 是一个面向开源项目的静态分析评估框架。通过6个维度24个指标，对项目的代码质量、安全性、工程成熟度、社区健康度、文档完善度和战略定位进行系统化评估——无需部署运行项目。

🌐 [English](README.md)

---

## 核心理念

1. **对抗性验证** — 不信任项目自述，一切结论需源码佐证
2. **可量化优先** — 用数据（commit 历史、文件大小、依赖数量）替代直觉判断
3. **场景敏感** — 调研/PoC/生产/二次开发四种场景使用不同权重
4. **可复现** — 每项检查都有明确的工具、命令和评分标准

## 快速开始

1. 克隆目标项目：`git clone --depth 100 <url> _eval_tmp`
2. 运行 [数据采集脚本](tools/collect.sh)
3. 对照 [评分锚点](framework/references/scoring-anchors.md) 逐维度打分
4. 选择场景权重计算加权总分
5. 参照 [Clawith 评估实例](examples/clawith-evaluation.md) 撰写报告

## 文档

- [完整框架文档](framework/oshef-framework.md)
- [评分锚点表](framework/references/scoring-anchors.md)
- [安全检查清单](framework/references/security-checklist.md)
- [评估实例：Clawith](examples/clawith-evaluation.md)

## 贡献

欢迎贡献！详见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 许可证

MIT
