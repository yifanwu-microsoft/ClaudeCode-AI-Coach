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

> **Reference**: For Level definitions and scoring ranges, see **CLAUDE.md** — Level Detection Rules + Scoring Reference.

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

**Scoring ranges** → see `CLAUDE.md` Scoring Reference

---

## 2. Level 1-2: Getting Started with AI-Assisted Programming

### Why: Why Start Here

The goal at this stage isn't to get AI to write perfect code — it's to **build muscle memory for using AI**.

Skipping this stage and jumping straight to advanced techniques leads to:
- Not trusting AI output → Spending more time reviewing → Feeling AI is useless → Giving up
- Lacking intuition about AI output quality → Every subsequent decision is slower

Core mindset: **Let AI help you write code that you know how to write but don't feel like writing** (boilerplate, type definitions, test scaffolding).

### Mindset: From Skeptic to Experimenter

The biggest barrier at this stage isn't technical — it's **trust**.

Common internal resistance:
- "AI code is unreliable, I'd rather write it myself"
- "Reading AI output takes longer than writing it"
- "What if AI introduces bugs I don't catch?"

The shift you need to make:

> **Old mindset**: "I'll use AI when I'm sure it can do it right"
> **New mindset**: "I'll let AI try, then I'll judge"

You're not handing over control — you're adding a fast, imperfect first-draft generator to your workflow. Think of it like having a junior developer who types infinitely fast but needs code review. You wouldn't refuse to work with them; you'd review their output and give feedback.

**Litmus test**: When you catch yourself thinking "I should just write this myself" — pause, let AI try first, then compare. Do this 5 times. If AI was usable in 3+ of them, your instinct was wrong.

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

> **🎯 Behavioral signals you've graduated**: (1) When you start typing a function signature, you instinctively pause to see if AI will complete it. (2) When AI generates code, you have an immediate gut reaction — "looks right" or "that's off" — before reading every line. (3) You no longer feel anxious about AI-generated code being in your codebase.

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
| Blindly accepting AI code with hardcoded secrets or credentials | Always scan AI output for strings like API keys, passwords, connection strings — AI sometimes generates placeholder credentials that look real |

### Stuck? Diagnosis Checklist

**Symptom: "I keep going back to writing everything myself"**
- Root cause: The feedback loop isn't rewarding yet
- Fix: Force yourself to use AI for only one category — pick the one with highest accept rate (usually type definitions or boilerplate). Build confidence on the easiest wins first.

**Symptom: "AI output is always wrong / low quality"**
- Root cause: Your questions may be too vague, or you're asking AI to do things outside its strength zone
- Fix: Try the "explain this code" exercise — it has a near-100% success rate and builds trust. Then gradually move to code generation.

**Symptom: "I accept everything without thinking"**
- Root cause: Over-swinging from skepticism to blind trust
- Fix: After each AI generation, change one thing (anything — a variable name, an edge case). This forces you to read the code and builds the review habit.

---

## 3. Level 3-4: Prompt Engineering + Project Context Management

### Why: Why Prompt Quality Is the Efficiency Inflection Point

At Level 2, your conversations with AI might take 5-10 round trips to get satisfactory results.
By the time you graduate Level 4, this should drop to **1-3 round trips**.

What's the difference? It's not that AI got smarter — you learned to **provide all the information at once**.

This stage builds two core capabilities:
1. **Structured prompts** — Getting high-quality output from AI in one shot
2. **CLAUDE.md project context** — Having AI automatically inherit project conventions without repeating yourself every time

### Mindset: From Conversationalist to Commander

At Level 2, you're having a back-and-forth chat with AI. At Level 4, you're giving **orders with full context**.

The shift:

> **Old mindset**: "Let me ask AI and see what it says, then adjust"
> **New mindset**: "Let me give AI everything it needs to get it right the first time"

This feels counterintuitive — spending 2 minutes writing a structured prompt seems slower than just asking. But the math works: 2 minutes upfront saves 4 rounds of back-and-forth (8-10 minutes).

The hardest part is **investing time upfront**. Your brain prefers the illusion of speed ("I'll just ask quickly"). Resist this. The structured prompt isn't overhead — it's the actual work of thinking clearly about what you want.

**Litmus test**: Before sending a prompt, ask yourself: "If a competent developer read only my prompt (no access to my brain), could they deliver what I want?" If the answer is no, you're missing context.

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

> **🎯 Behavioral signals you've graduated**: (1) Before asking AI anything, you automatically think about what context it needs. (2) You feel uncomfortable starting a complex task without Plan Mode. (3) When a new team member asks "how do we use AI on this project?", you point them to CLAUDE.md.

### Practice: Exercises

1. **CLAUDE.md validation**: After writing CLAUDE.md, have Claude create a new component and check whether it follows your naming conventions, export style, and file location
2. **CRATE comparison**: Use both a "one-liner prompt" and a CRATE-formatted prompt for the same task, compare output quality and number of round trips
3. **Deep Plan Mode usage**: Pick a Feature spanning 3+ files, use Plan Mode throughout. Record deviations between plan and actual execution
4. **Bridge to Level 5 — Gradual intent shift**: Take a task you'd normally write a CRATE prompt for. Write it as usual, then do these 3 rewrites:
   - **Rewrite 1**: Remove all technology mentions (no framework/library names). Replace with requirements.
   - **Rewrite 2**: Remove all file/function names. Replace with Feature-level descriptions.
   - **Rewrite 3**: Remove all implementation steps. Keep only: user problem, constraints, acceptance criteria.
   Compare AI output quality across all 4 versions. You'll often find version 3 or 4 produces the most creative and comprehensive solution.

### Anti-patterns: Common Pitfalls

| Pitfall | Fix |
|---------|-----|
| Dumping the entire codebase on AI for help | Only provide necessary files and context |
| CLAUDE.md is 500 lines long | Keep it under 200 lines, prioritize core rules |
| Letting AI modify code without Plan Mode | Cross-file tasks must start with Plan Mode |
| Writing a 200-line prompt specifying every detail | Provide a framework, let AI propose solutions, you make choices |
| Writing CLAUDE.md once and never updating it | Update whenever tech stack or conventions change |
| Not including security constraints in prompts | Add a "Security" section to your CRATE prompts for auth-related, data-handling, or user-input code |

### Stuck? Diagnosis Checklist

**Symptom: "Still taking 5+ rounds to get good output"**
- Diagnosis: Review your last 3 prompts — which CRATE element is missing?
  - Missing **Context**? → AI doesn't know your tech stack / project state
  - Missing **Target**? → AI doesn't know what "done" looks like
  - Missing **Expectation**? → AI can't judge quality
- Fix: Before your next prompt, explicitly check: "Did I provide C, A, T, and E?"

**Symptom: "CLAUDE.md doesn't seem to help"**
- Diagnosis: Have Claude generate something, then check: did it follow your conventions?
  - If no → CLAUDE.md may be too long (AI ignores it) or too vague (AI can't follow it)
  - If yes but quality is still low → The problem is your per-task prompts, not CLAUDE.md
- Fix: Run `/coach:practice` exercise 1 (CLAUDE.md validation)

**Symptom: "I use Plan Mode but plans are always wrong"**
- Diagnosis: You may be accepting plans too quickly, or not providing enough constraints upfront
- Fix: Before confirming a plan, ask yourself: "What would I do differently?" Tell AI those specific disagreements. A plan should reflect your thinking, not just AI's.

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

### Mindset: From Commander to Product Owner

This is the hardest mindset shift in the entire progression.

At Level 4, you tell AI **how** to build. At Level 5, you tell AI **what** to build and **why** — and trust it to pick the how.

The shift:

> **Old mindset**: "I know the best way to implement this, so I'll tell AI exactly how"
> **New mindset**: "I know what the user needs — let AI propose the architecture, I'll judge if it's good"

Why this is hard:
- You've spent years building implementation expertise — letting go feels like wasting your skills
- It's scary when AI picks an approach you wouldn't have chosen
- "What if AI's approach has a flaw I don't catch?"

The reframe: **Your implementation expertise doesn't disappear — it becomes your review lens.** You're not less valuable; you're more valuable, because you can evaluate proposals faster than you can write code.

**Litmus test**: When AI proposes a solution you wouldn't have picked — instead of immediately saying "no, do it my way", spend 2 minutes asking: "Why this approach? What are the trade-offs?" If AI has a good reason, let it proceed. Track how often the "not my way" approach turns out fine. (Spoiler: it usually does.)

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

> **Bridge to Level 6**: Once you're comfortable decomposing tasks, try this: pick your next decomposed Feature and instead of executing subtasks 2 & 3 serially, open a second terminal, launch another Claude instance, and give it subtask 3 while the first instance works on subtask 2. Even this simple 2-agent parallelism will teach you the fundamentals of coordination and reveal your project's hidden dependencies.

### Done When: Acceptance Criteria

- [ ] What/Why makes up > 70% of prompts (review your last 10 prompts)
- [ ] Completed 3+ Feature-level delegations (frontend + API + tests)
- [ ] AI proposals pass architecture review on first attempt > 80% of the time
- [ ] Can decompose complex Features into 3+ subtasks and map out their dependencies
- [ ] Feature completion speed is 2x+ faster compared to writing entirely by hand (track 3 Features for comparison)
- [ ] AI code contribution 60-75%

> **💡 Self-test method**: Look through your last 10 prompts — count how many describe "what/why" rather than "how to do it". ≥7 out of 10 means 70%. For "passes architecture review on first attempt": out of the last 5 times you had AI propose a solution, how many times did you think "I can use this directly" rather than "this needs major changes"? ≥4 times means 80%.

**Graduation test**: Complete a full Feature (frontend + API + database) using intent descriptions throughout — never specifying implementation approach. AI proposal passes architecture review on first attempt, total time is 2x+ faster than writing by hand.

> **🎯 Behavioral signals you've graduated**: (1) You describe features in user/business terms first, tech terms second — not just to AI, but in PRs and team discussions. (2) When AI proposes an approach you didn't expect, your first reaction is curiosity ("interesting, why?") rather than rejection ("no, do it my way"). (3) You spend more time reviewing proposals than writing prompts.

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
| Delegating security-sensitive features (auth, payments, permissions) at full intent-level | Downshift to Level 4 for security-critical code — specify explicit security requirements, don't let AI guess |

### Stuck? Diagnosis Checklist

**Symptom: "I keep falling back to telling AI exactly how to implement"**
- Diagnosis: This is the #1 barrier at Level 5. Check which type of How you're specifying:
  - Specifying technologies ("use useState") → Try: describe the UX requirement instead
  - Specifying architecture ("create 3 files") → Try: describe the Feature boundary and constraints
  - Specifying algorithms ("sort with quicksort") → Try: describe the performance requirement
- Fix: Write your prompt as usual, then do a "How sweep" — delete every sentence that specifies an implementation approach. Replace with the business reason.

**Symptom: "AI's proposals always need major rework"**
- Diagnosis: Either your constraints are insufficient, or your CLAUDE.md is incomplete
  - Check: Does AI know your project's architecture patterns? (If not → update CLAUDE.md)
  - Check: Did you provide data scale, performance, and edge case requirements? (If not → your prompt lacks constraints)
- Fix: After AI proposes, don't rewrite — instead, explain what's wrong and ask AI to revise. This trains you to describe problems at the What level.

**Symptom: "I can describe intent for simple tasks but not complex ones"**
- Diagnosis: Complex Features need intent + constraints + acceptance criteria — intent alone isn't enough
- Fix: Use the template in Step 2 (Feature-Level Delegation). The structure forces completeness.

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

### Mindset: From Product Owner to Project Manager

At Level 5, you're managing one talented AI. At Level 6, you're managing **a team of AIs working simultaneously**.

The shift:

> **Old mindset**: "I focus on one task until it's done, then move to the next"
> **New mindset**: "I plan the work breakdown, distribute tasks, and context-switch between progress reviews"

This is genuinely a different skill. Many developers are great at deep focus but uncomfortable with the interruption-driven nature of parallel management. You need to:
- Accept that your role is now **coordination**, not execution
- Get comfortable with incomplete states — Agent A is 80% done while Agent B just started
- Resist the urge to jump in and "fix" an Agent's code — redirect it with better instructions instead

**Litmus test**: If you find yourself doing the work instead of directing Agents, you've fallen back to Level 5. The moment you're writing code while Agents are idle, something is off.

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

> **🎯 Behavioral signals you've graduated**: (1) When you see a task list, your brain automatically sorts them into "parallel" and "serial". (2) You feel unproductive when only one Agent is running. (3) You've developed a rhythm — distribute tasks, do your own work, check progress, review — that feels natural, not stressful.

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
| Parallel agents applying inconsistent security patterns | Include security rules in CLAUDE.md so all agents inherit the same baseline — add auth checks, input validation rules, etc. |

### Stuck? Diagnosis Checklist

**Symptom: "Parallel agents keep producing conflicting code"**
- Diagnosis: Your task decomposition has hidden dependencies
  - Check: Are agents modifying the same file? → Not truly independent
  - Check: Do agents share state/types that might change? → Need interface-first
- Fix: Before parallelizing, list every shared file/type. If more than 2, you're not independent enough. Split differently.

**Symptom: "Management overhead eats the time savings"**
- Diagnosis: You may be running too many agents, or checking too frequently
- Fix: Drop back to 2 agents. Check progress every 10 minutes, not every 2 minutes. The goal is to do your own work while agents run, not to watch them.

**Symptom: "I don't know what to work on while agents are running"**
- Diagnosis: You haven't decomposed enough work for yourself
- Fix: Your parallel plan should have N+1 tasks: N for agents, 1 for you (review, planning, documentation, other work). Never be idle while agents work.

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

### Mindset: From Project Manager to Systems Architect

At Level 6, you manually orchestrate each session. At Level 7, you're designing **reusable systems** so orchestration happens automatically.

The shift:

> **Old mindset**: "I manage each AI task as it comes up"
> **New mindset**: "I design workflows that handle common tasks without my involvement"

The hard part: you need to think in **patterns**, not instances. Instead of "I'll tell AI to add tests for this component", you think "What's my standard process when any component needs tests?" Then you encode that process as a Command.

This requires stepping back from daily work to invest in infrastructure — which always feels less urgent than shipping features. But the compound returns are significant.

**Litmus test**: Count how many times this week you gave AI the same type of instruction. If any instruction category appears 3+ times, it should be a Command.

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

> **🎯 Behavioral signals you've graduated**: (1) When you do the same thing for the third time, you reflexively think "this should be a Command." (2) You can describe your development workflow as a named sequence of steps, not just "I code until it works." (3) A new Claude instance with your project config produces code that looks like yours.

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

### Stuck? Diagnosis Checklist

**Symptom: "I wrote Commands but never use them"**
- Diagnosis: Commands may be too rigid, too narrow, or solving the wrong problems
  - Check: Did you build Commands for your actual top 5 repeated tasks? Or for tasks you thought you should automate?
  - Check: Does using the Command feel faster than typing a fresh prompt?
- Fix: Track your actual prompts for 3 days. Find the top 3 patterns. Build Commands for those.

**Symptom: "Hooks keep breaking my flow"**
- Diagnosis: Too many Hooks, or Hooks on non-critical operations
- Fix: Keep only 2 Hooks to start: type check on file write + notification on completion. Add more only when you feel a specific pain point.

**Symptom: "New team members / fresh Claude instances still can't follow the workflow"**
- Diagnosis: Your CLAUDE.md + Commands encode tacit knowledge you haven't written down
- Fix: The graduation test IS the diagnostic — have someone unfamiliar try. Every place they get stuck reveals a gap.

### Team: Scaling Workflows to Your Team

Your Commands and CLAUDE.md aren't just personal tools — they're **team infrastructure**.

**Sharing**:
- Commit `.claude/commands/` and `CLAUDE.md` to the repository — every team member benefits immediately
- Create a `/onboard` command that walks new developers through the project setup
- Review CLAUDE.md changes in PRs, just like you review code changes

**Team adoption pattern**:
1. Start solo — iterate on Commands until they work reliably for you
2. Demo to 1-2 teammates — show them using a Command end-to-end
3. Get feedback — which Commands do they actually use? Which feel unnatural?
4. Iterate — the Commands that survive team adoption are your real workflow

**Pitfall**: Don't enforce Commands before they're proven. "Everyone must use /new-feature" creates resistance. Instead, make the Commands so good that people choose them voluntarily.

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

### Mindset: From Systems Architect to Platform Operator

At Level 7, your automation runs when you're present. At Level 8, it runs **when you're not there**.

The shift:

> **Old mindset**: "I trigger workflows; AI follows my playbook"
> **New mindset**: "Events trigger workflows; I monitor outcomes and tune the system"

This isn't just a technical change — it's a **trust and control** change. You're trusting automated systems to make decisions (or at least take first-pass actions) without you watching. This requires:
- Accepting that some auto-fixes will fail (that's what the PR review is for)
- Resisting the urge to watch every run (check daily dashboards instead)
- Understanding that your job is now setting guardrails and tuning parameters, not doing work

**Litmus test**: Check your reflex when CI fails. If your first instinct is "let me go fix it", Level 8 isn't working for you yet. It should be "let me check if the auto-fix handled it."

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

> **🎯 Behavioral signals you've graduated**: (1) CI fails and your first thought is "let me check if the auto-fix handled it" — not "let me go fix it." (2) You check automation dashboards weekly, not daily. (3) Team members you've never spoken to benefit from your AI automation without knowing you built it.

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

### Stuck? Diagnosis Checklist

**Symptom: "Auto-fix PRs keep failing / getting rejected"**
- Diagnosis: Check the failure mode:
  - Fix attempts compile errors? → AI may lack project context (update CLAUDE.md in CI)
  - Fix attempts wrong approach? → Constrain AI's allowed tools more tightly
  - Reviewers reject valid fixes? → Team doesn't trust the system yet — need trust-building
- Fix: Start with only the simplest auto-fix class (e.g., lint errors only). Expand scope after success rate > 50%.

**Symptom: "AI Review comments are too noisy / all false positives"**
- Diagnosis: Review prompt is too broad
- Fix: Narrow to CRITICAL only for 2 weeks. Gradually add WARNING back once CRITICAL accuracy is high.

**Symptom: "Costs are climbing but value isn't clear"**
- Diagnosis: You're automating everything instead of the highest-ROI tasks
- Fix: Run the metrics script weekly. Calculate cost-per-auto-fix-PR. If > cost of manual fix, that class of automation isn't worth it yet.

### Team: AI Automation as Team Infrastructure

At Level 8, your automation serves the entire team, not just you. This changes the decision-making:

**Governance**:
- Auto-fix PRs need team buy-in — not everyone is comfortable with AI committing code
- Start with read-only automation (AI Review, Issue triage) before write automation (auto-fix)
- Create an `#ai-automation` channel — log all automation actions for transparency

**Rollout strategy**:
1. **Week 1-2**: AI PR Review only (read-only, low risk, high visibility)
2. **Week 3-4**: Issue triage (also read-only, shows classification accuracy)
3. **Week 5+**: CI auto-fix (write, higher risk — start with lint-only fixes)
4. **Ongoing**: Share weekly metrics — the team should know success rates and costs

**Trust-building**: The single most important metric is **false positive rate**. If AI Review flags 10 things and 8 are wrong, the team will ignore it forever. Better to flag 2 things that are both real issues.

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
