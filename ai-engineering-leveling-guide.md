# Complete Guide to AI Engineering Skills (Level 1 → Level 8)

> **Target audience**: All software engineers using AI-assisted programming
> **Core tool**: Claude Code CLI
> **How to use**: Each Level has a clear acceptance Checklist — check off every item before moving to the next stage
> **About examples**: Code examples in this guide primarily use React/Next.js (TypeScript), but Level definitions and acceptance criteria apply to any tech stack. Substitute the specific technologies in examples with your own project's stack.

---

## Table of Contents

1. [Overview: Level Definitions + Self-Assessment](#1-overview-level-definitions--self-assessment)
2. [Level 1-2: Getting Started with AI-Assisted Programming](#2-level-1-2-getting-started-with-ai-assisted-programming)
3. [Level 3-4: Prompt Engineering + Project Context Management](#3-level-3-4-prompt-engineering--project-context-management)
4. [Level 5: Intent-Driven Development](#4-level-5-intent-driven-development)
5. [Level 6: Multi-Agent Parallelism](#5-level-6-multi-agent-parallelism)
6. [Level 7: Workflow Orchestration](#6-level-7-workflow-orchestration)
7. [Level 8: Automated Orchestration System](#7-level-8-automated-orchestration-system)
8. [Appendix: Templates & Quick Reference](#8-appendix-templates--quick-reference)

---

## 1. Overview: Level Definitions + Self-Assessment

### Level Overview

| Level | Name | What You're Doing | What AI Is Doing |
|-------|------|-------------------|------------------|
| 1 | Zero Contact | Writing all code by hand | Non-existent |
| 2 | Completion Reliance | Writing code, occasionally pressing Tab to accept completions | Typing assistant |
| 3 | Conversational Collaboration | Asking questions in Chat, copy-pasting answers | Search engine replacement |
| 4 | Prompt Engineering | Writing structured prompts, managing project context | A junior engineer following instructions |
| 5 | Intent-Driven | Describing business intent, reviewing AI's proposals | A mid-level engineer who can deliver independently |
| 6 | Multi-Agent Parallelism | Managing multiple AI task streams simultaneously | A parallelizable development team |
| 7 | Workflow Orchestration | Designing standardized processes for AI to execute | A dev-time automated pipeline |
| 8 | Automated System | Configuring event triggers, AI running autonomously 24/7 | Unattended infrastructure |

### Self-Assessment (0-2 points per item)

**Foundational Skills (Level 1-2)**
- [ ] Using AI code completion in daily development
- [ ] Able to have basic conversations in Claude Code
- [ ] Can judge whether AI-generated code is usable

**Prompting Skills (Level 3-4)**
- [ ] Can write structured prompts with context + constraints + expected output
- [ ] Project has a CLAUDE.md that is kept up to date
- [ ] Using Plan Mode for complex tasks
- [ ] Less than 20% of AI-generated code requires manual modification

**Autonomous Development (Level 5)**
- [ ] Describing business intent rather than technical implementation; AI independently selects approach
- [ ] Can delegate complete Features (spanning multiple modules and tests)
- [ ] AI proposals pass architecture review on first attempt > 80% of the time

**Parallelism & Orchestration (Level 6-7)**
- [ ] Can manage 3+ parallel AI task streams (built-in parallelism or multiple instances)
- [ ] Can correctly distinguish parallelizable vs. must-be-serial tasks
- [ ] Have 5+ Custom Slash Commands
- [ ] Hooks configured for automated quality checks

**System Level (Level 8)**
- [ ] AI integrated into CI/CD (Headless mode)
- [ ] AI can automatically fix failed Pipelines
- [ ] Complete AI workflow monitoring and cost controls in place

**Scoring**: 0-4 → Level 1-2 ｜ 5-8 → Level 3-4 ｜ 9-11 → Level 5 ｜ 12-15 → Level 6-7 ｜ 16-18 → Level 8

---

## 2. Level 1-2: Getting Started with AI-Assisted Programming

### Why: Why Start Here

The goal at this stage isn't to get AI to write perfect code — it's to **build muscle memory for using AI**.

Skipping this stage and jumping straight to advanced techniques leads to:
- Not trusting AI output → Spending more time reviewing → Feeling AI is useless → Giving up
- Lacking intuition about AI output quality → Every subsequent decision is slower

Core mindset: **Let AI help you write code that you know how to write but don't feel like writing** (boilerplate, type definitions, test scaffolding).

### How: Step-by-Step Execution

#### Week 1: Installation + Building Completion Habits

```bash
# Install Claude Code
npm install -g @anthropic-ai/claude-code

# Launch in your project directory
cd your-project
claude
```

**Daily practice**: Consciously let AI complete the following while coding:
- Component/class structural scaffolding
- Type definitions/interface definitions
- Repetitive pattern code (loops, conditionals, configuration items)
- Boilerplate code

> The following uses React/TypeScript as an example — substitute with your own tech stack:
> - JSX structure for React components
> - TypeScript type/interface definitions
> - Dependency arrays for `useEffect`, `useCallback`, and other Hooks
> - Repetitive code (map rendering, form fields)

#### Week 2: Learning to Ask Questions in Claude Code

Start with small, specific questions:

```
Good questions (bounded, with context):
  "This code throws TS2345 error, error message is [paste], how to fix?"
  "Rewrite this class component as a function component + hooks"
  "Add error handling and loading state to the getUserById function"

Bad questions (too broad, too vague):
  "Help me optimize the code"
  "Build me an admin dashboard"
```

#### Weeks 3-4: Building Review Intuition

After each AI code generation, check three things:
1. **Type safety** — Are there any `any` types? Are edge cases handled?
2. **Project consistency** — Do naming, file organization, and import patterns follow project conventions?
3. **Comprehensibility** — Can you explain every line to someone else? If not, ask the AI to clarify

### Done When: Acceptance Criteria

- [ ] Using AI completion naturally every day (no need to consciously remind yourself)
- [ ] At least 3 effective conversations in Claude Code per day
- [ ] AI contributes 20-30% of code (non-critical paths)
- [ ] Have a habit of "accept/modify/reject" judgment for every piece of AI code

> **💡 Self-test method**: Review the code you wrote today — how many pieces were AI-completed/generated? If more than 5, you've formed the habit. "Accept/modify/reject" doesn't require tracking numbers — as long as you find yourself naturally thinking "is this line correct?" when looking at AI code, you've met the bar.

**Graduation test**: Complete a small Feature with 3 components (e.g., form + list + detail view) using AI assistance. AI contributes 20%+ of code, and you can explain every line.

### Practice: Exercises

1. **Type generation**: Give Claude a JSON response sample from an API, have it generate corresponding type definitions (TypeScript interface / Python dataclass / Go struct, etc.). Compare with your hand-written version
2. **Component scaffolding**: Have Claude generate a data display component (e.g., `<DataTable>` with sorting + pagination), annotate line by line what needs modification
3. **Code explanation**: Find a piece of code in your project that you don't fully understand, have Claude explain it, then verify accuracy

### Anti-patterns: Common Pitfalls

| Pitfall | Fix |
|---------|-----|
| Copy-pasting code without reading it | Build the "three things check" habit |
| Asking AI even for variable names | Only use AI when it saves 30+ seconds |
| Repeatedly asking AI to rewrite seeking perfection | Accept when 80% good enough, manually adjust the 20% |
| Just saying "help me fix a bug" with no context | Must include: error message + code snippet + expected behavior |

---

## 3. Level 3-4: Prompt Engineering + Project Context Management

### Why: Why Prompt Quality Is the Efficiency Inflection Point

At Level 2, your conversations with AI might take 5-10 round trips to get satisfactory results.
By the time you graduate Level 4, this should drop to **1-3 round trips**.

What's the difference? It's not that AI got smarter — you learned to **provide all the information at once**.

This stage builds two core capabilities:
1. **Structured prompts** — Getting high-quality output from AI in one shot
2. **CLAUDE.md project context** — Having AI automatically inherit project conventions without repeating yourself every time

### How: Step-by-Step Execution

#### Step 1: Master Claude Code Core Features (Week 1)

```bash
# Initialize project-level configuration
claude /init
# → Auto-generates CLAUDE.md with project structure, tech stack, coding conventions

# Plan Mode: Plan before executing (essential for complex tasks)
# In the conversation, type:
/plan
# → Claude will provide a step-by-step plan for you to review before execution
# → You can ask questions and adjust the plan in Plan Mode

# Compress context (when long conversations affect quality)
/compact

# Check Token consumption
/cost
```

**Plan Mode usage example**:

```
You: "I need to add search functionality to the user list page,
      supporting search by name and email"

Claude (Plan Mode):
  1. Create useUserSearch hook (debounce + React Query)
  2. Modify UserList component, add SearchInput
  3. Backend: add /api/users/search endpoint
  4. Add search result highlighting

You: "Plan looks good, but search should use frontend filtering —
      the dataset won't exceed 200 items. No backend endpoint needed."

Claude: Got it, revising the plan... (adjusts and executes)
```

#### Step 2: Structured Prompts — The CRATE Framework (Week 2)

```markdown
## Context
Next.js 14 App Router project, Tailwind CSS + shadcn/ui.
Currently working in the app/dashboard/ directory.

## Role (optional — use for complex tasks)
You are a senior frontend engineer experienced with Next.js App Router and RSC.

## Action (what to do)
Create a Dashboard data overview card component.

## Target (specific deliverables)
- File: components/dashboard/stats-card.tsx
- Props: title: string, value: number, trend: number, icon: LucideIcon
- Use shadcn/ui Card component

## Expectation (acceptance criteria)
- Server Component (no 'use client')
- Positive trend → green ↑, negative trend → red ↓
- Responsive layout: single column on mobile, grid-compatible on desktop
```

You don't need to fill in all 5 sections every time. For simple tasks, Context + Action is enough. The key is **giving AI enough information to make good judgments**.

#### Step 3: Configure CLAUDE.md (Week 3)

CLAUDE.md is the project-level "AI operating manual." Claude Code reads it every time it starts.

```markdown
# CLAUDE.md

## Project Overview
Next.js 14 App Router e-commerce admin dashboard

## Tech Stack
- Next.js 14 (App Router), TypeScript (strict)
- Tailwind CSS + shadcn/ui
- Prisma + PostgreSQL
- TanStack Query v5

## Coding Conventions
- Components: named exports (no default export)
- File names: kebab-case (stats-card.tsx)
- Types: defined in types.ts file in the same directory
- Data fetching: Server Components use direct Prisma queries; client-side uses React Query
- Styling: use cn() to merge Tailwind class names

## Directory Structure
app/           → Routes and pages
components/ui/ → shadcn/ui base components (do not modify manually)
components/features/ → Business components
lib/           → Utility functions
hooks/         → Custom Hooks
types/         → Global types

## Common Commands
npm run dev    → Development server
npm test       → Vitest tests
npm run lint   → ESLint
```

**Key principle**: Keep CLAUDE.md under 200 lines. If it's too long, AI will actually ignore important rules.

#### Step 4: Iterative Conversation Rather Than One-Shot Perfection (Week 4)

```
# Round 1: Big picture
"Add a user activity line chart to the dashboard"

# Round 2: Refine after seeing the proposal
"Use recharts, x-axis by week, last 12 weeks"

# Round 3: Polish
"Add a loading skeleton and empty state"
```

This is more efficient than spending 30 minutes crafting one "perfect prompt."

### Done When: Acceptance Criteria

- [ ] Prompts average 1-3 rounds to get satisfactory results (track your last 10 tasks)
- [ ] CLAUDE.md is configured with tech stack + conventions + directory structure
- [ ] Complex tasks (spanning 3+ files) use Plan Mode 100% of the time
- [ ] AI code contribution 50-60%, manual modifications < 20%

> **💡 Self-test method**: Review your last 5 tasks — how many rounds of conversation with AI did each take? If ≥4 tasks were done in 3 rounds or fewer, you've met the bar. A simple check for "manual modifications < 20%": after AI finishes writing, you only need to change a few things (variable names, edge cases) rather than rewriting large sections.

**Graduation test**: Complete a data table with filtering + sorting + pagination. Use Plan Mode for planning, 1-3 prompt rounds to complete. Less than 20% of AI code requires manual modification.

### Practice: Exercises

1. **CLAUDE.md validation**: After writing CLAUDE.md, have Claude create a new component and check whether it follows your naming conventions, export style, and file location
2. **CRATE comparison**: Use both a "one-liner prompt" and a CRATE-formatted prompt for the same task, compare output quality and number of round trips
3. **Deep Plan Mode usage**: Pick a Feature spanning 3+ files, use Plan Mode throughout. Record deviations between plan and actual execution

### Anti-patterns: Common Pitfalls

| Pitfall | Fix |
|---------|-----|
| Dumping the entire codebase on AI for help | Only provide necessary files and context |
| CLAUDE.md is 500 lines long | Keep it under 200 lines, prioritize core rules |
| Letting AI modify code without Plan Mode | Cross-file tasks must start with Plan Mode |
| Writing a 200-line prompt specifying every detail | Provide a framework, let AI propose solutions, you make choices |
| Writing CLAUDE.md once and never updating it | Update whenever tech stack or conventions change |

---

## 4. Level 5: Intent-Driven Development

### Why: From "Telling AI How" to "Telling AI Why"

Level 4 you: "Implement an infinite scroll list with useInfiniteQuery, 20 items per page, trigger loading with Intersection Observer"
Level 5 you: "Users are complaining the order list loads slowly, there are 5000+ records. Please optimize the user experience."

When you describe Why/What instead of How:
- AI might suggest a better solution you hadn't considered (e.g., virtual list instead of infinite scroll)
- You shift from "coding executor" to "product decision-maker"
- Your time moves from writing code to reviewing proposals and making architecture decisions

**Prerequisite**: You must have the ability to judge whether AI's proposals are good or bad. This requires engineering fundamentals — that's why you can't skip the earlier stages.

### How: Step-by-Step Execution

#### Step 1: Learn to Describe Intent (Weeks 1-2)

**Conversion exercise — rewrite How as Why/What**:

```
Before (How):
  "In the UserList component, add useState to manage the search term,
   add an input field, setState on onChange,
   pass the search term in the useQuery parameters"

After (Why/What):
  "The user list page needs search functionality.
   Scenario: Admins need to quickly find a specific user among 5000+ users.
   Performance requirement: No input lag, search response < 500ms.
   Please propose a solution and implement it."
```

#### Step 2: Feature-Level Delegation (Weeks 3-4)

Hand complete Features to AI — you only handle requirements definition and proposal review:

```markdown
## Requirement: Order Export Feature

### Business Background
The operations team needs to export order data to Excel every week; currently they can only copy manually.

### User Story
An operations staff member clicks "Export" on the order list page, exporting a CSV based on current filter criteria.

### Constraints
- Maximum export volume: 100,000 rows
- Fields: order number, customer name, amount, status, creation date
- Show progress for large datasets
- File name: orders_YYYYMMDD_HHmmss.csv

### Not Needed
- No .xlsx format
- No background task queue

### Acceptance Criteria
- [ ] Exporting 1,000 records takes < 3 seconds
- [ ] Special characters (commas, quotes) are properly escaped
- [ ] Loading state and error messages are present
```

#### Step 3: Proposal Review — Your New Core Job (Weeks 5-6)

After AI provides a proposal, review it with this checklist:

```
1. Architecture Soundness
   □ Fits existing project patterns?
   □ No over-engineering?

2. Edge Cases
   □ Error handling is thorough?
   □ Concurrency/race conditions considered?
   □ Empty data and large datasets both handled?

3. Performance
   □ No unnecessary re-renders?
   □ Data fetching strategy is sound?

4. Security
   □ No XSS/injection risks?
   □ Authorization checks in place?
```

#### Step 4: Trust Through Testing (Weeks 7-8)

```
"Implement the order export feature with the following requirements:
 - Write tests before implementation (TDD)
 - Unit tests: CSV generation logic (including special character escaping)
 - Integration tests: export API endpoint
 - Component tests: export button interaction states"
```

Tests passing = you can trust the code. This is 10x more efficient than line-by-line review.

#### Step 4: Task Decomposition & Dependency Analysis (Weeks 7-8)

This is a prerequisite skill for Level 6 (Multi-Agent Parallelism). Learn to decompose first, then learn to parallelize.

**Exercise: Break a Feature into independent subtasks**

```
Requirement: Order management page

Decomposition:
├── Subtask 1: Order data model + API (independent)
├── Subtask 2: Order list component (depends on Subtask 1's type definitions)
├── Subtask 3: Order detail component (depends on Subtask 1's type definitions)
├── Subtask 4: Filter/search functionality (depends on Subtask 2)
└── Subtask 5: Tests (depends on Subtasks 1-4)

Dependency graph:
  1 ──→ 2 ──→ 4
  │     │
  └──→ 3     5 (last)

Parallelizable combinations:
  - After agreeing on type definitions: Subtask 2 and Subtask 3 can run in parallel
  - Subtask 4 must wait for Subtask 2 to complete
```

**Key skills:**
- Identifying dependencies between tasks (data dependencies, file dependencies, logic dependencies)
- Finding "interface points" — boundaries where you can agree on interfaces first, then develop independently
- Evaluating decomposition granularity — too fine means high management overhead, too coarse means no parallelism possible

> 💡 At Level 5, you still use a single Agent to execute these subtasks serially. But once you've learned to decompose, transitioning to Level 6 only requires changing "serial execution" to "parallel execution" — the barrier will be much lower.

### Done When: Acceptance Criteria

- [ ] What/Why makes up > 70% of prompts (review your last 10 prompts)
- [ ] Completed 3+ Feature-level delegations (frontend + API + tests)
- [ ] AI proposals pass architecture review on first attempt > 80% of the time
- [ ] Can decompose complex Features into 3+ subtasks and map out their dependencies
- [ ] Feature completion speed is 2x+ faster compared to writing entirely by hand (track 3 Features for comparison)
- [ ] AI code contribution 60-75%

> **💡 Self-test method**: Look through your last 10 prompts — count how many describe "what/why" rather than "how to do it". ≥7 out of 10 means 70%. For "passes architecture review on first attempt": out of the last 5 times you had AI propose a solution, how many times did you think "I can use this directly" rather than "this needs major changes"? ≥4 times means 80%.

**Graduation test**: Complete a full Feature (frontend + API + database) using intent descriptions throughout — never specifying implementation approach. AI proposal passes architecture review on first attempt, total time is 2x+ faster than writing by hand.

### Practice: Exercises

1. **Intent rewrite**: Take your last 5 prompts, rewrite them using intent-driven approach, compare AI output quality between the two versions
2. **Proposal showdown**: Use both How and What approaches for the same requirement, compare which produces a more comprehensive solution
3. **Feature delegation**: Pick a 4-8 hour Feature and hand it to AI. Track total time, prompt rounds, and manual modification percentage
4. **Task decomposition**: Pick a medium-complexity Feature, draw a subtask dependency graph, and mark which tasks can be parallelized

### Anti-patterns: Common Pitfalls

| Pitfall | Fix |
|---------|-----|
| "I want to use useState for search" (still How) | Describe the user scenario and problem, don't mention technical solutions |
| Not reviewing after AI finishes | Shift review focus from code details to architecture proposals |
| Just saying "add search" with no background | Always provide: business scenario + data scale + performance requirements |
| Accepting AI's first proposal without question | Always ask at least once: "Is there a better approach? Why did you choose this one?" |

---

## 5. Level 6: Multi-Agent Parallelism

### Why: The Efficiency Leap from Serial to Parallel

Level 5 workflow: Write component → Write API → Write tests → Adjust styling (serial)
Level 6 workflow: Agent A writes component + Agent B writes API + Agent C writes tests (parallel)

**Efficiency formula**: Parallelism × Single Agent Efficiency = Total Output. 3 parallel Agents theoretically means 3x speedup.

**Prerequisites**:
- Ability to accurately judge which tasks can be parallelized (those with dependencies cannot)
- CLAUDE.md is good enough that each Agent working independently still produces consistent code
- Familiarity with Git branch management

### How: Step-by-Step Execution

#### Step 1: Identify Parallelism Opportunities (Weeks 1-2)

```
Can parallelize ✅                    Cannot parallelize ❌
─────────────────                     ─────────────────
Different pages/routes                Modifying the same file
Frontend components vs backend API    Upstream/downstream modules with data dependencies
Feature code vs test code             Multiple components sharing state management
Independent bug fixes                 DB Schema + APIs that depend on that Schema
Documentation vs code
```

**Key principle**: Always agree on interface contracts before parallelizing.

#### Step 2: Choosing a Parallelization Approach

There are two main approaches to parallel development — choose based on the scenario:

**Approach A: Claude Code Built-in Parallelism (recommended for parallel tasks within the same project)**

Claude Code's Task tool supports launching sub-Agents to execute tasks in parallel without switching terminals:

```
"I need to complete these three independent tasks simultaneously:
 1. Add search functionality to the UserList component
 2. Fix the pagination component bug when clicking 'previous' on the first page
 3. Add tests for the OrderDetail component

 These three tasks have no dependencies — please execute them in parallel."
```

Pros: No worktree management needed, no terminal switching, works automatically within the same context.
Best for: Independent tasks modifying different files, batch bug fixes, adding tests, etc.

**Approach B: Git Worktree + Multiple Instances (for isolated development of large Features)**

When parallel tasks involve extensive file changes and potential conflicts, use Worktree for physical isolation:

```bash
# Main project is at ./my-project

# Create worktrees for parallel tasks
git worktree add ../my-project-feat-a feature/user-search
git worktree add ../my-project-feat-b feature/order-export
git worktree add ../my-project-fix fix/pagination-bug

# Launch independent Claude Code in each worktree (different terminal windows/tmux panes)
cd ../my-project-feat-a && claude   # Terminal 1
cd ../my-project-feat-b && claude   # Terminal 2
cd ../my-project-fix && claude      # Terminal 3

# Merge when complete
cd ../my-project
git merge feature/user-search
git merge feature/order-export
git merge fix/pagination-bug

# Clean up worktrees
git worktree remove ../my-project-feat-a
```

Pros: Complete isolation, no interference, ideal for large changes.
Best for: Multiple large Features in parallel, frontend/backend separated development, scenarios requiring independent builds/tests.

**How to choose:**

| Scenario | Recommended Approach | Reason |
|----------|---------------------|--------|
| 3 independent bug fixes | Built-in parallelism | Small changes, no isolation needed |
| Adding tests for multiple components | Built-in parallelism | Test files are independent, no conflicts |
| Frontend + backend + tests in parallel | Worktree | Large changes, need isolated environments |
| Multiple large Features progressing simultaneously | Worktree | Each has its own branch and tests |

#### Step 3: Parallel Management Workflow (Weeks 3-4)

```
Phase 1: Planning (5-10 minutes)
├── List 3-5 tasks for today
├── Assess parallelism opportunities
├── Agree on interface contracts (e.g., API Request/Response types)
└── Create branches and worktrees

Phase 2: Distribution (2-3 minutes per Agent)
├── Agent 1: Give clear task description + interface contract
├── Agent 2: Same as above
└── Agent 3: Same as above

Phase 3: Monitoring (ongoing)
├── Rotate checking each Agent's progress (every 5-10 minutes)
├── Review the fastest-completing Agent first
├── Intervene promptly when an Agent gets stuck
└── Merge each one as it completes (catch conflicts early)

Phase 4: Integration (15-30 minutes)
├── Resolve merge conflicts
├── Run the full test suite
└── Clean up worktrees
```

#### Step 4: Cross-Agent Context Synchronization (Weeks 5-6)

**Recommended approach: Interface-first**

```bash
# 1. Use one Agent to generate interface definitions
"Define the interfaces for the user search feature:
 - API routes and parameter types
 - React Hook parameter and return value types
 - Component Props types
 Only generate the type definition file types/user-search.ts, no implementation"

# 2. After committing the interface file, other Agents develop in parallel based on it
# Agent A (Frontend): "Implement the UserSearch component based on types in types/user-search.ts"
# Agent B (Backend): "Implement the /api/users/search endpoint based on types in types/user-search.ts"
# Agent C (Tests): "Write test cases based on types in types/user-search.ts"
```

### Done When: Acceptance Criteria

- [ ] Stably managing 3 parallel Agents (in daily development)
- [ ] Task throughput improved 2x+ compared to single Agent
- [ ] Merge conflicts from parallel tasks occur < 10% of the time
- [ ] Switching between Agents and reviewing takes < 3 minutes
- [ ] AI code contribution 75-85%

> **💡 Self-test method**: A simple check for "2x speedup": a task you estimate would take 2 hours serially, completed in under 1 hour with parallelism (including management overhead), counts as 2x. "Conflicts < 10%": out of the last 10 parallel merges, if ≤1 had conflicts, you've met the bar.

**Graduation test**: Launch 3 Agents simultaneously to complete different parts of a Feature (API + component + tests), total time is 2x+ faster than serial, all tests pass after merging.

### Practice: Exercises

1. **First parallel run**: Fix 2 independent bugs simultaneously with 2 Claude instances, record total time vs estimated serial time
2. **Frontend-backend parallel**: Spend 5 minutes writing an interface contract, Agent A develops the API, Agent B develops the frontend with mock data, then integrate
3. **Three-way parallel**: Split a Feature into 3 parts (data model + API / UI components / tests), record management overhead

### Anti-patterns: Common Pitfalls

| Pitfall | Fix |
|---------|-----|
| Opening 5+ Agents at once and losing control | Start with 2, scale up to 3 once stable |
| Parallelizing modules with dependencies | Draw a dependency graph first, only parallelize independent tasks |
| Each Agent defines its own interface format | Unify interface contracts before parallelizing |
| Waiting for all Agents to finish before merging | Merge each one as it completes, catch conflicts early |
| Forcing parallel on simple tasks | If a task takes < 30 minutes, use a single Agent — parallelism has management overhead |

---

## 6. Level 7: Workflow Orchestration

### Why: From "Manually Managing Agents" to "Dev-Time Automated Orchestration"

At Level 6, you're a project manager — manually assigning, monitoring, and integrating.
At Level 7, you're a system architect — designing workflows that AI executes automatically **during development**.

> **Key distinction between Level 7 and Level 8**: Level 7 automation happens **while you're present** (during development) — you trigger commands, AI follows the workflow, you review results. Level 8 automation happens **while you're away** (CI/CD event-triggered, AI running autonomously).

**The three pillars of orchestration**:
1. **CLAUDE.md** (advanced version) — Project-level AI operating manual
2. **Custom Slash Commands** — Standardized task templates
3. **Hooks** — Automated quality checkpoints

Repetitive processes should be automated. The daily cycle of "create component → write types → write tests → lint check" should become a single command.

### How: Step-by-Step Execution

#### Step 1: Advanced CLAUDE.md — Workflow Rules (Weeks 1-2)

Add workflow rules on top of the basic CLAUDE.md:

```markdown
# CLAUDE.md (append to existing content)

## Workflow Rules

### File Creation Rules
- New components must always include: component file + types.ts + xxx.test.tsx
- API routes must include: handler + zod validation schema + error handling
- Database changes must include: migration + seed data

### Git Conventions
- Branch naming: feat/xxx, fix/xxx, refactor/xxx
- Commit format: conventional commits (feat:, fix:, refactor:)
- Each commit does only one thing

### Testing Rules
- All new features must have tests
- Bug fixes must have a failing test written first, then the fix

### Security Baseline
- No use of dangerouslySetInnerHTML
- API routes must verify user permissions
- No hardcoded sensitive information
```

#### Step 2: Custom Slash Commands (Weeks 3-4)

Create a `.claude/commands/` directory in the project root — each `.md` file becomes a reusable command:

```bash
mkdir -p .claude/commands
```

**Command 1: `.claude/commands/new-feature.md`**

```markdown
Implement a new feature based on the following requirements: $ARGUMENTS

Steps:
1. Analyze the requirements, list files to create/modify, wait for my confirmation
2. Implement according to the confirmed plan, following all conventions in CLAUDE.md
3. Write tests for all new code
4. Self-check when done: no TypeScript errors, tests pass, code follows conventions
```

**Command 2: `.claude/commands/fix-bug.md`**

```markdown
Fix the following bug: $ARGUMENTS

Steps:
1. Locate the root cause of the bug, explain why it occurs
2. Write a failing test that reproduces the bug
3. Fix the bug, confirm the test passes
4. Check if similar bugs exist elsewhere
```

**Command 3: `.claude/commands/review.md`**

```markdown
Review the current code changes from the following perspectives:

1. Correctness: Is the logic correct? Are edge cases handled?
2. Security: XSS, injection, authorization, and other security issues
3. Performance: Unnecessary renders, memory leaks, N+1 queries
4. Maintainability: Are names clear? Is the structure sound?

Output format:
- CRITICAL: Must fix
- WARNING: Should fix
- NIT: Optional improvement

Review scope: $ARGUMENTS
```

**Command 4: `.claude/commands/add-test.md`**

```markdown
Add tests for the following code: $ARGUMENTS

Requirements:
- Cover the happy path and at least 3 edge cases
- Use Vitest + Testing Library
- Mock external dependencies (API calls, database)
- Place test files in the same directory, named xxx.test.tsx
```

**Command 5: `.claude/commands/refactor.md`**

```markdown
Refactor the following code: $ARGUMENTS

Constraints:
- Do not change any external interfaces or behavior
- Ensure all existing tests continue to pass
- Each refactoring step should be independently committable
- Explain the reasoning behind each refactoring decision
```

Usage:

```
/new-feature "User search feature: support search by name and email, dataset < 200 items"
/fix-bug "Pagination component throws error when clicking previous on the first page"
/review "All changes in this PR"
```

#### Step 3: Hooks for Automated Quality Checks (Weeks 5-6)

Configure Hooks in the project's `.claude/settings.json` to have Claude Code automatically run checks after specific operations:

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

**Practical Hook scenarios**:
- After writing `.ts/.tsx` files → Automatically run TypeScript type checking
- After writing test files → Automatically run the test
- On task completion → Send a desktop notification (useful for tracking progress when managing multiple parallel Agents)

#### Step 4: Combining into a Complete Workflow (Weeks 7-8)

```
Standard Feature Development Workflow:

1. /new-feature "requirement description"
   ↓ Claude analyzes requirements, proposes a plan, waits for confirmation

2. You review the plan → Confirm/Adjust
   ↓ Claude starts implementation

3. Hooks run automated checks:
   ├── After each file write → TypeScript compilation check
   └── After test file write → Automatically run tests

4. Once implementation is complete:
   /review
   ↓ Claude self-reviews the code

5. Passes review → Commit
```

### Done When: Acceptance Criteria

- [ ] Have 5+ Custom Commands covering daily development scenarios
- [ ] Hooks configured for automatic type checking after file writes
- [ ] CLAUDE.md includes complete workflow rules
- [ ] 80% of development tasks have a corresponding Command available
- [ ] A newcomer (or new Claude instance) can complete a small Feature within 2 hours using only CLAUDE.md + Commands

**Graduation test**: Have a brand new Claude Code instance (no conversation history), relying solely on the project's CLAUDE.md + Custom Commands, complete a CRUD page. Code quality meets project standards with no major modifications needed.

### Practice: Exercises

1. **Command library setup**: Create the 5 Commands listed above, iterate and improve each after using for 1 week
2. **Hook practice**: Configure the TypeScript checking Hook, record how many errors it catches over 1 week
3. **End-to-end test**: Complete a Feature using the full orchestration workflow (Command → Hooks → Review), record the number of manual interventions

### Anti-patterns: Common Pitfalls

| Pitfall | Fix |
|---------|-----|
| Adding a Hook for every operation, repeatedly interrupting AI | Only add Hooks at critical checkpoints |
| Writing Commands too rigidly, turning them into inflexible scripts | Define process frameworks, let AI adapt on the details |
| CLAUDE.md ballooning to 500 lines | Keep it under 200 lines, put details in Commands |
| Only using it yourself, not sharing with the team | Commit Commands and CLAUDE.md to the repository |
| Writing a Command and never updating it | Review after two weeks — delete unused ones, optimize frequently used ones |

---

## 7. Level 8: Automated Orchestration System

### Why: From "Dev-Time Orchestration" to "Unattended Orchestration"

Level 7 automation requires your presence — you type `/new-feature`, AI follows the workflow.
Level 8 automation is **event-driven and unattended** — the system responds to events automatically, AI running autonomously 24/7:

- PR submitted → AI auto Code Review
- CI fails → AI automatically attempts to fix
- Issue created → AI auto-classifies + generates initial proposal

Your AI capability transforms from a personal skill into **team infrastructure**.

**Important reminder**: Not everyone needs Level 8. If your team/project doesn't require this level of automation, stopping at Level 7 is perfectly fine. Over-automation is itself an anti-pattern.

### How: Step-by-Step Execution

#### Step 1: Headless Mode Basics (Weeks 1-2)

Claude Code's Headless mode (`-p` flag) allows non-interactive invocation, suitable for scripts and CI/CD integration:

```bash
# Basic usage
claude -p "Analyze this code for performance issues" < code.ts

# JSON output (easy for script parsing)
claude -p "List all exported functions in this file" --output-format json

# Specify allowed tools
claude -p "Fix this TypeScript error: $(cat error.log)" \
  --allowedTools "Read,Write,Edit,Bash"
```

**Practical Headless script example (Shell)**:

```bash
#!/bin/bash
# scripts/ai-gen-tests.sh
# Automatically generate tests for all components without tests

find components/features -name "*.tsx" | while read component; do
  test_file="${component%.tsx}.test.tsx"
  if [ ! -f "$test_file" ]; then
    echo "Generating test for: $component"
    claude -p "Generate Vitest + Testing Library tests for this component.
    Component path: $component
    Test file path: $test_file
    Cover the happy path and 3 edge cases." \
      --allowedTools "Read,Write" \
      --output-format json
  fi
done
```

#### Step 2: CI/CD Integration — Automated PR Review (Weeks 3-4)

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

#### Step 3: Automated CI Failure Fixes (Weeks 5-6)

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
            --allowedTools "Read,Write,Edit"
          # ⚠️ Security note: Do not grant AI Bash access in CI to avoid arbitrary command execution

      - name: Verify fix
        run: npm test

      - name: Create fix PR
        if: success()
        run: |
          BRANCH="fix/auto-ci-$(date +%s)"
          git checkout -b "$BRANCH"
          # ⚠️ Security note: Only add specific file types to avoid committing unexpected files (e.g., .env, secrets)
          git add '*.ts' '*.tsx' '*.js' '*.jsx' '*.json' '*.css'
          git diff --cached --quiet && echo "No changes to commit" && exit 0
          git commit -m "fix: auto-fix CI failure"
          git push origin "$BRANCH"
          gh pr create \
            --title "fix: Auto-fix CI failure" \
            --body "Automatically generated by AI to fix CI failure. **Requires human review.**" \
            --label "auto-fix,needs-review"
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

#### Step 4: Automated Issue Triage (Weeks 7-8)

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
            const fs = require('fs');
            // ⚠️ Security note: AI output may not be valid JSON — always add error handling
            let result = {};
            try {
              const raw = fs.readFileSync('./triage.json', 'utf8');
              const triage = JSON.parse(raw);
              result = JSON.parse(triage.result || '{}');
            } catch (e) {
              console.log('Failed to parse AI triage output:', e.message);
              return; // Exit gracefully on parse failure — don't block the Issue workflow
            }
            const labels = [result.type, result.size ? `size-${result.size}` : null].filter(Boolean);
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

#### Step 5: Cost Control and Monitoring (Ongoing)

```bash
#!/bin/bash
# scripts/ai-metrics.sh — Run weekly

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

### Done When: Acceptance Criteria

- [ ] Automated PR Review has been live and running for 2+ weeks
- [ ] Automated CI failure fix is configured (fix success rate > 30%)
- [ ] Automated Issue triage is configured
- [ ] Cost monitoring mechanism is in place (API key spending is trackable)
- [ ] Auto-fix PRs must go through human review (safety guardrails in place)

**Graduation test**: All three automation workflows have been running for 2 weeks. PR Review coverage is 100%, auto-fix success rate > 30%, and team feedback is positive.

### Practice: Exercises

1. **Headless script**: Write a script using `claude -p` to batch-generate test files for components without tests
2. **PR Review bot**: Deploy the AI Review GitHub Action, evaluate Review quality after 1 week
3. **Self-healing Pipeline**: Configure CI auto-fix, record fix attempts and success rate over 2 weeks

### Anti-patterns: Common Pitfalls

| Pitfall | Fix |
|---------|-----|
| Wanting to automate everything | Only automate tasks that are repetitive, time-consuming, and follow a pattern |
| AI auto-commits with no human review | Auto-fixes must go through PR + human review |
| API costs spiral out of control | Set spending alerts, limit calls per hour |
| API keys hardcoded | Use GitHub Secrets, follow least privilege principle |
| AI Review generates too much noise | Adjust prompts to only report CRITICAL and WARNING issues |
| Setting up automation but never checking results | Review metrics weekly — at minimum track success rate and costs |

---

## 8. Appendix: Templates & Quick Reference

### A. Complete CLAUDE.md Template

```markdown
# CLAUDE.md

## Project Overview
[One-sentence description]

## Tech Stack
- Next.js 14 (App Router), TypeScript (strict)
- Tailwind CSS + shadcn/ui
- Prisma + PostgreSQL
- TanStack Query v5, Zustand
- Vitest + Testing Library + Playwright

## Directory Structure
app/                 → Next.js App Router routes
  (auth)/            → Pages requiring authentication
  api/               → API routes
components/
  ui/                → shadcn/ui (do not modify manually)
  features/          → Business components
  layout/            → Layout components
lib/                 → Utility functions (db.ts, auth.ts, utils.ts)
hooks/               → Custom Hooks
types/               → Global types
prisma/
  schema.prisma      → Database Schema
  migrations/        → Migration files

## Coding Conventions
- File names: kebab-case (user-profile.tsx)
- Components: PascalCase named exports (export function UserProfile)
- Functions/variables: camelCase
- Client components use 'use client'; server components do not
- Data fetching: server-side uses direct Prisma queries, client-side uses React Query
- Form validation uses zod
- Styling uses cn() to merge Tailwind class names

## Workflow Rules
- New components must have a test file created alongside
- API routes must have zod input validation
- Bug fixes require a failing test first, then the fix
- Git commits follow conventional commits

## Common Commands
npm run dev          → Development server (localhost:3000)
npm test             → Vitest
npm run lint         → ESLint
npx prisma studio    → Database GUI
npx prisma migrate dev → Run migrations
```

### B. Custom Commands Quick Reference

| Command | Purpose | File Path |
|---------|---------|-----------|
| `/new-feature` | New feature development | `.claude/commands/new-feature.md` |
| `/fix-bug` | Bug fix (with TDD) | `.claude/commands/fix-bug.md` |
| `/review` | Code review | `.claude/commands/review.md` |
| `/add-test` | Add tests | `.claude/commands/add-test.md` |
| `/refactor` | Safe refactoring | `.claude/commands/refactor.md` |

### C. Claude Code CLI Quick Reference

```bash
# Launch & basic operations
claude                     # Start interactive session
claude -p "prompt"         # Headless mode (non-interactive)
claude -p "..." --output-format json  # JSON output

# In-session commands
/init                      # Initialize CLAUDE.md
/plan                      # Enter Plan Mode
/compact                   # Compress conversation context
/cost                      # View Token usage
/clear                     # Clear conversation history
/new-feature "description" # Execute Custom Command

# Git Worktree (parallel development)
git worktree add ../proj-feat feature/xxx
git worktree list
git worktree remove ../proj-feat

# Recommended Shell aliases
alias cc='claude'
alias ccp='claude -p'
```

### D. Reference Pace

The following is a reference pace — **actual progress varies by person, project, and usage frequency**. Some people may reach Level 5 in 3 months, while others may take 6 months to reach Level 4 — both are perfectly normal.

```
Level 1-2  ← Build AI usage habits (typically 2-4 weeks)
Level 3-4  ← Prompt engineering + CLAUDE.md (typically 3-6 weeks)
Level 5    ← Intent-driven development (typically 4-8 weeks)
Level 6    ← Multi-Agent parallelism (typically 4-8 weeks)
Level 7    ← Workflow orchestration (typically 4-8 weeks)
Level 8    ← Automated systems (as needed — not everyone needs this)
```

**Key principle**: Solid foundations matter more than speed. Pass each Level's graduation test before moving on. Gaps from skipping levels will surface in later Levels.

### E. When to Downshift

A higher Level isn't the goal — higher efficiency is. Downshift in these scenarios:

| Scenario | Downshift to | Reason |
|----------|-------------|--------|
| Simple bug fix (< 10 minutes) | Level 4 | Single Agent is sufficient; parallelism has management overhead |
| Exploratory prototype | Level 3 | When direction is uncertain, iterative conversation is more efficient |
| Security-sensitive code (payments, auth) | Level 4 | Requires line-by-line human review |
| AI proposals are repeatedly wrong | Level 4 | Fall back to How descriptions, give more specific instructions |
| Auto-fixes failing repeatedly | Level 7 | Disable automation, debug manually |

---

> This guide is a framework, not a doctrine. Adjust the pace to fit your project and team. Use AI a little more each day than yesterday, automate one more process each week than last week, and keep iterating — that's all it takes.
