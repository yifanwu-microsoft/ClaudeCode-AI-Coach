Generate specific, actionable practice tasks that can be executed in the current project, based on the user's current progress.

## Generation Process

### Step 1: Read Current State
Read `PROGRESS.md` to confirm: current Level, focused sub-skill, and sub-skill status (not started / in progress / validated).

### Step 2: Scan Current Project Context (automated)

**If no project exists**: Suggest creating a simple practice project appropriate to the user's Level (L1-2: to-do app or CLI tool; L3-4: small multi-module project for CLAUDE.md and Plan Mode practice).

**If project exists**: Scan for practice-relevant context:
1. **Tech stack** (package.json, requirements.txt, go.mod, etc.)
2. **CLAUDE.md status** — exists? comprehensive? needs updating?
3. **Test coverage** — which modules lack tests? what framework?
4. **Commands & Hooks** — count, coverage of daily scenarios
5. **Recent git activity** — what has the user been working on?

**Generation Strategy**: Prefer project-specific tasks that deliver real value (adding tests, improving CLAUDE.md) over generic exercises. Adapt tools/commands to the detected tech stack.

### Step 3: Generate Practice Tasks

Generate 1-3 tasks based on current Level and focused sub-skill. Reference `ai-engineering-leveling-guide.md` for acceptance criteria.

- Status "not started" → beginner tasks; "in progress" → intermediate/advanced
- Each task should have 3 difficulty tiers (Beginner / Intermediate / Advanced)
- Priority: project-specific value-add > generic exercises

### Step 4: Output Format

```
## Practice Tasks (Current Focus: [sub-skill name], Level N)

### 📍 Project Scan Findings
[Findings relevant to the focused sub-skill]

### Task 1: [Name] (Project-Specific / Generic)
- **Difficulty**: Beginner / Intermediate / Advanced
- **Project Value**: [Actual benefit upon completion]
- **Steps**: 1. ... 2. ...
- **Acceptance Criteria**: [What counts as complete]
```

### Step 5: Remind to Update PROGRESS.md
After completing practice, remind the user to update sub-skill status.
