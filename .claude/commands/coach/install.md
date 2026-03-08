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

### Step 3: Post-Install Routing
- **Update** (install output contains "already exists, skipping"): ✅ Configuration updated! Progress preserved. → **Stop here**.
- **First install** (install output contains "PROGRESS.md created"): ✅ Installation successful! → **Continue to Step 4 immediately. Do NOT tell the user to run `/coach:assess` manually — the assessment happens automatically in Step 4.**

### Step 4: Automatic Initial Assessment (first install only)

This step eliminates the need for users to exit, reopen Claude, and manually run `/coach:assess`.

1. Read `~/.claude/PROGRESS.md` — confirm "Current Level" shows "Pending Assessment".
   - If it does **not** show "Pending Assessment": display "✅ Assessment already completed. Your progress is preserved." and **stop**.
2. Tell the user: "🎓 Installation complete! Let's run your initial assessment to calibrate the coaching experience."
3. **Execute the full `/coach:assess` assessment process** — follow all steps defined in the assess command (objective signal scan, item-by-item scoring, cross-validation, results output, and PROGRESS.md update).

## Notes
- Existing PROGRESS.md is never overwritten (local progress protected)
- CLAUDE.md uses tagged block merging — user's own rules are preserved
- To reset progress: delete `~/.claude/PROGRESS.md` and re-run `/coach:install`
