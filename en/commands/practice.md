Generate specific, actionable practice tasks that can be executed in the current project, based on the user's current progress.

## Generation Process

### Step 1: Read Current State
Read `PROGRESS.md` to confirm:
- What is the current Level
- What is the current focused sub-skill
- What is the sub-skill's current status (not started / in progress / validated)

### Step 2: Scan Current Project Context (automated)

**If the user doesn't have a project yet (e.g., just starting out), provide the following guided exercises:**
- **Level 1-2**: Suggest creating a simple practice project (e.g., a to-do app, calculator, or CLI tool) to practice basic conversations. Any familiar language works: Python, JavaScript, Go, Java, etc.
- **Level 3-4**: Suggest creating a CLAUDE.md in an existing project, or using a small project to practice Plan Mode. The project doesn't need to be complex — a small project with a few modules is enough to start practicing structured prompts and context management.

Before generating practice tasks, analyze the current project's actual state to produce **targeted, project-relevant exercises**:

**Scan Items:**
1. **Project Tech Stack**: Check package.json, requirements.txt, go.mod, pom.xml, Cargo.toml, build.gradle, etc. to identify languages and frameworks
2. **CLAUDE.md Status**: Does it exist? Is it comprehensive? Does it need updating?
3. **Test Status**: Which source files have corresponding tests? Which don't? What test framework is used?
4. **Commands Status**: How many commands are in `.claude/commands/`? What scenarios do they cover?
5. **Hooks Status**: Are Hooks configured? Which ones?
6. **Project Structure**: Main directories and file organization
7. **Recent Activity**: Recent git log to understand what the user has been working on

**Generation Strategy:**
- **Prefer project-specific tasks**: e.g., "One of your modules has no tests — use Level 5 techniques to delegate test writing to AI"
- **Fall back to generic tasks**: If the project doesn't offer suitable practice scenarios, use tasks from the generic practice library
- Practice tasks should deliver real value to the project (e.g., adding tests, improving CLAUDE.md), not just be "exercises"
- **Tech stack adaptation**: Adjust specific tools and commands in practice tasks based on the detected tech stack (e.g., pytest for Python projects, go test for Go projects)

### Step 3: Select from Practice Library Based on Current Level

Choose 1-3 appropriate tasks from the practice library for the corresponding Level. Selection criteria:
- If the sub-skill status is "not started," begin with Beginner tasks
- If the sub-skill status is "in progress," choose Intermediate or Advanced tasks
- **Top priority**: Tasks that can be executed directly in the current project AND deliver real value (e.g., adding tests, improving CLAUDE.md)
- **Second priority**: Generic practice tasks that can be executed in the current project
- **Fallback**: Use template tasks from the library below

### Practice Library

---

**Level 1-2: AI-Assisted Programming Basics**

Sub-skill 1: AI Code Completion Habits
- Beginner: Open the project, write a new function, consciously observe AI completion suggestions, and record how many you accept vs. reject
- Intermediate: Complete an entire utility function using only AI completions — accept suggestions with Tab without manually typing the implementation
- Advanced: Maintain AI completion usage for 1 continuous hour of development, tracking your acceptance rate

Sub-skill 2: Basic Claude Code Conversations
- Beginner: Select a piece of unfamiliar code in the project, ask Claude to explain what it does, and verify the explanation's accuracy
- Intermediate: Have Claude generate type definitions / interface declarations for an existing function (e.g., TypeScript types, Python type hints, Go interfaces, Java interfaces) and compare them against a manually written version
- Advanced: Complete a small feature request (e.g., adding a utility function) entirely through conversational collaboration with Claude

Sub-skill 3: AI Code Judgment
- Beginner: Have Claude generate a code snippet, then annotate each line: what can be used as-is, what needs modification, what should be rejected
- Intermediate: Give Claude a piece of buggy code to fix, then evaluate the correctness of its fix
- Advanced: Have Claude generate 2 different implementations for the same requirement, compare their trade-offs, and choose the better approach

---

**Level 3-4: Prompt Engineering + Context Management**

Sub-skill 1: Claude Code Core Features
- Beginner: Use /init in the current project to generate a CLAUDE.md, then review the quality of the generated content
- Intermediate: Use Plan Mode to plan a complex task before executing it, then record deviations between the plan and actual execution
- Advanced: Proactively use /compact during long conversations to compress context, and compare AI response quality before and after compression

Sub-skill 2: Plan Mode Usage
- Beginner: Pick a task that touches 2+ files, enter Plan Mode and have Claude plan the steps
- Intermediate: For a 3+ file feature, use Plan Mode throughout and record deviations between AI's plan vs. actual execution
- Advanced: In Plan Mode, proactively ask Claude to consider edge cases and error handling

Sub-skill 3: Structured Prompts (CRATE)
- Beginner: Run a comparison experiment — same task with a one-line prompt first, then with CRATE format, and compare the results
- Intermediate: Write CRATE-format prompts for 5 common tasks, tracking the number of prompt rounds for each
- Advanced: Achieve an average of 1-3 prompt rounds to get satisfactory results

Sub-skill 4: CLAUDE.md Configuration & Maintenance
- Beginner: Check if the current project has a CLAUDE.md; if not, create one that includes tech stack and conventions
- Intermediate: Have Claude create a new module and verify that it automatically follows the conventions in CLAUDE.md
- Advanced: After using CLAUDE.md for 1 week, review and add new rules for things Claude frequently gets wrong

---

**Level 5: Intent-Driven Development**

Sub-skill 1: Intent Description (Why/What over How)
- Beginner: Find your 5 most recent prompts, rewrite them as intent-driven versions, and compare AI output quality
- Intermediate: Handle an entire new feature using only What/Why descriptions — no specific technologies mentioned — and let AI choose the approach
- Advanced: Maintain intent-driven prompting for a full day of development, tracking whether What/Why statements make up > 70%

Sub-skill 2: Feature-Level Delegation
- Beginner: Fully delegate a 2-4 hour feature to Claude, recording total time spent and number of prompt rounds
- Intermediate: Delegate a feature that includes frontend + API, describing only business requirements without specifying architecture
- Advanced: Delegate a complete feature including frontend + API + tests, with manual modifications < 15%

Sub-skill 3: Architecture Review Capability
- Beginner: Have Claude implement a feature, then review it against an architecture checklist (soundness / edge cases / performance / security)
- Intermediate: Over 3 consecutive feature delegations, track the first-pass architecture review approval rate
- Advanced: Achieve > 80% first-pass architecture review approval rate for AI-generated solutions

Sub-skill 4: Task Decomposition & Dependency Analysis
- Beginner: Pick a pending feature in the current project, list all sub-tasks, and label their dependencies
- Intermediate: Draw a sub-task dependency graph, identify which sub-tasks can run in parallel and which must be sequential
- Advanced: Decompose 3 different features, finding "interface points" (boundaries where you can agree on types/APIs first and then develop independently)

---

**Level 6: Multi-Agent Parallelism**

Sub-skill 1: Parallel Task Identification
- Beginner: List 3-5 pending tasks in the current project and label which can be parallelized vs. which have dependencies requiring sequential execution
- Intermediate: Draw a task dependency graph and identify the optimal parallel execution path
- Advanced: Break down a large feature into 3+ independent parallel units with no dependencies

Sub-skill 2: Git Worktree Isolation
- Beginner: Use `git worktree add` to create a working directory and complete an independent task in it
- Intermediate: Run 2 worktrees simultaneously, complete a task in each, then merge both back to the main branch
- Advanced: 3 worktrees + 3 Claude instances, with merge conflicts < 10%

Sub-skill 3: Interface Contract First
- Beginner: Before starting parallel work, spend 5 minutes writing an interface definition (types / API format), then implement separately
- Intermediate: Parallel frontend + backend — agree on the API contract first, Agent A builds the backend, Agent B builds the frontend with mock data
- Advanced: 3 Agents working in parallel, all interactions through pre-defined interface contracts, zero interface issues at integration

Sub-skill 4: Multi-Agent Management (3+)
- Beginner: Run 2 Claude instances simultaneously on 2 independent bug fixes, comparing time spent vs. sequential execution
- Intermediate: 3 Agents working in parallel on different parts of a feature, with context-switching overhead < 3 minutes
- Advanced: Sustain 3+ Agents in daily parallel work, achieving 2x+ task throughput compared to sequential

---

**Level 7: Workflow Orchestration**

Sub-skill 1: CLAUDE.md Workflow Rules
- Beginner: Add file creation rules to the project's CLAUDE.md (module + type definitions/interfaces + tests must be created together)
- Intermediate: Add Git conventions (branch naming, Conventional Commits) and routing/API rules
- Advanced: Add security rules (no hardcoded secrets, injection protection, etc.) and verify Claude's compliance rate

Sub-skill 2: Custom Slash Commands
- Beginner: Create your first Command (e.g., /new-feature) with a complete workflow
- Intermediate: Create 5 Commands covering common scenarios (new-feature / fix-bug / review / add-test / refactor)
- Advanced: After 1 week of using Commands, iterate and optimize — ensure 80% of dev tasks have an applicable Command

Sub-skill 3: Hooks Automated Quality Checks
- Beginner: Configure a PostToolUse Hook to automatically run type checking or static analysis after saving source files (e.g., tsc, mypy, go vet, javac)
- Intermediate: Add a Hook for auto-running tests, tracking the number of errors caught by Hooks over 1 week
- Advanced: Full Hook pipeline (type checking/static analysis + tests + lint), verified to not slow down development speed

---

**Level 8: Automated Orchestration Systems**

Sub-skill 1: Headless Mode Scripting
- Beginner: Run `claude -p "analyze this code"` to complete a non-interactive invocation
- Intermediate: Write a script to batch-generate test files for modules that lack tests
- Advanced: Use `--output-format json` to parse AI output and perform downstream processing

Sub-skill 2: CI/CD PR Auto-Review
- Beginner: Simulate the PR Review process locally (feed `git diff` output to `claude -p`)
- Intermediate: Write `.github/workflows/ai-review.yml` and deploy it to a test repository
- Advanced: After 1 week of operation, evaluate review quality and tune the prompt to reduce noise

Sub-skill 3: CI Failure Auto-Fix Pipeline
- Beginner: Manual simulation: intentionally fail a test, then use `claude -p` to attempt a fix
- Intermediate: Write `.github/workflows/ai-autofix.yml` with verification steps
- Advanced: Run for 2 weeks, track fix success rate, optimize to > 30%

Sub-skill 4: Issue Auto-Triage System
- Beginner: Manually use `claude -p` to categorize 5 real issues
- Intermediate: Write `.github/workflows/ai-triage.yml`
- Advanced: Run for 2 weeks, measure classification accuracy

Sub-skill 5: Cost Monitoring & Metrics
- Beginner: Use `/cost` in Claude Code to check current session costs
- Intermediate: Write `scripts/ai-metrics.sh` to automatically generate weekly report data
- Advanced: Configure cost alerts and set per-hour invocation limits

### Step 4: Output Format

```
## Practice Tasks (Current Focus: [sub-skill name], Level N)

### 📍 Project Scan Findings
[Briefly list scan findings relevant to the current focused sub-skill, e.g., "Project has 12 modules, 5 of which have no test files"]

### Task 1: [Name] (Project-Specific / Generic Exercise)
- **Difficulty**: Beginner / Intermediate / Advanced
- **Estimated Time**: X minutes/hours
- **Project Value**: [Actual benefit to the project upon completion, e.g., "Add test coverage for 5 modules"]
- **Steps**:
  1. ...
  2. ...
- **Acceptance Criteria**: [What counts as complete]

### Task 2: ...
```

### Step 5: Remind to Update PROGRESS.md

After completing the practice, remind the user to update the sub-skill status in PROGRESS.md.
