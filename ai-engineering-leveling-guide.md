# AI 工程能力提升完整指南 (Level 1 → Level 8)

> **适用对象**：前端为主的全栈工程师（React/Next.js 技术栈）
> **核心工具**：Claude Code CLI
> **使用方式**：每个 Level 有明确的验收 Checklist，全部打勾才进入下一阶段

---

## 目录

1. [概述：Level 定义 + 自我评估](#1-概述level-定义--自我评估)
2. [Level 1-2：AI 辅助编程入门](#2-level-1-2ai-辅助编程入门)
3. [Level 3-4：提示词工程 + 项目上下文管理](#3-level-3-4提示词工程--项目上下文管理)
4. [Level 5：意图驱动开发](#4-level-5意图驱动开发)
5. [Level 6：多 Agent 并行](#5-level-6多-agent-并行)
6. [Level 7：工作流编排](#6-level-7工作流编排)
7. [Level 8：自动化编排系统](#7-level-8自动化编排系统)
8. [附录：模板与速查表](#8-附录模板与速查表)

---

## 1. 概述：Level 定义 + 自我评估

### Level 全景图

| Level | 名称 | 你在做什么 | AI 在做什么 |
|-------|------|-----------|------------|
| 1 | 零接触 | 手写所有代码 | 不存在 |
| 2 | 补全依赖 | 写代码，偶尔按 Tab 接受补全 | 打字助手 |
| 3 | 对话协作 | 在 Chat 中问问题，复制粘贴答案 | 搜索引擎替代品 |
| 4 | 提示词工程 | 写结构化 Prompt，管理项目上下文 | 听指令的初级工程师 |
| 5 | 意图驱动 | 描述业务意图，审查 AI 的方案 | 能独立交付的中级工程师 |
| 6 | 多 Agent 并行 | 同时管理多条 AI 任务流 | 一个可并行的开发团队 |
| 7 | 工作流编排 | 设计标准化流程，AI 按流程执行 | 自动化流水线 |
| 8 | 自动化系统 | 配置事件触发器，AI 7x24 自主运转 | 基础设施 |

### 自我评估（每项 0-2 分）

**基础能力（Level 1-2）**
- [ ] 日常开发中使用 AI 代码补全
- [ ] 会在 Claude Code 中进行基本对话
- [ ] 能判断 AI 输出的代码是否可用

**提示词能力（Level 3-4）**
- [ ] 能写包含上下文+约束+期望输出的结构化 Prompt
- [ ] 项目有 CLAUDE.md 且保持更新
- [ ] 复杂任务会先用 Plan Mode 规划
- [ ] AI 生成的代码需手动修改的比例 < 20%

**自主开发（Level 5）**
- [ ] 描述业务意图而非技术实现，AI 自主选择方案
- [ ] 能独立委托完整 Feature（前端+API+测试）
- [ ] AI 的方案一次通过架构审查的比例 > 80%

**并行与编排（Level 6-7）**
- [ ] 能同时管理 3+ 个 Claude Code 实例并行开发
- [ ] 熟练使用 Git Worktree 隔离并行任务
- [ ] 有 5+ 个 Custom Slash Commands
- [ ] 配置了 Hooks 自动化质量检查

**系统级（Level 8）**
- [ ] CI/CD 中集成了 AI（Headless 模式）
- [ ] 有 AI 自动修复失败 Pipeline 的能力
- [ ] 有完整的 AI 工作流监控和成本控制

**评分**：0-4 → Level 1-2 ｜ 5-8 → Level 3-4 ｜ 9-11 → Level 5 ｜ 12-15 → Level 6-7 ｜ 16-18 → Level 8

---

## 2. Level 1-2：AI 辅助编程入门

### Why：为什么从这里开始

这个阶段的目标不是让 AI 写出完美代码，而是**建立使用 AI 的肌肉记忆**。

跳过这个阶段直接学高级技巧会导致：
- 不信任 AI 输出 → 花更多时间审查 → 觉得 AI 没用 → 放弃
- 缺少对 AI 输出质量的直觉 → 后续每一步决策都更慢

核心心态：**让 AI 帮你写那些你会写但懒得写的代码**（boilerplate、类型定义、测试骨架）。

### How：具体执行步骤

#### 第 1 周：安装 + 建立补全习惯

```bash
# 安装 Claude Code
npm install -g @anthropic-ai/claude-code

# 在项目目录启动
cd your-project
claude
```

**每天练习**：写代码时有意识地让 AI 补全以下内容：
- React 组件的 JSX 结构
- TypeScript 类型/接口定义
- `useEffect`、`useCallback` 等 Hook 的依赖数组
- 重复性代码（map 渲染、表单字段）

#### 第 2 周：学会在 Claude Code 中提问

从小而具体的问题开始：

```
好的问题（有边界、有上下文）：
  "这段代码报了 TS2345 错误，错误信息是 [粘贴]，怎么修？"
  "把这个 class component 改写成 function component + hooks"
  "给 getUserById 函数加上错误处理和 loading 状态"

不好的问题（太大、太模糊）：
  "帮我优化代码"
  "写一个管理后台"
```

#### 第 3-4 周：建立审查直觉

每次 AI 生成代码后，检查三件事：
1. **类型安全** — 有没有 `any`？边界情况处理了吗？
2. **项目一致性** — 命名、文件组织、导入方式是否符合项目惯例？
3. **可理解性** — 你能向别人解释每一行吗？不能就追问 AI

### Done When：验收标准

- [ ] 每天自然地使用 AI 补全（不需要刻意提醒自己）
- [ ] 每天至少 3 次在 Claude Code 中进行有效对话
- [ ] AI 贡献了 20-30% 的代码（非关键路径）
- [ ] 对每段 AI 代码都有"接受/修改/拒绝"的判断习惯

**毕业测试**：用 AI 辅助完成一个 3 组件的小 Feature（如表单+列表+详情）。AI 贡献 20%+ 代码，你能解释每一行。

### Practice：练习任务

1. **类型生成**：给 Claude 一个 API 的 JSON 响应样本，让它生成 TypeScript 类型。对比你手写的版本
2. **组件骨架**：让 Claude 生成一个 `<DataTable>` 组件（支持排序+分页），逐行标注需要修改的地方
3. **代码解释**：找项目中一段你不太理解的代码，让 Claude 解释，然后验证准确性

### Anti-patterns：常见陷阱

| 陷阱 | 修正 |
|------|------|
| 不看代码直接复制粘贴 | 建立"三件事检查"习惯 |
| 连变量命名都问 AI | 只在节省 30 秒以上时才用 AI |
| 反复让 AI 重写追求完美 | 80% 够好就接受，手动调 20% |
| 只说"帮我修 bug"没有上下文 | 必须附带：错误信息 + 代码片段 + 期望行为 |

---

## 3. Level 3-4：提示词工程 + 项目上下文管理

### Why：为什么提示词质量是效率拐点

Level 2 时你和 AI 的对话可能要 5-10 个来回才得到满意结果。
Level 4 毕业时应该降到 **1-3 个来回**。

差距在哪？不是 AI 变聪明了，是你学会了**一次给够信息**。

这个阶段要建立两个核心能力：
1. **结构化提示词** — 让 AI 一次输出高质量结果
2. **CLAUDE.md 项目上下文** — 让 AI 自动继承项目规范，不用每次重复

### How：具体执行步骤

#### Step 1：掌握 Claude Code 核心功能（第 1 周）

```bash
# 初始化项目级配置
claude /init
# → 自动生成 CLAUDE.md，包含项目结构、技术栈、代码规范

# Plan Mode：先规划再执行（复杂任务必用）
# 在对话中输入：
/plan
# → Claude 会给出分步方案，你审核后再执行
# → 可以在 Plan Mode 中追问和调整方案

# 压缩上下文（对话太长影响质量时）
/compact

# 查看 Token 消耗
/cost
```

**Plan Mode 使用示例**：

```
你："我需要给用户列表页添加搜索功能，支持按姓名和邮箱搜索"

Claude (Plan Mode):
  1. 创建 useUserSearch hook（debounce + React Query）
  2. 修改 UserList 组件，添加 SearchInput
  3. 后端添加 /api/users/search 端点
  4. 添加搜索结果高亮

你："方案 OK，但搜索用前端过滤就行，数据量不超过 200 条，不需要后端接口"

Claude: 好的，修改方案...（调整后执行）
```

#### Step 2：结构化提示词——CRATE 框架（第 2 周）

```markdown
## Context（上下文）
Next.js 14 App Router 项目，Tailwind CSS + shadcn/ui。
当前在 app/dashboard/ 目录下工作。

## Role（角色——可选，复杂任务时用）
你是熟悉 Next.js App Router 和 RSC 的高级前端工程师。

## Action（要做什么）
创建一个 Dashboard 数据概览卡片组件。

## Target（具体产物）
- 文件：components/dashboard/stats-card.tsx
- Props：title: string, value: number, trend: number, icon: LucideIcon
- 使用 shadcn/ui 的 Card 组件

## Expectation（验收标准）
- Server Component（不加 'use client'）
- trend 正数绿色↑、负数红色↓
- 响应式布局：移动端单列，桌面端可放 grid
```

不需要每次都写全 5 项。简单任务给 Context + Action 就够。关键是**给足 AI 判断所需的信息**。

#### Step 3：配置 CLAUDE.md（第 3 周）

CLAUDE.md 是项目级的"AI 操作手册"。Claude Code 每次启动都会读取它。

```markdown
# CLAUDE.md

## 项目概述
Next.js 14 App Router 电商后台管理系统

## 技术栈
- Next.js 14 (App Router), TypeScript (strict)
- Tailwind CSS + shadcn/ui
- Prisma + PostgreSQL
- TanStack Query v5

## 代码规范
- 组件：命名导出（不用 default export）
- 文件名：kebab-case（stats-card.tsx）
- 类型：同目录 types.ts 文件中定义
- 数据获取：Server Component 直接 Prisma 查询；客户端用 React Query
- 样式：使用 cn() 合并 Tailwind 类名

## 目录结构
app/           → 路由和页面
components/ui/ → shadcn/ui 基础组件（不手动修改）
components/features/ → 业务组件
lib/           → 工具函数
hooks/         → 自定义 Hooks
types/         → 全局类型

## 常用命令
npm run dev    → 开发服务器
npm test       → Vitest 测试
npm run lint   → ESLint
```

**关键原则**：CLAUDE.md 控制在 200 行以内。太长 AI 反而会忽略重要规则。

#### Step 4：迭代式对话而非一次到位（第 4 周）

```
# 第一轮：大方向
"给 dashboard 加一个用户活跃度折线图"

# 第二轮：看到方案后补充
"用 recharts，x 轴按周显示，最近 12 周"

# 第三轮：细化
"加上 loading skeleton 和空状态"
```

这比花 30 分钟写一个"完美 Prompt"更高效。

### Done When：验收标准

- [ ] Prompt 平均 1-3 轮得到满意结果（记录最近 10 个任务）
- [ ] CLAUDE.md 已配置且包含技术栈+规范+目录结构
- [ ] 复杂任务（跨 3+ 文件）100% 使用 Plan Mode
- [ ] AI 代码贡献 50-60%，手动修改 < 20%

**毕业测试**：完成一个带筛选+排序+分页的数据表格。使用 Plan Mode 规划，1-3 轮 Prompt 完成。AI 代码需手动修改的比例 < 20%。

### Practice：练习任务

1. **CLAUDE.md 验证**：写完 CLAUDE.md 后，让 Claude 创建一个新组件，检查它是否遵守了命名规范、导出方式、文件位置
2. **CRATE 对比**：同一个任务分别用"一句话 Prompt"和 CRATE 格式 Prompt，对比输出质量和来回次数
3. **Plan Mode 深度使用**：选一个跨 3+ 文件的 Feature，全程 Plan Mode。记录计划 vs 实际的偏差

### Anti-patterns：常见陷阱

| 陷阱 | 修正 |
|------|------|
| 把整个代码库丢给 AI 求帮忙 | 只给必要文件和上下文 |
| CLAUDE.md 写了 500 行 | 精简到 200 行以内，核心规则优先 |
| 不用 Plan Mode 直接让 AI 改代码 | 跨文件任务必须先 Plan |
| Prompt 写 200 行指定每个细节 | 给框架让 AI 提方案，你做选择 |
| CLAUDE.md 写了一次就不管了 | 技术栈/规范变化时及时更新 |

---

## 4. Level 5：意图驱动开发

### Why：从"告诉 AI 怎么做"到"告诉 AI 为什么做"

Level 4 的你："用 useInfiniteQuery 实现无限滚动列表，每页 20 条，用 Intersection Observer 触发加载"
Level 5 的你："用户抱怨订单列表加载慢，数据量有 5000+ 条。请优化用户体验。"

当你描述 Why/What 而非 How 时：
- AI 可能给出你没想到的更好方案（比如虚拟列表而非无限滚动）
- 你从"编码执行者"变成"产品决策者"
- 你的时间从写代码转移到审查方案和做架构决策

**前提**：你必须有能力评判 AI 的方案好坏。这需要工程基础，所以不能跳过前面的阶段。

### How：具体执行步骤

#### Step 1：学会描述意图（第 1-2 周）

**转换练习——把 How 改写成 Why/What**：

```
Before (How):
  "在 UserList 组件中添加 useState 管理搜索词，
   加 input 框，onChange 时 setState，
   useQuery 参数中传入搜索词"

After (Why/What):
  "用户列表页需要搜索功能。
   场景：管理员需要在 5000+ 用户中快速找到特定用户。
   性能要求：输入不能卡顿，搜索响应 < 500ms。
   请给出方案并实现。"
```

#### Step 2：Feature 级别委托（第 3-4 周）

把完整 Feature 交给 AI，你只负责需求定义和方案审查：

```markdown
## 需求：订单导出功能

### 业务背景
运营团队每周需要导出订单数据到 Excel，目前只能手动复制。

### 用户故事
运营人员在订单列表页点击"导出"，按当前筛选条件导出 CSV。

### 约束
- 最大导出量：10 万行
- 字段：订单号、客户名、金额、状态、创建时间
- 大数据量时显示进度
- 文件名：orders_YYYYMMDD_HHmmss.csv

### 不需要
- 不需要 .xlsx 格式
- 不需要后台任务队列

### 验收标准
- [ ] 导出 1000 条数据 < 3 秒
- [ ] 特殊字符（逗号、引号）正确转义
- [ ] 有 loading 状态和错误提示
```

#### Step 3：方案评审——你的新核心工作（第 5-6 周）

AI 给出方案后，用这个 checklist 审查：

```
1. 架构合理性
   □ 符合项目现有模式？
   □ 没有过度工程？

2. 边界情况
   □ 错误处理完善？
   □ 并发/竞态考虑了？
   □ 空数据和大数据量都处理了？

3. 性能
   □ 没有不必要的重渲染？
   □ 数据获取策略合理？

4. 安全
   □ 无 XSS/注入风险？
   □ 权限验证到位？
```

#### Step 4：测试驱动的信任（第 7-8 周）

```
"实现订单导出功能，要求：
 - 先写测试再写实现（TDD）
 - 单元测试：CSV 生成逻辑（含特殊字符转义）
 - 集成测试：导出 API 端点
 - 组件测试：导出按钮的交互状态"
```

测试通过 = 你可以信任代码。这比逐行审查效率高 10 倍。

### Done When：验收标准

- [ ] Prompt 中 What/Why 占比 > 70%（审查最近 10 个 Prompt）
- [ ] 完成过 3+ 个 Feature 级委托（前端+API+测试）
- [ ] AI 方案一次通过架构审查的比例 > 80%
- [ ] Feature 完成速度对比纯手写快 2x+（记录 3 个 Feature 对比）
- [ ] AI 代码贡献 60-75%

**毕业测试**：完成一个完整 Feature（前端+API+数据库），全程意图描述不指定实现方式。AI 方案一次通过架构审查，总耗时比纯手写快 2x+。

### Practice：练习任务

1. **意图重写**：找最近 5 个 Prompt，用意图驱动方式重写，对比两个版本的 AI 输出质量
2. **方案 PK**：同一需求分别用 How 和 What 方式提问，对比哪个方案更完善
3. **Feature 委托**：选一个 4-8 小时的 Feature 交给 AI。记录总耗时、Prompt 轮数、手动修改比例

### Anti-patterns：常见陷阱

| 陷阱 | 修正 |
|------|------|
| "我想用 useState 管理搜索"（还是 How） | 描述用户场景和问题，不提技术方案 |
| AI 写完了就不审查 | 审查重点从代码细节转移到架构方案 |
| 只说"加个搜索"没背景 | 始终提供：业务场景 + 数据规模 + 性能要求 |
| AI 第一个方案直接接受 | 至少追问一次"有没有更好的方案？为什么选这个？" |

---

## 5. Level 6：多 Agent 并行

### Why：从串行到并行的效率飞跃

Level 5 的工作流：写组件 → 写 API → 写测试 → 调样式（串行）
Level 6 的工作流：Agent A 写组件 + Agent B 写 API + Agent C 写测试（并行）

**效率公式**：并行度 x 单 Agent 效率 = 总产出。3 个 Agent 并行理论上 3x 提速。

**前提条件**：
- 能准确判断哪些任务可以并行（有依赖的不行）
- CLAUDE.md 足够好，每个 Agent 独立工作也能产出一致的代码
- 熟悉 Git 分支管理

### How：具体执行步骤

#### Step 1：识别并行度（第 1-2 周）

```
可以并行 ✅                    不能并行 ❌
─────────────────              ─────────────────
不同页面/路由                   修改同一个文件
前端组件 vs 后端 API            有数据依赖的上下游模块
功能代码 vs 测试代码            共享状态管理的多个组件
独立的 bug 修复                 DB Schema + 依赖该 Schema 的 API
文档 vs 代码
```

**关键原则**：并行前必须先约定接口契约。

#### Step 2：Git Worktree 实操（第 1 周）

Git Worktree 让你在同一个仓库中同时检出多个分支到不同目录，每个目录运行独立的 Claude Code 实例：

```bash
# 主项目在 ./my-project

# 为并行任务创建 worktree
git worktree add ../my-project-feat-a feature/user-search
git worktree add ../my-project-feat-b feature/order-export
git worktree add ../my-project-fix fix/pagination-bug

# 每个 worktree 启动独立的 Claude Code（不同终端窗口/tmux pane）
cd ../my-project-feat-a && claude   # Terminal 1
cd ../my-project-feat-b && claude   # Terminal 2
cd ../my-project-fix && claude      # Terminal 3

# 完成后合并
cd ../my-project
git merge feature/user-search
git merge feature/order-export
git merge fix/pagination-bug

# 清理 worktree
git worktree remove ../my-project-feat-a
```

也可以在 Claude Code 中直接使用内置 Worktree 支持：

```
# Claude Code 内置命令
/worktree create feature/user-search
```

#### Step 3：并行管理流程（第 3-4 周）

```
Phase 1: 规划（5-10 分钟）
├── 列出今天要做的 3-5 个任务
├── 判断并行度
├── 约定接口契约（如 API Request/Response 类型）
└── 创建分支和 worktree

Phase 2: 分发（每个 Agent 2-3 分钟）
├── Agent 1: 给清晰的任务描述 + 接口契约
├── Agent 2: 同上
└── Agent 3: 同上

Phase 3: 监控（持续）
├── 轮流检查各 Agent 进度（每 5-10 分钟）
├── 先审查完成最快的 Agent
├── Agent 卡住时及时干预
└── 完成一个就合并一个（早发现冲突）

Phase 4: 整合（15-30 分钟）
├── 处理合并冲突
├── 运行完整测试
└── 清理 worktree
```

#### Step 4：跨 Agent 上下文同步（第 5-6 周）

**推荐方式：接口优先**

```bash
# 1. 先用一个 Agent 生成接口定义
"定义用户搜索功能的接口：
 - API 路由和参数类型
 - React Hook 的参数和返回值类型
 - 组件 Props 类型
 只生成类型定义文件 types/user-search.ts，不写实现"

# 2. 接口文件 commit 后，其他 Agent 基于接口并行开发
# Agent A (前端)："基于 types/user-search.ts 中的类型定义实现 UserSearch 组件"
# Agent B (后端)："基于 types/user-search.ts 中的类型定义实现 /api/users/search 端点"
# Agent C (测试)："基于 types/user-search.ts 中的类型定义编写测试用例"
```

### Done When：验收标准

- [ ] 稳定管理 3 个并行 Agent（日常开发中）
- [ ] 任务吞吐量对比单 Agent 提升 2x+
- [ ] 并行任务产生合并冲突的比例 < 10%
- [ ] 3 分钟内完成 Agent 间切换和审查
- [ ] AI 代码贡献 75-85%

**毕业测试**：同时启动 3 个 Agent 完成一个 Feature 的不同部分（API + 组件 + 测试），总耗时比串行快 2x+，合并后测试全部通过。

### Practice：练习任务

1. **首次并行**：2 个独立 bug fix 同时用 2 个 Claude 实例修复，记录总耗时 vs 串行预估
2. **前后端并行**：先用 5 分钟写接口契约，Agent A 开发 API，Agent B 用 mock 数据开发前端，完成后整合
3. **三路并行**：一个 Feature 拆成 3 部分（数据模型+API / UI 组件 / 测试），记录管理开销

### Anti-patterns：常见陷阱

| 陷阱 | 修正 |
|------|------|
| 一口气开 5+ 个 Agent 管不过来 | 从 2 个开始，稳定后加到 3 个 |
| 并行修改有依赖的模块 | 先画依赖图，只并行无依赖的任务 |
| 各 Agent 自己定义接口格式 | 并行前统一接口契约 |
| 所有 Agent 做完才合并 | 完成一个合并一个，早发现冲突 |
| 简单任务也硬拆并行 | 任务 < 30 分钟就单 Agent 做，并行有管理开销 |

---

## 6. Level 7：工作流编排

### Why：从"手动管理 Agent"到"系统自动编排"

Level 6 时你是项目经理——手动分配、监控、整合。
Level 7 时你是系统架构师——设计工作流，系统自动执行。

**编排的三大支柱**：
1. **CLAUDE.md**（进阶版）— 项目级的 AI 操作手册
2. **Custom Slash Commands** — 标准化的任务模板
3. **Hooks** — 自动化的质量检查点

重复的流程应该自动化。你每天做的"创建组件→写类型→写测试→lint 检查"这个循环，应该变成一个命令。

### How：具体执行步骤

#### Step 1：CLAUDE.md 进阶——工作流规则（第 1-2 周）

在基础版 CLAUDE.md 上增加工作流规则：

```markdown
# CLAUDE.md（在已有内容后追加）

## 工作流规则

### 文件创建规则
- 新组件必须同时创建：组件文件 + types.ts + xxx.test.tsx
- API 路由必须包含：handler + zod 验证 schema + 错误处理
- 数据库变更必须包含：migration + seed data

### Git 规范
- 分支命名：feat/xxx, fix/xxx, refactor/xxx
- Commit 格式：conventional commits（feat:, fix:, refactor:）
- 每个 commit 只做一件事

### 测试规则
- 所有新功能必须有测试
- 修 bug 必须先写失败测试再修复

### 安全底线
- 不使用 dangerouslySetInnerHTML
- API 路由必须验证用户权限
- 敏感信息不硬编码
```

#### Step 2：Custom Slash Commands（第 3-4 周）

在项目根目录创建 `.claude/commands/` 目录，每个 `.md` 文件就是一个可复用的命令：

```bash
mkdir -p .claude/commands
```

**命令 1：`.claude/commands/new-feature.md`**

```markdown
根据以下需求实现新功能：$ARGUMENTS

执行步骤：
1. 分析需求，列出需要创建/修改的文件，等我确认
2. 按确认的方案实现，遵守 CLAUDE.md 中的所有规范
3. 为所有新代码编写测试
4. 完成后自查：TypeScript 无错误、测试通过、符合代码规范
```

**命令 2：`.claude/commands/fix-bug.md`**

```markdown
修复以下 Bug：$ARGUMENTS

执行步骤：
1. 定位 bug 根因，解释为什么会出现
2. 编写一个失败测试来复现这个 bug
3. 修复 bug，确认测试通过
4. 检查是否有类似 bug 存在于其他地方
```

**命令 3：`.claude/commands/review.md`**

```markdown
审查当前的代码变更，从以下维度给出反馈：

1. 正确性：逻辑是否正确，边界情况是否处理
2. 安全性：XSS、注入、权限等安全问题
3. 性能：不必要的渲染、内存泄漏、N+1 查询
4. 可维护性：命名是否清晰、结构是否合理

输出格式：
- CRITICAL：必须修复
- WARNING：建议修复
- NIT：可选优化

审查范围：$ARGUMENTS
```

**命令 4：`.claude/commands/add-test.md`**

```markdown
为以下代码补充测试：$ARGUMENTS

要求：
- 覆盖正常路径和至少 3 个边界情况
- 使用 Vitest + Testing Library
- Mock 外部依赖（API 调用、数据库）
- 测试文件放在同目录下，命名为 xxx.test.tsx
```

**命令 5：`.claude/commands/refactor.md`**

```markdown
重构以下代码：$ARGUMENTS

约束：
- 不改变任何对外接口和行为
- 确保所有现有测试继续通过
- 每一步重构都可以独立 commit
- 解释每个重构决策的理由
```

使用方式：

```
/new-feature "用户搜索功能：支持姓名和邮箱搜索，数据量 < 200 条"
/fix-bug "分页组件在第一页时点击上一页报错"
/review "本次 PR 所有变更"
```

#### Step 3：Hooks 自动化质检（第 5-6 周）

在项目 `.claude/settings.json` 中配置 Hooks，让 Claude Code 在特定操作后自动执行检查：

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "command": "bash -c 'FILE=\"$CLAUDE_TOOL_PARAM_file_path\"; if [[ \"$FILE\" == *.ts || \"$FILE\" == *.tsx ]]; then npx tsc --noEmit \"$FILE\" 2>&1 | head -20; fi'"
      }
    ],
    "Notification": [
      {
        "matcher": "",
        "command": "terminal-notifier -message '$CLAUDE_NOTIFICATION' -title 'Claude Code' 2>/dev/null || true"
      }
    ]
  }
}
```

**实用 Hook 场景**：
- 写 `.ts/.tsx` 文件后 → 自动运行 TypeScript 类型检查
- 写测试文件后 → 自动运行该测试
- 任务完成时 → 发送桌面通知（方便并行管理多个 Agent 时感知进度）

#### Step 4：组合成完整工作流（第 7-8 周）

```
标准 Feature 开发流程：

1. /new-feature "需求描述"
   ↓ Claude 分析需求、给出方案、等确认

2. 你审核方案 → 确认/调整
   ↓ Claude 开始实现

3. Hooks 自动检查：
   ├── 每个文件写入后 → TypeScript 编译检查
   └── 测试文件写入后 → 自动运行测试

4. 实现完成后：
   /review
   ↓ Claude 自查代码

5. 通过审查 → 提交
```

### Done When：验收标准

- [ ] 有 5+ 个 Custom Commands 覆盖日常开发场景
- [ ] Hooks 配置了写文件后的自动类型检查
- [ ] CLAUDE.md 包含完整的工作流规则
- [ ] 80% 的开发任务有对应的 Command 可用
- [ ] 新人（或新 Claude 实例）仅靠 CLAUDE.md + Commands 能在 2 小时内完成一个小 Feature

**毕业测试**：让一个全新的 Claude Code 实例（无历史对话），仅依靠项目中的 CLAUDE.md + Custom Commands，完成一个 CRUD 页面。代码质量符合项目规范，无需大量修改。

### Practice：练习任务

1. **Command 库搭建**：创建上述 5 个 Commands，每个使用 1 周后迭代优化
2. **Hook 实战**：配置 TypeScript 检查 Hook，使用 1 周记录它拦截了多少次错误
3. **端到端测试**：用完整编排流程（Command → Hooks → Review）完成一个 Feature，记录手动干预次数

### Anti-patterns：常见陷阱

| 陷阱 | 修正 |
|------|------|
| 每个操作都加 Hook，AI 被反复打断 | 只在关键检查点加 Hook |
| Command 写得太死板，变成死板脚本 | 定义流程框架，细节让 AI 自适应 |
| CLAUDE.md 膨胀到 500 行 | 控制 200 行以内，细节放 Commands |
| 只自己用不分享给团队 | Commands 和 CLAUDE.md 提交到仓库 |
| 写了 Command 就不改了 | 用两周后回顾，删掉没用的、优化常用的 |

---

## 7. Level 8：自动化编排系统

### Why：从"人触发 AI 执行"到"事件触发 AI 自主执行"

Level 7 的你还在手动输入 `/new-feature`。Level 8 时，系统自动响应事件：

- PR 提交 → AI 自动 Code Review
- CI 失败 → AI 自动尝试修复
- Issue 创建 → AI 自动分类 + 生成初始方案

你的 AI 能力从个人技能变成**团队基础设施**。

**重要提醒**：Level 8 不是所有人都需要的。如果你的团队/项目不需要这个级别的自动化，停在 Level 7 完全可以。过度自动化本身就是一种反模式。

### How：具体执行步骤

#### Step 1：Headless 模式基础（第 1-2 周）

Claude Code 的 Headless 模式（`-p` 参数）允许非交互式调用，适合脚本和 CI/CD 集成：

```bash
# 基本用法
claude -p "分析这段代码的性能问题" < code.ts

# JSON 输出（方便脚本解析）
claude -p "列出这个文件的所有导出函数" --output-format json

# 指定允许的工具
claude -p "修复这个 TypeScript 错误：$(cat error.log)" \
  --allowedTools "Read,Write,Edit,Bash"
```

**实用 Headless 脚本示例（Shell）**：

```bash
#!/bin/bash
# scripts/ai-gen-tests.sh
# 为所有没有测试的组件自动生成测试

find components/features -name "*.tsx" | while read component; do
  test_file="${component%.tsx}.test.tsx"
  if [ ! -f "$test_file" ]; then
    echo "Generating test for: $component"
    claude -p "为以下组件生成 Vitest + Testing Library 测试。
    组件路径：$component
    测试文件路径：$test_file
    覆盖正常路径和 3 个边界情况。" \
      --allowedTools "Read,Write" \
      --output-format json
  fi
done
```

#### Step 2：CI/CD 集成——PR 自动 Review（第 3-4 周）

```yaml
# .github/workflows/ai-review.yml
name: AI Code Review

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  ai-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Get changed files
        id: changed
        run: |
          FILES=$(git diff --name-only origin/main...HEAD | grep -E '\.(ts|tsx)$' | tr '\n' ' ')
          echo "files=$FILES" >> $GITHUB_OUTPUT

      - name: AI Review
        if: steps.changed.outputs.files != ''
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          npx @anthropic-ai/claude-code -p \
            "Review these changed files for bugs, security issues, and code quality.
             Files: ${{ steps.changed.outputs.files }}
             Focus on CRITICAL and WARNING issues only.
             Output as markdown." \
            --allowedTools "Read" > review.md

      - name: Post Review Comment
        if: steps.changed.outputs.files != ''
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const review = fs.readFileSync('review.md', 'utf8');
            await github.rest.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: context.issue.number,
              body: `## AI Code Review\n\n${review}`
            });
```

#### Step 3：CI 失败自动修复（第 5-6 周）

```yaml
# .github/workflows/ai-autofix.yml
name: AI Auto-Fix

on:
  workflow_run:
    workflows: ["CI"]
    types: [completed]

jobs:
  auto-fix:
    if: ${{ github.event.workflow_run.conclusion == 'failure' }}
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Get failure logs
        run: |
          gh run view ${{ github.event.workflow_run.id }} --log-failed > failure.log 2>&1 || true
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: AI Fix Attempt
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          npx @anthropic-ai/claude-code -p \
            "CI failed. Error log:
             $(head -100 failure.log)

             Analyze the failure and fix it.
             Only fix the actual error. Do not refactor or change unrelated code." \
            --allowedTools "Read,Write,Edit,Bash"

      - name: Verify fix
        run: npm test

      - name: Create fix PR
        if: success()
        run: |
          BRANCH="fix/auto-ci-$(date +%s)"
          git checkout -b "$BRANCH"
          git add -A
          git commit -m "fix: auto-fix CI failure"
          git push origin "$BRANCH"
          gh pr create \
            --title "fix: Auto-fix CI failure" \
            --body "Automatically generated by AI to fix CI failure. **Requires human review.**" \
            --label "auto-fix,needs-review"
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

#### Step 4：Issue 自动分类（第 7-8 周）

```yaml
# .github/workflows/ai-triage.yml
name: AI Issue Triage

on:
  issues:
    types: [opened]

jobs:
  triage:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: AI Triage
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          npx @anthropic-ai/claude-code -p \
            "New issue:
             Title: ${{ github.event.issue.title }}
             Body: ${{ github.event.issue.body }}

             1. Classify: bug / feature / question
             2. Estimate: S / M / L / XL
             3. Suggest which files might need changes
             Output as JSON: {type, size, files, summary}" \
            --output-format json > triage.json

      - name: Apply labels
        uses: actions/github-script@v7
        with:
          script: |
            const triage = require('./triage.json');
            const result = JSON.parse(triage.result || '{}');
            const labels = [result.type, `size-${result.size}`].filter(Boolean);
            if (labels.length > 0) {
              await github.rest.issues.addLabels({
                owner: context.repo.owner,
                repo: context.repo.repo,
                issue_number: context.issue.number,
                labels
              });
            }
            if (result.summary) {
              await github.rest.issues.createComment({
                owner: context.repo.owner,
                repo: context.repo.repo,
                issue_number: context.issue.number,
                body: `**AI Triage**: ${result.summary}\n\nPotentially affected files: ${(result.files || []).join(', ')}`
              });
            }
```

#### Step 5：成本控制和监控（持续）

```bash
#!/bin/bash
# scripts/ai-metrics.sh — 每周运行一次

echo "=== AI Engineering Metrics ($(date +%Y-%m-%d)) ==="

echo ""
echo "Auto-fix PRs this week:"
gh pr list --label "auto-fix" --state all --json createdAt \
  --jq '[.[] | select(.createdAt > (now - 7*24*3600 | todate))] | length'

echo ""
echo "Auto-fix success rate:"
TOTAL=$(gh pr list --label "auto-fix" --state all --json state | jq length)
MERGED=$(gh pr list --label "auto-fix" --state merged --json state | jq length)
if [ "$TOTAL" -gt 0 ]; then
  echo "$MERGED / $TOTAL ($(( MERGED * 100 / TOTAL ))%)"
else
  echo "No auto-fix PRs yet"
fi

echo ""
echo "Cost check: run '/cost' in Claude Code sessions"
```

### Done When：验收标准

- [ ] PR 自动 Review 已上线并运行 2+ 周
- [ ] CI 失败自动修复已配置（修复成功率 > 30%）
- [ ] Issue 自动分类已配置
- [ ] 有成本监控机制（API Key 花费可追踪）
- [ ] 自动修复的 PR 必须经人工审查（安全护栏到位）

**毕业测试**：上述三个自动化流程运行 2 周。PR Review 覆盖率 100%，自动修复成功率 > 30%，团队反馈正面。

### Practice：练习任务

1. **Headless 脚本**：写一个脚本用 `claude -p` 批量为无测试的组件生成测试文件
2. **PR Review 机器人**：部署 AI Review GitHub Action，运行 1 周后评估 Review 质量
3. **自愈 Pipeline**：配置 CI 自动修复，记录 2 周内的修复尝试和成功率

### Anti-patterns：常见陷阱

| 陷阱 | 修正 |
|------|------|
| 所有事都想自动化 | 只自动化重复、耗时、有模式可循的任务 |
| AI 自动提交没人审查 | 自动修复必须走 PR + 人工审查 |
| API 成本失控 | 设置费用告警、限制每小时调用次数 |
| API Key 硬编码 | 用 GitHub Secrets，遵循最小权限 |
| AI Review 噪音太多 | 调整 Prompt 只报告 CRITICAL 和 WARNING |
| 搭了自动化但不看效果 | 每周看 metrics，至少追踪成功率和成本 |

---

## 8. 附录：模板与速查表

### A. CLAUDE.md 完整模板

```markdown
# CLAUDE.md

## 项目概述
[一句话描述]

## 技术栈
- Next.js 14 (App Router), TypeScript (strict)
- Tailwind CSS + shadcn/ui
- Prisma + PostgreSQL
- TanStack Query v5, Zustand
- Vitest + Testing Library + Playwright

## 目录结构
app/                 → Next.js App Router 路由
  (auth)/            → 需要登录的页面
  api/               → API 路由
components/
  ui/                → shadcn/ui（不手动修改）
  features/          → 业务组件
  layout/            → 布局组件
lib/                 → 工具函数（db.ts, auth.ts, utils.ts）
hooks/               → 自定义 Hooks
types/               → 全局类型
prisma/
  schema.prisma      → 数据库 Schema
  migrations/        → 迁移文件

## 代码规范
- 文件名：kebab-case（user-profile.tsx）
- 组件：PascalCase 命名导出（export function UserProfile）
- 函数/变量：camelCase
- 客户端组件加 'use client'，服务端组件不加
- 数据获取：服务端用 Prisma 直查，客户端用 React Query
- 表单验证用 zod
- 样式用 cn() 合并 Tailwind 类名

## 工作流规则
- 新组件必须同时创建测试文件
- API 路由必须有 zod 输入验证
- 修 bug 先写失败测试再修
- Git commit 用 conventional commits

## 常用命令
npm run dev          → 开发服务器 (localhost:3000)
npm test             → Vitest
npm run lint         → ESLint
npx prisma studio    → 数据库 GUI
npx prisma migrate dev → 运行迁移
```

### B. Custom Commands 速查

| 命令 | 用途 | 文件路径 |
|------|------|---------|
| `/new-feature` | 新功能开发 | `.claude/commands/new-feature.md` |
| `/fix-bug` | Bug 修复（含 TDD） | `.claude/commands/fix-bug.md` |
| `/review` | 代码审查 | `.claude/commands/review.md` |
| `/add-test` | 补充测试 | `.claude/commands/add-test.md` |
| `/refactor` | 安全重构 | `.claude/commands/refactor.md` |

### C. Claude Code CLI 速查

```bash
# 启动与基本操作
claude                     # 启动交互式会话
claude -p "prompt"         # Headless 模式（非交互式）
claude -p "..." --output-format json  # JSON 输出

# 会话中命令
/init                      # 初始化 CLAUDE.md
/plan                      # 进入 Plan Mode
/compact                   # 压缩对话上下文
/cost                      # 查看 Token 使用量
/clear                     # 清除对话历史
/new-feature "描述"        # 执行自定义 Command

# Git Worktree（并行开发）
git worktree add ../proj-feat feature/xxx
git worktree list
git worktree remove ../proj-feat

# 推荐 Shell 别名
alias cc='claude'
alias ccp='claude -p'
```

### D. 进阶路线图

```
Week 1-4:    Level 1-2  ← 建立 AI 使用习惯
Week 5-8:    Level 3-4  ← 提示词工程 + CLAUDE.md
Week 9-14:   Level 5    ← 意图驱动开发
Week 15-20:  Level 6    ← 多 Agent 并行
Week 21-26:  Level 7    ← 工作流编排
Week 27-32:  Level 8    ← 自动化系统（按需）
```

每个 Level 的毕业测试通过再往下走。进度比时间表快是好事，比时间表慢也正常——关键是每一步都扎实。

### E. 何时降级

高 Level 不是目标，高效才是。以下情况应降级：

| 场景 | 降级到 | 原因 |
|------|--------|------|
| 简单 bug fix（< 10 分钟） | Level 4 | 单 Agent 即可，并行有管理开销 |
| 探索性原型 | Level 3 | 方向不确定时迭代对话更高效 |
| 安全敏感代码（支付、认证） | Level 4 | 需要逐行人工审查 |
| AI 方案反复不对 | Level 4 | 退回 How 描述，给更具体指令 |
| 自动修复连续失败 | Level 7 | 关闭自动化，手动 debug |

---

> 这份指南是框架不是教条。根据你的项目和团队调整节奏。每天比昨天多用一点 AI，每周比上周多自动化一个流程，持续迭代就够了。
