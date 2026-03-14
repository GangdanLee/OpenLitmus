---
name: openlitmus
description: 对 GitHub 开源项目进行健康度评估。用户提供仓库 URL，自动执行代码规模分析、Git 考古、安全审查、社区评估、文档检查和战略分析，生成带评分的 Markdown 报告。当用户说「分析这个项目」「评估这个开源仓库」「这个项目靠谱吗」「能用于生产吗」「帮我评估一下这个 GitHub 项目」时触发。不适用于：私有仓库、需要运行时测试的场景、非代码类仓库（纯文档/数据集）。
metadata:
  author: morgan
  version: 1.0.0
---

# OpenLitmus Skill — 开源项目健康度评估

## 绝对约束

1. **仅做静态分析** — 不安装依赖、不运行项目、不执行测试
2. **所有评分必须引用证据** — 具体文件路径、命令输出或 URL
3. **定量指标优先** — 有数据的不用定性判断
4. **克隆仓库后必须清理** — 评估完成后删除临时目录

---

## Step 0: 解析用户输入

### 0.1 提取仓库 URL
从用户消息中识别 GitHub URL（`github.com/<org>/<repo>`）。

**容错**:
- 用户可能只给项目名 → 提示补充完整 URL
- URL 可能带 `/tree/main`、`.git` 后缀 → 自动清理
- 可能是非 GitHub 仓库（GitLab/Gitee）→ Git 操作通用，GitHub-specific 功能（Issue/PR）改用对应平台 URL

### 0.2 确认评估场景
询问或推断用户意图，确定权重方案：
- **调研**: 了解项目定位和价值
- **PoC**: 准备试用
- **生产**: 计划在生产环境采用
- **二次开发**: 准备 fork 和改造

默认：如果用户未指定，使用"调研"场景权重。

### 0.3 输出确认
```
📋 评估配置
- 项目: <org>/<repo>
- 评估场景: 调研 (可随时调整)
- 预计耗时: 3-5 分钟
```

---

## Step 1: 克隆与代码度量

### 1.1 克隆仓库
```bash
git clone --depth 100 <url> /Users/<user>/.gemini/antigravity/scratch/_openlitmus_eval && cd /Users/<user>/.gemini/antigravity/scratch/_openlitmus_eval
```

### 1.2 代码度量采集
运行以下命令并记录输出：

```bash
# 行数/文件数
find . -type f \( -name '*.py' -o -name '*.ts' -o -name '*.tsx' -o -name '*.go' -o -name '*.rs' -o -name '*.java' -o -name '*.js' -o -name '*.jsx' -o -name '*.css' \) \
  ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' | xargs wc -l | tail -1

# 最大文件 TOP 15
find . -type f \( -name '*.py' -o -name '*.ts' -o -name '*.tsx' -o -name '*.go' \) ! -path '*/node_modules/*' ! -path '*/.git/*' \
  -exec wc -l {} + | sort -rn | head -16

# 导入依赖热力图（自动检测主包名）
pkg=$(find . -maxdepth 2 -name '__init__.py' ! -path '*/.git/*' -exec dirname {} \; | head -1 | xargs basename)
grep -rh "^from ${pkg}\." . --include='*.py' | sed 's/import.*//' | sort | uniq -c | sort -rn | head -20

# 依赖数量
cat pyproject.toml requirements.txt package.json 2>/dev/null | head -50
```

---

## Step 2: Git 考古与社区数据

### 2.1 Git 历史分析
```bash
# 贡献者分布
git shortlog -sn --all | head -15

# commit 日期范围
git log --reverse --format='%ai' | head -1  # 首次
git log --format='%ai' | head -1             # 最新

# 每日 commit 分布
git log --format='%ai' | awk '{print $1}' | sort | uniq -c

# Tag 列表
git tag -l

# Bus Factor（核心文件）
# 对识别出的关键文件逐个运行:
git log --format='%an' -- <key-file> | sort -u | wc -l
```

### 2.2 GitHub 页面采集
使用 `read_url_content` 获取：
- Issues 页面: `https://github.com/<org>/<repo>/issues`
- Pull Requests 页面: `https://github.com/<org>/<repo>/pulls`
- Contributors 页面: `https://github.com/<org>/<repo>/graphs/contributors`

### 2.3 工程成熟度检查
```bash
# 测试文件
find . -type f \( -name 'test_*' -o -name '*_test.py' -o -name '*.test.*' -o -name '*.spec.*' \) ! -path '*/node_modules/*'

# CI/CD
find .github/workflows .gitlab-ci* .circleci Jenkinsfile -type f 2>/dev/null

# 安全文件
ls SECURITY* .snyk* 2>/dev/null
```

---

## Step 3: 源码安全审查

### 3.1 安全基线 9 项检查

对照 `references/security-checklist.md`，使用 grep 和源码阅读逐项检查：

```bash
# 硬编码密钥
grep -rn "SECRET\|PASSWORD\|API_KEY\|TOKEN" --include='*.py' --include='*.ts' --include='*.env*' | grep -v node_modules | grep -v .git

# SQL 注入（原始 SQL 拼接）
grep -rn "execute.*f'" --include='*.py' | head -10

# CORS 配置
grep -rn "CORSMiddleware\|cors\|Access-Control" --include='*.py' --include='*.ts' | head -5
```

### 3.2 关键文件深度阅读
使用 `read_url_content` 读取 GitHub 上的关键文件（auth/security/config 模块），验证实现质量。

### 3.3 文档检查
检查以下文件是否存在并评估质量：
- README.md（安装/运行/配置步骤）
- CONTRIBUTING.md
- 架构图 / ADR
- API 文档
- 多语言支持

---

## Step 4: 评分与报告生成

### 4.1 逐维度评分

对照 `references/scoring-anchors.md` 为每个指标打分（0-10），并记录证据。

维度 ⑤ 使用条件清单（12 项，每项 0.83 分）。
维度 ⑥ 使用条件清单（每子维度 3 项，满足 N 项 = N×3.3 分）。

### 4.2 加权计算

根据用户选择的场景，应用对应权重：

| 维度 | 调研 | PoC | 生产 | 二次开发 |
|------|------|-----|------|---------|
| ① | 0.10 | 0.10 | 0.15 | 0.20 |
| ② | 0.10 | 0.15 | 0.25 | 0.25 |
| ③ | 0.05 | 0.15 | 0.25 | 0.20 |
| ④ | 0.20 | 0.20 | 0.15 | 0.15 |
| ⑤ | 0.25 | 0.20 | 0.10 | 0.10 |
| ⑥ | 0.30 | 0.20 | 0.10 | 0.10 |

### 4.3 生成报告

使用 `write_to_file` 将 Markdown 报告写入 artifacts 目录：

报告结构：
1. 项目概况（一段话）
2. 关键事实数据（定量指标汇总表）
3. 逐维度评分（每维度核心结论 + 证据引用）
4. 红旗清单（🚩 集中列出）
5. 加权评分表（四场景）
6. 使用建议

### 4.4 清理

```bash
rm -rf /Users/<user>/.gemini/antigravity/scratch/_openlitmus_eval
```

---

## 评分锚点

详见 `references/scoring-anchors.md`。

## 安全检查清单

详见 `references/security-checklist.md`。
