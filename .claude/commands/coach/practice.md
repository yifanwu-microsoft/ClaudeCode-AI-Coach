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

### Step 3: Generate Practice Tasks

Generate 1-3 tasks based on the user's current Level and focused sub-skill. Reference `ai-engineering-leveling-guide.md` for sub-skill definitions and acceptance criteria.

**Selection criteria:**
- Sub-skill status "not started" → Beginner tasks; "in progress" → Intermediate/Advanced tasks
- **Priority**: Project-specific tasks that deliver real value (e.g., adding tests, improving CLAUDE.md) > generic exercises
- Each task should have 3 difficulty tiers (Beginner / Intermediate / Advanced) aligned with the sub-skill's acceptance criteria

**Task generation example** (for Level 5, Sub-skill "Intent Description"):
- Beginner: Find 5 recent prompts in your history, rewrite them as intent-driven (What/Why, no How), compare AI output quality
- Intermediate: Implement an entire feature using only business-intent descriptions — let AI choose the technical approach
- Advanced: Maintain intent-driven prompting for a full workday, tracking What/Why ratio > 70%

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
