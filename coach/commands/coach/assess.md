Perform a comprehensive AI engineering capability assessment.

## Assessment Process

### Step 1: Read Current State
Read the `PROGRESS.md` file in the project root to understand the user's historical progress.

### Step 2: Objective Signal Scan (automated, no user input required)

Scan the current project and environment to collect objective evidence before the questionnaire:

**Scan Items:**
1. **CLAUDE.md** — exists? includes tech stack, conventions, directory structure?
2. **Custom Commands** — `.claude/commands/` directory, count and content
3. **Hooks Configuration** — `.claude/settings.json` or `.claude/settings.local.json`
4. **CI/CD AI Integration** — `.github/workflows/` for AI-related workflows
5. **Git Conventions** — last 10 git log entries, conventional commits?
6. **Test Coverage** — test files ratio to source files
7. **Project Structure** — directory structure, tech stack, scale

Output a scan results table with: Check Item | Result (✅/❌) | Corresponding Level. Use results as reference for subsequent assessment. Flag contradictions between scan results and self-assessment.

### Step 3: Item-by-Item Scoring (based on ai-engineering-leveling-guide.md)

Score each item 0–2 (0 = not met, 1 = partially, 2 = fully met), combining objective signals from Step 2:

**For each dimension, reference the corresponding `### Done When: Acceptance Criteria` section in `ai-engineering-leveling-guide.md` for precise scoring benchmarks. Also check `🎯 Behavioral signals` to supplement quantitative criteria with qualitative behavioral indicators.**

For Level definitions and skill dimensions, see **CLAUDE.md** — Level Detection Rules + Scoring Reference. Key points:
- **Scoring range**: 0-4 → L1-2, 5-8 → L3-4, 9-11 → L5, 12-15 → L6-7, 16-18 → L8
- **Skill dimensions**: Foundation (L1-2), Prompting (L3-4), Autonomous (L5), Parallel (L6-7), System (L8)

### Step 4: Cross-Validation & History Comparison

1. **Compare with history**: Note improvements, stagnation, and areas needing breakthrough vs. PROGRESS.md
2. **Cross-validate**: If scan results contradict self-assessment, gently point out and ask for context
3. **Spot-check passed skills** (anti-degradation): For 🟢 skills, check 1-2 degradation-prone items (e.g., is CLAUDE.md still current? Are recent prompts still intent-driven?)
4. **Stuck detection**: If a sub-skill has been 🟡 for 3+ assessments, reference the `### Stuck? Diagnosis Checklist` for that Level and include the most relevant diagnosis in recommendations
4. **Adjust detail level**: L1-2 users see L1-4 details only; L3-5 see current + next Level; L6+ see full details

### Step 5: Output Results

Format: Date, Total Score (/18), Current Level, Recommended Target Level, Scan Results table, Scores by Dimension table (with objective signals), Current Level Sub-Skill Status, and Recommended next steps.

### Step 6: Update PROGRESS.md

After assessment (all changes require **user confirmation**):
1. Update Overall Assessment (Level, target, date)
2. Update sub-skill status (🔴→🟡 or 🟢 based on results)
3. Add this assessment to the Milestone Log
