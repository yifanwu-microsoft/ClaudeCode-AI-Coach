Perform a question-based AI engineering capability assessment. This evaluates the **user's** actual skill level through behavioral questions — NOT by scanning project signals (which only reflect the project author's level, not the current user).

## Assessment Process

### Step 1: Read Current State
Read the user's `PROGRESS.md` file (in `~/.claude/`) to understand historical progress. If this is a first assessment, note it.

### Step 2: Phase 1 — Quick Calibration (3 questions)

Ask these 3 multiple-choice questions **one at a time** using the `ask_user` tool (with `choices` array). This gives the user clickable options instead of plain text. Present in the user's language (detect from their previous messages).

**Q1: AI Usage Frequency**
Use `ask_user` with question and choices:
- "Rarely or never"
- "Mainly Tab auto-completion"
- "Frequently collaborate with AI through conversation"
- "AI is my primary development method — most code is AI-generated"

Scoring: choices map to 0, 1, 2, 3 pts respectively.

**Q2: Task Description Style**
Use `ask_user` with question and choices:
- "Paste error messages directly or ask 'how do I do this'"
- "Provide context + specific implementation steps"
- "Describe business goals and acceptance criteria, let AI decide the approach"
- "Decompose into multiple independent task streams, use multiple AI instances in parallel"

Scoring: choices map to 0, 1, 2, 3 pts respectively.

**Q3: Advanced Features (multi-select)**
Use `ask_user` with question and choices (tell user to select all that apply, and allow freeform so they can list multiple):
- Plan Mode
- CLAUDE.md / project-level AI configuration
- Custom Slash Commands
- Git Worktrees + multi-agent parallel development
- Hooks automation (e.g., auto-check, auto-test)
- CI/CD AI integration (Headless mode)

Scoring: 0 items = 0 pts, 1-2 items = 1 pt, 3-4 items = 2 pts, 5-6 items = 3 pts

**Calculate Calibration Band:**
- Total 0-2 pts → Band L1-2
- Total 3-5 pts → Band L3-4
- Total 6-7 pts → Band L5-6
- Total 8-9 pts → Band L7-8

### Step 3: Phase 2 — Level-Specific Deep Dive

Based on the calibration band from Phase 1, ask 3-4 **targeted** questions within the estimated band ± 1 level. Each scores 0-2.

Use `ask_user` tool with `choices` for each question. Present one at a time. Adapt phrasing to user's language.

#### If Band L1-2:
- "When AI generates code, what do you typically do with it?" → choices: ["Accept directly", "Skim quickly", "Review line by line and understand"] (0/1/2)
- "Can you describe a specific task you completed with AI this past week?" → use `ask_user` with `allow_freeform: true`, no choices. Score based on complexity: trivial=0, moderate=1, substantial=2
- "Can you accurately judge the quality of AI-generated code?" → choices: ["Not really", "Sometimes", "Yes, and I've caught bugs"] (0/1/2)

#### If Band L3-4:
- "How many conversation rounds does it typically take to get a satisfactory result?" → choices: ["5+ rounds", "3-5 rounds", "1-3 rounds"] (0/1/2)
- "How often do you use Plan Mode?" → choices: ["Never tried", "Occasionally", "Always for 3+ file changes"] (0/1/2)
- "Does your project have a CLAUDE.md? What does it contain?" → choices: ["No", "Yes, but minimal", "Yes, complete with tech stack + conventions + structure"] (0/1/2)

#### If Band L5-6:
- "Can you delegate a complete feature (frontend + API + DB) to AI in one session?" → choices: ["Never tried", "Tried but needed heavy editing", "Yes, regularly"] (0/1/2)
- "What percentage of AI-generated code passes review on first attempt?" → choices: ["Less than 50%", "50-80%", "More than 80%"] (0/1/2)
- "How many parallel AI workflows have you managed simultaneously?" → choices: ["1", "2", "3 or more"] (0/1/2)
- "When decomposing parallel tasks, do you define interface contracts first?" → choices: ["Unsure what that means", "Sometimes", "Always define contracts first"] (0/1/2)

#### If Band L7-8:
- "How many Custom Slash Commands have you created?" → choices: ["0", "1-2", "3 or more"] (0/1/2)
- "Can a fresh Claude instance complete a standard task using only your CLAUDE.md + Commands?" → choices: ["No", "Partially", "Yes, completely"] (0/1/2)
- "Have you integrated AI into CI/CD pipelines?" → choices: ["No", "Experimenting", "In production"] (0/1/2)
- "Have you configured headless/automated AI workflows with monitoring?" → choices: ["No", "Partially", "Yes, fully"] (0/1/2)

### Step 4: Score Calculation & Validation

**Scoring Formula:**
- Phase 1 score (max 9) + Phase 2 score (max 8) = Total (max 17)

**Level Mapping:**
| Total Score | Level |
|------------|-------|
| 0-2 | Level 1 |
| 3-4 | Level 2 |
| 5-7 | Level 3 |
| 8-9 | Level 4 |
| 10-11 | Level 5 |
| 12-13 | Level 6 |
| 14-15 | Level 7 |
| 16-17 | Level 8 |

**Cross-Validation:** If Phase 2 answers contradict Phase 1 (e.g., claimed AI-primary development in Q1 but can't describe intent-driven delegation in Phase 2), cap the level at the lower evidence. Gently note the discrepancy.

**History Comparison:** If prior assessment exists in PROGRESS.md, compare and note improvements or stagnation.

### Step 5: Output Results

Present results in a clear table format:

1. **Assessment Summary:** Date, Phase 1 Score, Phase 2 Score, Total Score, Current Level, Target Level (current + 1)
2. **Scores by Dimension:** Show which level bands are strong/weak
3. **Current Level Sub-Skills:** Map to `ai-engineering-leveling-guide.md` sub-skills, show status (🔴/🟡/🟢) based on answers
4. **Gap to Next Level:** What specific skills to develop
5. **Recommended Next Steps:** 2-3 actionable items referencing the leveling guide

### Step 6: Update PROGRESS.md

After showing results, **automatically update** `~/.claude/PROGRESS.md`:
1. Update Overall Assessment (Level, target, date, method: Question-Based)
2. Update sub-skill statuses based on answers
3. Add milestone entry

No confirmation needed — the user initiated the assessment, results are objective from their answers.
