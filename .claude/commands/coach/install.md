AI coaching system one-click install with automatic initial assessment. Running this command will complete the installation and calibrate the coaching experience — no manual steps required.

**IMPORTANT**: Execute steps in strict order. Do NOT read PROGRESS.md or start any assessment before Step 1 (installation) completes successfully. The install must finish first.

## Steps

### Step 1: Detect Environment and Run Installation
1. Detect the current OS
2. Confirm we're in the AI Coach repo (CLAUDE.md and scripts/ must exist)
3. If not in repo, prompt user to `cd` into it first
4. Run install script directly (**do not ask for confirmation**):
   - macOS/Linux: `chmod +x scripts/install.sh && ./scripts/install.sh`
   - Windows: `.\scripts\install.ps1`

### Step 2: Verify Installation
Check that key files exist: `~/.claude/CLAUDE.md`, `~/.claude/commands/coach/assess.md`, `~/.claude/PROGRESS.md`. Report errors with remediation steps if any are missing.

### Step 3: Post-Install Guidance
- **Update** (install output contains "already exists, skipping"): ✅ Configuration updated! Progress preserved. → **Stop here** (skip Step 4).
- **First install** (install output contains "PROGRESS.md created"): ✅ Installation successful! → **Continue to Step 4**.

### Step 4: Initial Assessment (first install only)

This step replaces the need for users to exit, reopen Claude, and manually run `/coach:assess`. Perform the quick assessment inline right now.

1. Read `~/.claude/PROGRESS.md` — confirm "Current Level" shows "Pending Assessment"
   - If PROGRESS.md does **not** show "Pending Assessment": display "✅ Assessment already completed. Your progress is preserved." and **skip the rest of Step 4**.
2. Tell the user: "🎓 Let's do a quick assessment to calibrate your coaching experience. I'll ask 3 quick questions."
3. Ask these 3 questions **one at a time** (wait for each answer before asking the next):

   **Q1**: "How often do you use AI code completion (e.g., GitHub Copilot, Claude) in your daily development?"
   - Options: Never / Sometimes / Almost always

   **Q2**: "When you ask AI to write code, how do you typically describe what you want?"
   - Options: Paste the error or ask a short question / Describe the specific implementation steps / Describe the business goal and let AI decide the approach

   **Q3**: "Which of these have you used before?"
   - Options: None of these / Plan Mode / Custom Commands or Hooks / CI/CD with AI integration

4. Determine initial Level based on answers using this decision tree:
   - **Q1 score**: Never → 0, Sometimes → 1, Almost always → 2
   - **Q2 signal**: Paste error → L2, Specific steps → L4, Business goal → L5
   - **Q3 cap**: None → L4, Plan Mode → L4, Commands/Hooks → L7, CI/CD → L8
   - **Final Level** = min(Q2 signal, Q3 cap). If Q1 = 0 (Never), cap at L2 regardless.
   - Target Level = Current Level + 1

5. Update `~/.claude/PROGRESS.md`:
   - Set "Current Level" to the determined Level
   - Set "Target Level" to Current Level + 1
   - Set "Assessment Date" to today's date
   - Set appropriate sub-skill statuses to 🟡 for the current Level
   - Set "Focus Sub-skill" to the first 🟡 sub-skill at the current Level
   - Change 🎯 First Contact achievement from ⬜ to ✅
   - Add milestone entry: "Initial assessment via /coach:install — Level N"

6. Display results:
   ```
   📊 Initial Assessment Results
   - Current Level: N
   - Target Level: N+1
   - Focus: [focus sub-skill name]
   
   🎯 Achievement unlocked: First Contact!
   
   💡 For a deeper project-specific assessment, run /coach:assess in your working project.
   ```

## Notes
- Existing PROGRESS.md is never overwritten (local progress protected)
- CLAUDE.md uses tagged block merging — user's own rules are preserved
- To reset progress: delete `~/.claude/PROGRESS.md` and re-run `/coach:install`
- The inline assessment replaces the need to manually run `/coach:assess` after install
- For a full project-aware assessment (scanning CLAUDE.md, hooks, CI/CD, etc.), users should still run `/coach:assess` in their working project later
