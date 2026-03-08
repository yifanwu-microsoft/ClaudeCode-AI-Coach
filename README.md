# AI 工程能力教练系统

> 一套跨项目、跨电脑的 AI 工程能力成长系统。通过 Claude Code 的 CLAUDE.md + Custom Commands 机制，在每次 AI 交互中自动评估你的操作层级并给出成长建议。

## 这是什么？

这个 repo 是你的 **AI 工程能力教练**的配置中心。它基于 [AI 工程能力提升完整指南](ai-engineering-leveling-guide.md)（Level 1→8），实现以下功能：

- **自动检测**：从你的 prompt 模式判断当前操作层级（Level 3-8）
- **渐进式阻力**：当你给出低层级 prompt 时，推动你用更高层级的表达方式
- **反模式拦截**：实时检测并警告 Level 6/7/8 的常见陷阱
- **进度追踪**：持久化记录各子技能状态和里程碑
- **跨电脑同步**：通过 git + 同步脚本，在所有设备上保持一致

## 文件结构

```
claude-code-root/
├── README.md                        ← 你正在看的文件
├── CLAUDE.md                        ← 核心：Claude 行为规则 + 教练系统配置
├── PROGRESS.md                      ← 你的进度状态（子技能 + 里程碑）
├── ai-engineering-leveling-guide.md ← Level 1-8 完整定义和验收标准
├── .claude/
│   └── commands/
│       ├── assess.md                ← /assess 全面评估当前 Level
│       ├── practice.md              ← /practice 获取练习任务
│       ├── progress-report.md       ← /progress-report 生成向上汇报
│       └── review-prompt.md         ← /review-prompt 审查 prompt 质量
└── scripts/
    ├── sync.ps1                     ← Windows 同步脚本
    └── sync.sh                      ← macOS/Linux 同步脚本
```

## 快速开始

### 1. 克隆仓库

```bash
git clone <your-repo-url> claude-code-root
cd claude-code-root
```

### 2. 首次部署到本机

**Windows（PowerShell）**：
```powershell
.\scripts\sync.ps1 -Direction push
```

**macOS / Linux**：
```bash
chmod +x scripts/sync.sh
./scripts/sync.sh push
```

这会将教练系统部署到 `~/.claude/`，对本机所有项目生效。

### 3. 首次使用

在任何项目中打开 Claude Code，执行 `/assess` 进行首次评估。Claude 会：
1. 询问你当前的使用情况
2. 逐项评分确定你的 Level
3. 初始化 PROGRESS.md 中的状态

之后每次交互，Claude 会在回答末尾附加简短的层级评估和成长建议。

## 自定义命令

| 命令 | 用途 | 使用场景 |
|------|------|---------|
| `/assess` | 全面评估当前 Level | 每 1-2 周做一次，检视进步 |
| `/practice` | 获取当前聚焦子技能的练习任务 | 想练习但不知道做什么时 |
| `/progress-report` | 生成向上汇报 | 需要给 leader 汇报进度时 |
| `/review-prompt` | 分析 prompt 层级并给出升级建议 | 想提升 prompt 质量时 |
| `/sync` | AI 辅助的跨设备同步 | 换电脑或想备份进度时 |

## 跨电脑同步

### 工作流程

```
在电脑 A 上练完了：
  sync pull  →  git add + commit + push

换到电脑 B 继续：
  git pull   →  sync push
```

### 同步命令

**Push（repo → 本机全局）**：
```powershell
# Windows
.\scripts\sync.ps1 -Direction push

# macOS/Linux
./scripts/sync.sh push
```

将 repo 中的最新配置和进度部署到本机 `~/.claude/`。

**Pull（本机全局 → repo）**：
```powershell
# Windows
.\scripts\sync.ps1 -Direction pull

# macOS/Linux
./scripts/sync.sh pull
```

将本机 `~/.claude/PROGRESS.md` 的最新进度拉回 repo，然后你可以 git push 同步到远端。

### 合并策略

同步脚本使用**标记块**机制处理 CLAUDE.md 合并：

- 教练系统内容被 `<!-- AI-COACH-START -->` 和 `<!-- AI-COACH-END -->` 包裹
- 同步时只替换标记块内的内容，不碰标记块外的任何规则
- 如果目标机器已有自己的 CLAUDE.md 规则，完全不受影响

| 场景 | 处理方式 |
|------|---------|
| 目标没有 CLAUDE.md | 直接创建 |
| 目标有自己的规则 | 在末尾追加教练块 |
| 目标有旧版教练 | 替换标记块内容 |
| commands/ 有其他命令 | 不影响，只覆盖我们的 4 个文件 |

## PROGRESS.md 自动更新

在日常交互中，Claude 会根据以下规则自动维护 PROGRESS.md：

| 类型 | 操作 | 是否需要确认 |
|------|------|-------------|
| 评估日期更新 | 自动 | ❌ |
| 添加里程碑记录 | 自动 | ❌ |
| 子技能状态变更 | 提出建议 | ✅ 需确认 |
| Level 评估变更 | 提出建议 | ✅ 需确认 |
| 聚焦子技能切换 | 提出建议 | ✅ 需确认 |

## 三条不可违反的底线

无论在什么项目中使用，以下底线永远生效：

1. **Level 7 毕业先行**：未通过 Level 7 毕业测试前，不配置 Level 8 的 CI/CD 自动化
2. **人工审查不可绕过**：AI 自动生成的代码变更必须经人工审查，绝不 auto-merge
3. **配置完成 ≠ 达成**：Level 8 需要 2 周运行数据支撑，不是配完就算毕业

## 自定义与扩展

### 添加新的 Custom Command

在 `.claude/commands/` 下创建新的 `.md` 文件，sync push 后所有电脑生效。

### 修改教练规则

编辑 `CLAUDE.md`，sync push 部署。标记块机制确保不影响各电脑的本地规则。

### 项目级别的 CLAUDE.md

这套系统是**全局教练**。你的各个项目仍然可以有自己的项目级 CLAUDE.md（放在项目根目录），定义项目特有的技术栈、代码规范等。两者共存，不冲突。

## License

Personal use.
