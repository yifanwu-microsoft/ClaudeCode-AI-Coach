**中文** | [English](README.md)

<div align="center">

# 🏋️ AI 工程能力教练系统

### 升级你的 AI 辅助开发技能 — 从入门到自动化专家

*一套基于 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 的全天候教练系统，观察你如何与 AI 协作、评估你的能力等级（1→8），并在每次交互中自动提供个性化成长建议。*

[快速开始](#-快速开始) · [工作原理](#-工作原理) · [命令参考](#-命令参考) · [等级指南](#-8-级等级体系) · [常见问题](#-常见问题)

</div>

---

## 🤔 为什么需要这个

大多数开发者只用到了 AI 编码工具的一小部分能力。你可能还在逐条手写 prompt，而其实可以直接委托整个功能。你可能还在串行执行任务，而其实可以同时运行三个并行流。

**问题不在工具，而在于没人教你进阶路径。** 这套教练系统就是干这个的。

## ✨ 它做什么

安装一次，之后正常使用 Claude Code 即可。教练会观察你与 AI 的交互方式，在每次回复末尾附加简短、可操作的反馈：

**💡 升级建议** — 当你可以用更高层级的方式提问时：
```
---
📊 **AI 教练** · Level 4

💡 **升级**: 你说 "用 useState 加个搜索框，过滤列表"

→ **试试**: "用户需要在约 200 条数据中快速找到目标，需适配移动端"

→ **好处**: AI 会自己判断用前端过滤还是后端搜索，并处理你没想到的边界情况
```

**✅ 正面反馈** — 当你表现出色时：
```
---
📊 **AI 教练** · Level 5

✅ **很好**: 你的意图驱动 prompt 让 AI 自主选择了分页策略

💡 **下一步**: 试试一次性委托整个功能（API + 组件 + 测试），练习 L5 功能委托
```

**⚠️ 反模式警告** — 当检测到常见陷阱时：
```
---
📊 **AI 教练** · Level 6

⚠️ 你同时运行了 5 个 agent — 管理起来很困难。建议从 2-3 个开始，熟练后再扩展。
```

### 核心能力

| 能力 | 描述 |
|---|---|
| 🔍 **自动检测** | 从你的 prompt 模式判断操作层级（Level 1-8） |
| 📈 **渐进式阻力** | 当你给出低层级 prompt 时，用*你自己的话*给出更高层级的表达示例 |
| 🚫 **反模式拦截** | 实时检测并警告各层级的常见陷阱 |
| 📊 **进度追踪** | 在本地进度文件中记录子技能状态、成就和里程碑 |
| 🏅 **成就系统** | 当你展示新技能时自动解锁成就（共 15 个成就） |
| 🧠 **上下文感知** | 根据你的技术栈、任务类型和项目上下文调整建议 |

## 📋 前置要求

- 已安装并可正常使用 [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code)
- Git

## 🚀 快速开始

### Step 1 — 克隆仓库

```bash
git clone https://github.com/yifanwu-microsoft/ClaudeCode-AI-Coach.git
cd ClaudeCode-AI-Coach
```

### Step 2 — 安装

最简单的方式：在此仓库目录中打开 Claude Code，执行：

```
/coach:install
```

Claude 会自动检测操作系统并运行安装脚本。

<details>
<summary>或者手动安装</summary>

**macOS / Linux：**
```bash
chmod +x scripts/install.sh
./scripts/install.sh
```

**Windows（PowerShell）：**
```powershell
.\scripts\install.ps1
```
</details>

> 安装脚本将所有文件部署到 `~/.claude/`，对本机所有项目**全局生效**。如果你已有 `~/.claude/CLAUDE.md`，脚本会使用标记块合并教练配置，不会影响你现有的规则。

### Step 3 — 首次评估

如果你使用 `/coach:install` 安装，首次评估会在安装完成后**自动开始** — 无需退出或切换项目。Claude 会问你 3 个简短问题来确定你的 Level。

如果你通过 shell 脚本手动安装，打开 Claude Code（任意项目），教练系统会自动检测首次安装并启动评估。你也可以随时运行：

```
/coach:assess
```

进行更深入的项目级评估。

**搞定！** 之后每次使用 Claude Code 都会自动附带教练反馈。

## 🔬 工作原理

教练系统使用**四层架构**来保证 coaching 一定会发生 — 即使 LLM 跳过了指令也不会遗漏：

```
┌──────────────────────────────────────────────────────────┐
│  Tier 1: LLM 内联 Coaching                               │
│  CLAUDE.md 指令 → 最丰富的反馈，但不保证执行              │
├──────────────────────────────────────────────────────────┤
│  Tier 2: 独立 LLM Coaching 调用（Hook 触发）              │
│  Stop hook → claude -p → 专注 coaching，保证触发          │
├──────────────────────────────────────────────────────────┤
│  Tier 3: 上下文感知规则引擎（无需 LLM）                   │
│  信号扫描 + 活动分析 + 技术栈适配建议                     │
├──────────────────────────────────────────────────────────┤
│  Tier 4: 静态建议兜底（零依赖，永远有效）                  │
│  按等级预写的建议，任何环境都能输出                        │
└──────────────────────────────────────────────────────────┘
```

**层级降级流程：**
1. Claude Code 完成你的请求并附带内联 coaching（Tier 1 — 最佳情况）
2. `Stop` Hook 在每次交互后**自动触发**
3. Hook 尝试独立 `claude -p` coaching 调用（Tier 2 — 高质量，保证触发）
4. 如果失败，规则引擎选择上下文相关的建议（Tier 3 — 无需 LLM）
5. 如果也失败，显示你等级对应的静态建议（Tier 4 — 永远有效）

> **结果：** 每次都能收到 coaching，质量根据可用资源自适应。

### Level 是什么意思？

| Level | 你的状态 | AI 的角色 |
|-------|---------|----------|
| 1-2 | 偶尔用补全/问答 | 打字助手 |
| 3-4 | 写结构化 Prompt，管理上下文 | 听指令的初级工程师 |
| 5 | 描述业务意图，审查 AI 方案 | 能独立交付的中级工程师 |
| 6 | 同时管理多条 AI 任务流 | 一个可并行的开发团队 |
| 7 | 设计标准化流程，AI 按流程执行 | 自动化流水线 |
| 8 | 配置事件触发器，AI 自主运转 | 基础设施 |

> 详见 [完整 Level 定义与验收标准](coach/ai-engineering-leveling-guide.md)

## 多设备使用

每台电脑的进度独立维护。换电脑时：

```bash
git clone → ./scripts/install.sh → 自动评估（或 /coach:assess）
```

**安装到 `~/.claude/` 的关键文件：**

| 文件 | 用途 |
|------|------|
| `CLAUDE.md` | 教练规则，注入到 Claude 的系统提示词中（与你现有规则合并） |
| `PROGRESS.md` | 你的个人进度追踪器 — 等级、子技能、成就、里程碑 |
| `ai-engineering-leveling-guide.md` | 完整的 Level 1-8 参考指南（1200+ 行的技术和练习） |
| `commands/coach/*.md` | 斜杠命令（`/coach:assess`、`/coach:practice` 等） |
| `coach-engine/` | 确定性 coaching 引擎（信号扫描器、建议数据库、进度追踪器） |
| `coach-engine/hooks/` | Stop hook，保证每次交互后都提供 coaching |
| `settings.json` | Claude Code hooks 配置（自动合并现有设置） |

## 🎮 命令参考

### `/coach:assess` — 全面评估

对你的 AI 工程能力进行综合评估。扫描你的 CLAUDE.md 配置、自定义命令、Hooks、CI/CD 设置、Git 规范和项目结构。输出 5 个维度的评分报告，附带具体改进建议。

**何时使用：** 首次安装时、定期检查进度时、或觉得自己升级了的时候。

### `/coach:practice` — 练习会话

根据你当前的等级和最薄弱的子技能生成练习任务。提供 4 种练习模式：

| 模式 | 聚焦方向 | 示例 |
|------|---------|------|
| 🏋️ Prompt 健身房 | 提升 prompt 质量 | 把一个 L3 prompt 改写为 L5 意图驱动型 |
| 🎯 委托训练 | 功能委托 | 将一个完整 CRUD 功能委托给 AI |
| ⚡ 并行规划 | 任务拆解 | 将一个功能拆分为 3 个并行流 |
| 🔧 自动化猎手 | 流程自动化 | 为重复任务创建自定义命令 |

**何时使用：** 想练习但不知道该做什么的时候。

### `/coach:review-prompt <prompt>` — Prompt 审查

分析你提供的 prompt，评估其当前层级（L1-8），生成升级路径，展示同一需求在不同层级的递进表达方式。

**何时使用：** 发送重要 prompt 之前，或想学习更高效的表达方式时。

### `/coach:progress-report` — 进度报告

生成结构化的进度报告，汇总你的等级、子技能状态、成就和近期里程碑。格式适合分享给团队负责人或经理。

**何时使用：** 需要向 leader 汇报 AI 工程能力成长时。

### `/coach:uninstall` — 卸载

从本机移除教练系统。可选保留 `PROGRESS.md`，避免丢失进度数据。

## 📊 8 级等级体系

教练系统基于一套完整的 [AI 工程能力提升指南](coach/ai-engineering-leveling-guide.md)，定义了 AI 辅助开发的 8 个能力等级：

| 等级 | 名称 | 你在做什么 | AI 在做什么 | 关键技能 |
|------|------|-----------|-----------|---------|
| **1** | 零接触 | 全部手写代码 | 不存在 | — |
| **2** | 补全依赖 | 按 Tab 接受自动补全 | 打字助手 | 建立信任 |
| **3** | 对话协作 | 在 Chat 中提问，复制粘贴答案 | 搜索引擎 | 基础对话 |
| **4** | Prompt 工程 | 写带上下文的结构化 prompt | 初级工程师 | CRATE 框架 |
| **5** | 意图驱动 | 描述*做什么*和*为什么*，而非*怎么做* | 中级工程师 | 功能委托 |
| **6** | 多 Agent 并行 | 同时运行 3+ AI 任务流 | 开发团队 | Worktree + 并行 |
| **7** | 流程编排 | 设计流程，AI 按流程执行 | 自动化流水线 | 命令 + Hooks |
| **8** | 自动化系统 | 配置触发器，AI 全天候运转 | 基础设施 | CI/CD 集成 |

每个等级包含：
- ✅ **验收标准** — 明确的清单，让你知道何时可以毕业
- 🧠 **心态转变** — 需要的思维模式变化
- 📝 **逐步执行计划** — 每周练习安排
- 🏋️ **实战练习** — 具体的练习任务
- ⚠️ **反模式** — 需要避免的常见错误
- 🔧 **卡住了？诊断清单** — 症状、根因和修复方案

> 📖 [阅读完整指南 →](coach/ai-engineering-leveling-guide.md)

## 🏅 成就系统

教练追踪 15 个成就，当你展示新技能时自动解锁：

| 成就 | 解锁条件 |
|------|---------|
| 🎯 首次接触 | 完成任意评估 |
| 💬 对话发起者 | 一次会话中 3+ 次有实质内容的交流 |
| 🔍 代码审查员 | 明确拒绝、修改或批评 AI 代码 |
| 📋 上下文提供者 | prompt 中包含文件路径 + 错误详情 + 环境信息 |
| 📐 Plan Mode 采纳者 | 对复杂任务使用 Plan Mode |
| ✨ 一击必中 | AI 输出无需修改，一轮通过 |
| 🎤 意图表达者 | 描述业务意图而不指定实现方式 |
| 🏗️ 功能委托者 | 将多模块功能委托给 AI |
| 👀 架构评审者 | 审查并给出 AI 架构方案的反馈 |
| ⚡ 并行先锋 | 管理并行 AI 任务 |
| 🔀 Worktree 战士 | 使用 git worktree 进行并行开发 |
| 🤖 命令创建者 | 创建自定义斜杠命令 |
| 🪝 Hook 大师 | 在 Claude 设置中配置 Hooks |
| 🔄 CI 集成者 | 在 CI/CD 工作流中配置 AI |
| 📊 成本观察者 | 检查 `/cost` 或讨论 API 开支 |

成就是子技能进展的客观证据 — 解锁成就后，教练可能会建议更新相关子技能的状态。

## 🔄 更新与多设备使用

### 更新到最新版本

```bash
cd ClaudeCode-AI-Coach
git pull
./scripts/install.sh   # 或 Windows: .\scripts\install.ps1
```

安装脚本会更新配置和命令，但**绝不会覆盖你的 PROGRESS.md**。

### 多设备使用

每台电脑的进度独立维护。在新设备上：

```bash
git clone https://github.com/yifanwu-microsoft/ClaudeCode-AI-Coach.git
cd ClaudeCode-AI-Coach && ./scripts/install.sh
```

然后运行 `/coach:assess` — 系统会根据你当前的实际能力快速定位等级，无需手动迁移数据。

## 🛠️ 自定义与扩展

| 想做什么 | 怎么做 |
|---------|--------|
| **添加命令** | 在 `coach/commands/coach/` 下创建 `.md` 文件，然后重新安装 |
| **修改教练规则** | 编辑 `coach/CLAUDE.md`，然后重新安装。标记块合并机制会保留你 `~/.claude/CLAUDE.md` 中的其他规则 |
| **调整进度模板** | 编辑 `coach/PROGRESS.template.md`（仅影响新安装 — 现有进度会被保留） |

## 📁 项目结构

```
ClaudeCode-AI-Coach/
├── coach/                               ← 可分发源文件（安装到 ~/.claude/）
│   ├── CLAUDE.md                        ← 教练系统规则（~80 行，精简版）
│   ├── PROGRESS.template.md              ← 进度追踪模板
│   ├── ai-engineering-leveling-guide.md ← 完整 Level 1-8 指南（1200+ 行）
│   ├── achievement-triggers.md          ← 成就定义与解锁条件
│   ├── commands/coach/                  ← 斜杠命令
│   │   ├── assess.md                    ← /coach:assess
│   │   ├── practice.md                  ← /coach:practice
│   │   ├── progress-report.md           ← /coach:progress-report
│   │   ├── review-prompt.md             ← /coach:review-prompt
│   │   └── uninstall.md                 ← /coach:uninstall
│   ├── engine/                          ← 确定性 coaching 引擎（无需 LLM）
│   │   ├── coach-cli.sh                 ← 独立 CLI：tip / progress / practice
│   │   ├── tips.sh                      ← 上下文感知建议选择器
│   │   ├── progress.sh                  ← PROGRESS.md 自动更新器
│   │   ├── tier2-prompt.md              ← 独立 LLM coaching prompt 模板
│   │   ├── lib/                         ← 共享工具库
│   │   └── tips/                        ← 精选建议数据库（JSON，按等级）
│   └── hooks/                           ← Claude Code hooks
│       ├── on-stop.sh                   ← 交互后 coaching（四层降级）
│       └── settings.template.json       ← Hook 配置模板
├── scripts/
│   ├── install.sh / install.ps1         ← 安装脚本（macOS/Linux/Windows）
│   └── uninstall.sh / uninstall.ps1     ← 卸载脚本
├── .claude/commands/coach/
│   └── install.md                       ← /coach:install（仅项目级）
├── README.md                            ← English README
└── README.zh.md                         ← 本文件
```

## ❓ 常见问题

<details>
<summary><b>这会让 Claude Code 变慢吗？</b></summary>

不会。教练系统只在每次回复末尾附加几行反馈，不会增加额外的 API 调用或处理步骤 — 它只是 Claude 系统提示词中的额外指令。
</details>

<details>
<summary><b>我已有 CLAUDE.md，会冲突吗？</b></summary>

不会。安装脚本使用 HTML 注释标记（`<!-- AI-COACH-START -->` / `<!-- AI-COACH-END -->`）注入教练配置。标记之外的现有规则完全不受影响。
</details>

<details>
<summary><b>能临时关闭教练吗？</b></summary>

可以。从 `~/.claude/CLAUDE.md` 中删除教练配置块（`AI-COACH-START` 和 `AI-COACH-END` 标记之间的内容）。想恢复时重新安装即可，你的进度保存在 `PROGRESS.md` 中不会丢失。
</details>

<details>
<summary><b>支持所有编程语言吗？</b></summary>

是的。教练系统与语言无关 — 它评估的是你的 *prompt 模式和 AI 使用习惯*，而非你写的具体代码。指南中的示例使用 React/TypeScript，但所有概念适用于任何技术栈。
</details>

<details>
<summary><b>如何完全卸载？</b></summary>

在 Claude Code 中运行 `/coach:uninstall`，或手动执行：

```bash
./scripts/uninstall.sh   # 或 Windows: .\scripts\uninstall.ps1
```

这会移除教练配置块、命令和指南。系统会询问是否保留你的 PROGRESS.md。
</details>

<details>
<summary><b>我卡在当前等级了怎么办？</b></summary>

运行 `/coach:practice` 获取针对你最薄弱子技能的练习任务。完整指南中每个等级都有「卡住了？诊断清单」，列出症状、根因和修复方案。
</details>

## 🤝 参与贡献

欢迎贡献！参与方式：

1. **编辑** `coach/` 目录下的教练文件
2. **安装** 运行 `./scripts/install.sh` 部署到 `~/.claude/`
3. **测试** 打开另一个项目验证教练体验
4. **迭代** — `coach/` 中的修改需要重新安装才能生效

> 根目录的 `CLAUDE.md` 是项目开发配置。教练规则在 `coach/CLAUDE.md` 中。

## 📄 License

Personal use.
