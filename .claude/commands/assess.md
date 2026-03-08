对用户进行全面的 AI 工程能力评估。

## 评估流程

### Step 1：读取当前状态
先读取项目根目录的 `PROGRESS.md`，了解用户的历史进度和当前聚焦。

### Step 2：客观信号扫描（自动执行，不需要用户回答）

在问答评估之前，先自动扫描当前项目和环境，收集客观证据：

**扫描项目：**
1. **CLAUDE.md 存在性与质量**：检查项目根目录是否有 CLAUDE.md，如有则评估内容（是否包含技术栈、规范、目录结构、工作流规则等）
2. **Custom Commands**：检查是否存在 `.claude/commands/` 目录及其中的命令文件数量和内容
3. **Hooks 配置**：检查 `.claude/settings.json` 或 `.claude/settings.local.json` 中是否配置了 Hooks
4. **CI/CD AI 集成**：检查 `.github/workflows/` 中是否存在 AI 相关的 workflow（如 ai-review.yml、ai-autofix.yml、ai-triage.yml）
5. **Git 规范**：查看最近 10 条 git log，检查 commit message 是否遵循 conventional commits 格式
6. **测试覆盖**：检查项目中是否存在测试文件（*.test.ts、*.test.tsx、*.spec.ts 等）及其与源文件的比例
7. **项目结构**：扫描项目目录结构，了解技术栈和项目规模

**输出扫描报告：**
```
## 客观信号扫描结果

| 检测项 | 结果 | 对应 Level |
|--------|------|-----------|
| CLAUDE.md | ✅ 存在，包含技术栈+规范 / ❌ 不存在 | Level 3-4 |
| Custom Commands | ✅ X 个命令 / ❌ 未配置 | Level 7 |
| Hooks 配置 | ✅ 已配置 / ❌ 未配置 | Level 7 |
| CI/CD AI 集成 | ✅ X 个 workflow / ❌ 未配置 | Level 8 |
| Git 规范 | ✅ conventional commits / ⚠️ 不规范 | Level 7 |
| 测试文件 | ✅ X 个测试文件 / ❌ 无测试 | Level 5 |
```

将扫描结果作为后续评估的参考依据。如果扫描结果与用户自评矛盾（如用户声称 Level 7 但项目无 Commands），温和指出差异。

### Step 3：逐项评估（基于 ai-engineering-leveling-guide.md 的自我评估 Checklist）

结合 Step 2 的客观信号，对以下每项打分（0 = 完全不符合，1 = 部分符合，2 = 完全符合）：

**基础能力（Level 1-2）**
- 日常开发中使用 AI 代码补全
- 会在 Claude Code 中进行基本对话
- 能判断 AI 输出的代码是否可用

**提示词能力（Level 3-4）**
- 能写包含上下文+约束+期望输出的结构化 Prompt
- 项目有 CLAUDE.md 且保持更新
- 复杂任务会先用 Plan Mode 规划
- AI 生成的代码需手动修改的比例 < 20%

**自主开发（Level 5）**
- 描述业务意图而非技术实现，AI 自主选择方案
- 能独立委托完整 Feature（前端+API+测试）
- AI 的方案一次通过架构审查的比例 > 80%

**并行与编排（Level 6-7）**
- 能同时管理 3+ 个 Claude Code 实例并行开发
- 熟练使用 Git Worktree 隔离并行任务
- 有 5+ 个 Custom Slash Commands
- 配置了 Hooks 自动化质量检查

**系统级（Level 8）**
- CI/CD 中集成了 AI（Headless 模式）
- 有 AI 自动修复失败 Pipeline 的能力
- 有完整的 AI 工作流监控和成本控制

### Step 4：计算得分与 Level

评分标准：0-4 → Level 1-2 ｜ 5-8 → Level 3-4 ｜ 9-11 → Level 5 ｜ 12-15 → Level 6-7 ｜ 16-18 → Level 8

### Step 5：对比历史

将本次评估结果与 PROGRESS.md 中的上次评估对比，指出：
- 哪些项目有进步（分数提升）
- 哪些项目停滞（与上次相同）
- 哪些项目需要重点突破

### Step 6：交叉验证

将 Step 2 的客观扫描结果与 Step 3 的自评打分进行交叉验证：
- 如果客观信号支持自评 → 增强评估置信度
- 如果客观信号与自评矛盾 → 温和指出，询问用户原因（可能是在其他项目中使用，或正在迁移中）
- 将交叉验证结果体现在评估报告中

### Step 7：输出结果

格式：
```
## 评估结果

**日期**：[今天日期]
**总分**：X / 18
**当前 Level**：N
**建议目标 Level**：N+1

### 客观信号扫描
[Step 2 的扫描结果表格]

### 各维度得分
| 维度 | 得分 | 客观信号 | 备注 |
|------|------|---------|------|
| 基础能力 | X/6 | — | ... |
| 提示词能力 | X/8 | CLAUDE.md: ✅/❌ | ... |
| 自主开发 | X/6 | 测试文件: ✅/❌ | ... |
| 并行与编排 | X/8 | Commands: X个, Hooks: ✅/❌ | ... |
| 系统级 | X/6 | CI workflows: X个 | ... |

### 当前 Level 子技能状态
[根据评估出的 Level，列出该 Level 和下一 Level 的子技能状态和建议]
[例如：如果评估为 Level 5，列出 Level 5 和 Level 6 的子技能]

### 建议聚焦
[基于评估结果，建议聚焦哪个子技能，以及具体的下一步行动]
[优先推荐当前 Level 中尚未验收的子技能]
```

### Step 8：更新 PROGRESS.md

评估完成后：
1. 更新「当前总体评估」中的 Level、目标 Level 和评估日期
2. 更新对应 Level 的子技能状态（根据评估结果将 🔴 改为 🟡 或 🟢）
3. 更新「当前聚焦」字段
4. 在「里程碑记录」中添加本次评估记录
5. 以上变更需要**用户确认后**才执行
