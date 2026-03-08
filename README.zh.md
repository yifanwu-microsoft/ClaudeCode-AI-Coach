**中文** | [English](README.md)

# AI 工程能力教练系统

> 一套基于 Claude Code 的 AI 工程能力成长系统。安装后在你日常使用 Claude Code 的过程中，自动评估你的操作层级并给出成长建议。

## 这是什么？

你正常使用 Claude Code 写代码，这套系统会在**每次交互结束后**自动附加一段简短的教练反馈：

```
---
📊 AI 教练评估
- 本次操作层级：Level 4
- 当前聚焦：意图驱动开发

💡 升级建议：
- 你说："用 useState 加个搜索框"（Level 4）
- 试试："用户需要在 200 条数据中快速找到目标"（Level 5）
- 好处：AI 会自己判断用前端过滤还是后端搜索，可能给你更好的方案
```

它基于 [AI 工程能力提升完整指南](ai-engineering-leveling-guide.md)（Level 1→8），核心能力：

- **自动检测**：从你的 prompt 模式判断操作层级（Level 3-8）
- **渐进式阻力**：当你给出低层级 prompt 时，给出更高层级的表达示例
- **反模式拦截**：实时检测并警告常见陷阱
- **进度追踪**：记录各子技能状态和里程碑

## 快速开始（3 步）

### Step 1：克隆仓库

```bash
git clone https://github.com/anthropics/ClaudeCode-AI-Coach.git
cd ClaudeCode-AI-Coach
```

### Step 2：安装到本机

在 repo 目录中打开 Claude Code，输入：

```
/install
```

Claude 会自动检测系统并执行安装脚本。

或者手动运行：

**macOS / Linux**：
```bash
chmod +x scripts/install.sh
./scripts/install.sh
```

**Windows（PowerShell）**：
```powershell
.\scripts\install.ps1
```

安装脚本会将配置部署到 `~/.claude/`，对本机所有项目全局生效。

### Step 3：首次评估

打开 Claude Code（任意项目都行），输入：

```
/assess
```

Claude 会询问你的 AI 工具使用情况，逐项打分，确定你的起始 Level。

**完成！** 之后正常使用 Claude Code 即可，教练系统会自动工作。

## 日常使用

### 它什么时候会出现？

**每次你和 Claude Code 交互时**，教练系统在后台运行。你不需要做任何额外操作：

- 正常写代码、问问题、做需求 — Claude 照常完成你的请求
- 交互结束后，Claude 会在回答末尾附加 2-3 行教练评估
- 当你的 prompt 有明显提升空间时，会给出具体的升级建议

### 什么时候需要主动使用命令？

| 场景 | 做什么 |
|------|--------|
| 想看看自己进步了没 | `/assess` — 重新全面评估 |
| 想练习但不知道做什么 | `/practice` — 获取当前聚焦子技能的练习任务 |
| 想提升 prompt 质量 | `/review-prompt <你的prompt>` — 分析并给出升级建议 |
| 需要给 leader 汇报 | `/progress-report` — 生成结构化进度报告 |

### Level 是什么意思？

| Level | 你的状态 | AI 的角色 |
|-------|---------|----------|
| 1-2 | 偶尔用补全/问答 | 打字助手 |
| 3-4 | 写结构化 Prompt，管理上下文 | 听指令的初级工程师 |
| 5 | 描述业务意图，审查 AI 方案 | 能独立交付的中级工程师 |
| 6 | 同时管理多条 AI 任务流 | 一个可并行的开发团队 |
| 7 | 设计标准化流程，AI 按流程执行 | 自动化流水线 |
| 8 | 配置事件触发器，AI 自主运转 | 基础设施 |

> 详见 [完整 Level 定义与验收标准](ai-engineering-leveling-guide.md)

## 多设备使用

每台电脑的进度独立维护。换电脑时：

```bash
git clone → ./scripts/install.sh → /assess
```

重新评估会根据你当前的实际能力快速定位 Level，无需手动迁移数据。

## 更新教练系统

当 repo 有新版本时：

```bash
git pull
./scripts/install.sh  # 或 Windows: .\scripts\install.ps1
```

安装脚本会更新配置和命令，但**不会覆盖你的本机进度**。

## 文件结构

```
ClaudeCode-AI-Coach/
├── CLAUDE.md                        ← 核心：教练系统的行为规则
├── PROGRESS.md                      ← 进度模板（安装后本机独立维护）
├── ai-engineering-leveling-guide.md ← Level 1-8 完整定义和验收标准
├── .claude/commands/
│   ├── assess.md                    ← /assess 全面评估
│   ├── i18n.md                      ← /i18n 翻译管理（维护用）
│   ├── install.md                   ← /install 安装到本机
│   ├── practice.md                  ← /practice 练习任务
│   ├── progress-report.md           ← /progress-report 进度汇报
│   ├── review-prompt.md             ← /review-prompt 审查 prompt
│   └── uninstall.md                 ← /uninstall 卸载系统
└── scripts/
    ├── install.sh                   ← macOS/Linux 安装脚本
    ├── install.ps1                  ← Windows 安装脚本
    ├── uninstall.sh                 ← macOS/Linux 卸载脚本
    └── uninstall.ps1                ← Windows 卸载脚本
```

## 自定义与扩展

- **添加命令**：在 `.claude/commands/` 下创建 `.md` 文件，重新安装即可
- **修改规则**：编辑 `CLAUDE.md`，重新安装。标记块机制不影响你本机的其他规则
- **项目级规则**：这套系统是全局教练，你的项目可以有自己的 CLAUDE.md，两者共存不冲突

## License

Personal use.
