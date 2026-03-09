Run an interactive practice session for the user's current Level sub-skills.

## Session Flow

### Step 1: Read State & Scan Context
Read `PROGRESS.md` for: current Level, target Level, sub-skill statuses across all Levels.
Scan project for: tech stack, test coverage, CLAUDE.md status, recent git activity.

Pick the most impactful sub-skill to practice: prioritize 🔴 sub-skills at the target Level, then 🟡 sub-skills at the current Level.

If no project context exists, suggest creating a small practice project appropriate to the Level.

### Step 2: Select Exercise Mode

Based on the selected sub-skill, choose ONE exercise mode:

**Mode A: Prompt Gym** (for L1-5 sub-skills related to prompt quality)
Interactive prompt improvement exercise:
1. Present a realistic scenario from the user's project (or a relevant hypothetical)
2. Ask the user to write a prompt for this scenario
3. Analyze their prompt: What Level is it? What's missing? What's good?
4. Show a side-by-side comparison with a higher-Level version
5. Ask the user to try again with the feedback
6. Repeat until the prompt reaches their target Level

**Mode B: Delegation Drill** (for L5 sub-skills: feature delegation, architecture review)
Real feature delegation exercise:
1. Identify a small, real task in the user's project (e.g., a module without tests, a missing feature)
2. Ask the user to write an intent-driven delegation prompt for it
3. Execute the prompt and generate the code
4. Guide the user through reviewing the output: architecture fit? edge cases? tests?
5. Score the review: what did they catch? what did they miss?

**Mode C: Parallel Planning** (for L6 sub-skills)
Task decomposition exercise:
1. Present a medium-complexity feature (from project backlog or hypothetical)
2. Ask the user to decompose it into subtasks
3. Ask them to identify: which can run in parallel? what are the dependencies?
4. Ask them to define interface contracts for parallel tasks
5. Compare with an expert decomposition — discuss differences

**Mode D: Automation Hunt** (for L7-8 sub-skills)
Workflow automation exercise:
1. Ask the user to describe their last 3 repetitive workflows with Claude
2. Identify which could be automated with Commands/Hooks/CI
3. Guide the user through creating one Command or Hook live
4. Test it together

### Step 3: Run the Session

Execute the selected mode interactively. Key principles:
- **One step at a time** — don't dump all instructions at once
- **Wait for user input** before proceeding to the next step
- **Give specific feedback** — not "good job" but "your prompt included constraints (good!) but missed the performance target"
- **Use the user's actual project** whenever possible
- **Reference `ai-engineering-leveling-guide.md`** — look up `### Practice: Exercises` for inspiration, `### Anti-patterns: Common Pitfalls` to counter common mistakes, and `### Done When: Acceptance Criteria` to align with graduation requirements

### Step 4: Debrief

After the exercise:
1. Summarize what the user practiced and what they learned
2. Rate their performance on the practiced sub-skill (Beginner / Intermediate / Advanced)
3. If they demonstrated competence, suggest updating PROGRESS.md sub-skill status
4. Suggest when to practice again (e.g., "try Mode A again tomorrow with a different scenario")
5. Check if any achievements should be unlocked based on what happened during practice
