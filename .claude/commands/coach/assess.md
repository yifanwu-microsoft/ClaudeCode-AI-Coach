Perform a comprehensive AI engineering capability assessment.

## Assessment Process

### Step 1: Read Current State
Read the `PROGRESS.md` file in the project root to understand the user's historical progress and current focus.

### Step 2: Objective Signal Scan (automated, no user input required)

Before the questionnaire assessment, automatically scan the current project and environment to collect objective evidence:

**Scan Items:**
1. **CLAUDE.md Existence & Quality**: Check if CLAUDE.md exists in the project root. If so, evaluate its content (does it include tech stack, conventions, directory structure, workflow rules, etc.)
2. **Custom Commands**: Check if `.claude/commands/` directory exists and the number/content of command files
3. **Hooks Configuration**: Check `.claude/settings.json` or `.claude/settings.local.json` for Hooks configuration
4. **CI/CD AI Integration**: Check `.github/workflows/` for AI-related workflows (e.g., ai-review.yml, ai-autofix.yml, ai-triage.yml)
5. **Git Conventions**: Review the last 10 git log entries, check if commit messages follow conventional commits format
6. **Test Coverage**: Check for test files (e.g., *_test.go, *.test.ts, *.spec.ts, test_*.py, *Test.java, etc.) and their ratio to source files
7. **Project Structure**: Scan project directory structure to understand the tech stack and project scale

**Output Scan Report:**
```
## Objective Signal Scan Results

| Check Item | Result | Corresponding Level |
|------------|--------|-------------------|
| CLAUDE.md | ✅ Exists with tech stack + conventions / ❌ Not found | Level 3-4 |
| Custom Commands | ✅ X commands / ❌ Not configured | Level 7 |
| Hooks Config | ✅ Configured / ❌ Not configured | Level 7 |
| CI/CD AI Integration | ✅ X workflows / ❌ Not configured | Level 8 |
| Git Conventions | ✅ Conventional commits / ⚠️ Non-standard | Level 7 |
| Test Files | ✅ X test files / ❌ No tests | Level 5 |
```

Use scan results as reference for subsequent assessment. If scan results contradict the user's self-assessment (e.g., user claims Level 7 but project has no Commands), gently point out the discrepancy.

### Step 3: Item-by-Item Assessment (based on ai-engineering-leveling-guide.md Self-Assessment Checklist)

Combining the objective signals from Step 2, score each item (0 = does not meet at all, 1 = partially meets, 2 = fully meets):

**Foundation Skills (Level 1-2)**
- Uses AI code completion in daily development
- Can have basic conversations in Claude Code
- Can judge whether AI-generated code is usable

**Prompt Engineering (Level 3-4)**
- Can write structured prompts with context + constraints + expected output
- Project has a CLAUDE.md that is kept up to date
- Uses Plan Mode for planning before complex tasks
- Less than 20% of AI-generated code requires manual modification

**Autonomous Development (Level 5)**
- Describes business intent rather than technical implementation; AI independently selects the approach
- Can independently delegate complete features (frontend + API + tests)
- AI solutions pass architecture review on first attempt > 80% of the time

**Parallel & Orchestration (Level 6-7)**
- Can manage 3+ Claude Code instances in parallel development
- Proficient with Git Worktree for isolating parallel tasks
- Has 5+ Custom Slash Commands
- Has configured Hooks for automated quality checks

**System Level (Level 8)**
- AI is integrated into CI/CD (Headless mode)
- Has AI-powered auto-fix capability for failed pipelines
- Has comprehensive AI workflow monitoring and cost controls

### Step 4: Calculate Score & Level

Scoring criteria: 0-4 → Level 1-2 ｜ 5-8 → Level 3-4 ｜ 9-11 → Level 5 ｜ 12-15 → Level 6-7 ｜ 16-18 → Level 8

### Step 5: Compare with History

Compare the current assessment with the previous one in PROGRESS.md, noting:
- Which items improved (higher scores)
- Which items remained the same (stagnant)
- Which items need a focused breakthrough

### Step 5.5: Adjust Output Detail Based on Assessed Level

Adjust the level of detail in subsequent output based on the assessed Level to avoid information overload:

- **If assessed Level is 1-2**:
  - Use concise language to explain each Level (one sentence summary) to help the user build an overall understanding
  - Only show detailed sub-skill lists for Level 1-2 and Level 3-4
  - Summarize Level 5-8 in one line each (e.g., "Level 7: Workflow Orchestration — Automate repetitive processes with Commands and Hooks")
  - Emphasize "what to do next" rather than displaying the full skill tree

- **If assessed Level is 3-5**:
  - Show detailed sub-skill status for the current Level and the next Level
  - Present Level 6+ sub-skills as brief summaries (one line per Level)
  - Focus on the specific upgrade path from the current Level to the next

- **If assessed Level is 6+**:
  - Show full sub-skill details including status for all Levels
  - Include advanced metrics (parallel efficiency, automation coverage, etc.)

### Step 6: Cross-Validation

Cross-validate the objective scan results from Step 2 against the self-assessment scores from Step 3:
- If objective signals support the self-assessment → increases assessment confidence
- If objective signals contradict the self-assessment → gently point this out and ask the user for context (e.g., they may use these practices in other projects, or are in the process of migrating)
- Reflect cross-validation results in the assessment report

### Step 6.5: Previously Passed Level Skill Spot Check (Anti-Degradation)

If the user has already passed certain Levels (sub-skills marked 🟢 in PROGRESS.md), spot-check that key skills are being maintained:

**Spot Check Rules:**
- Spot-check 1-2 key skills from previously passed Levels (no need to re-test everything)
- Focus on skills that are "prone to degradation":
  - Level 3-4: Is CLAUDE.md being kept up to date? (check file modification date)
  - Level 5: Are recent prompts still intent-driven?
  - Level 7: Are Custom Commands still being used? Are Hooks still running?
- If degradation is found, remind gently: no downgrade, but suggest spending 10 minutes to restore

**Output Format (only shown when degradation is detected):**
```
### ⚠️ Skill Maintenance Check
| Passed Skill | Current Status | Suggestion |
|-------------|----------------|------------|
| CLAUDE.md Maintenance (L3-4) | ⚠️ Not updated in 30+ days | Spend 10 minutes checking if it needs updating |
```

### Step 7: Output Results

Format:
```
## Assessment Results

**Date**: [today's date]
**Total Score**: X / 18
**Current Level**: N
**Recommended Target Level**: N+1

### Objective Signal Scan
[Step 2 scan results table]

### Scores by Dimension
| Dimension | Score | Objective Signals | Notes |
|-----------|-------|------------------|-------|
| Foundation Skills | X/6 | — | ... |
| Prompt Engineering | X/8 | CLAUDE.md: ✅/❌ | ... |
| Autonomous Development | X/6 | Test files: ✅/❌ | ... |
| Parallel & Orchestration | X/8 | Commands: X, Hooks: ✅/❌ | ... |
| System Level | X/6 | CI workflows: X | ... |

### Current Level Sub-Skill Status
[Based on the assessed Level, list sub-skill status and recommendations for this Level and the next]
[For example: if assessed at Level 5, list sub-skills for Level 5 and Level 6]

### Recommended Focus
[Based on assessment results, recommend which sub-skill to focus on and specific next steps]
[Prioritize sub-skills at the current Level that have not yet been validated]
```

### Step 8: Update PROGRESS.md

After assessment:
1. Update the "Current Overall Assessment" with Level, target Level, and assessment date
2. Update sub-skill status for the corresponding Level (change 🔴 to 🟡 or 🟢 based on results)
3. Update the "Current Focus" field
4. Add this assessment to the "Milestone Log"
5. All changes require **user confirmation** before being applied
