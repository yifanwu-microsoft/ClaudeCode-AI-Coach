AI coaching system one-click install. Running this command will automatically complete the installation — no manual steps required.

## Execution Steps

### Step 1: Detect Environment and Run Installation

1. Detect the current operating system
2. Confirm the current directory is the AI Coach repo (check that CLAUDE.md and scripts/ exist)
3. If not in the repo directory, prompt the user to `cd` into the repo directory first
4. Run the install script directly:
   - macOS/Linux: `chmod +x scripts/install.sh && ./scripts/install.sh`
   - Windows: `.\scripts\install.ps1`

**Execute directly — do not ask for confirmation.**

### Step 2: Verify Installation

After the install script runs, verify that key files are in place:
- Check that `~/.claude/CLAUDE.md` exists
- Check that `~/.claude/commands/coach/assess.md` exists
- Check that `~/.claude/PROGRESS.md` exists

If any file is missing, report the error and provide remediation steps.

### Step 3: Post-Install Guidance

Provide different guidance based on the situation:

**First-time install** (install script output contains "created"):
- Inform the user: ✅ Installation successful! The coaching system is now active globally
- Suggest: You can now open Claude Code in any project and run `/coach:assess` for your initial assessment
- Note: From now on, Claude will automatically append coaching feedback after each interaction — no extra steps needed

**Update install** (install script output contains "already exists, skipping"):
- Inform the user: ✅ Configuration updated! Your progress is preserved
- Note: Commands and CLAUDE.md rules have been updated to the latest version

## Notes

- Installation will not overwrite an existing PROGRESS.md (your local progress is protected)
- CLAUDE.md uses tagged block merging and will not affect your own custom rules
- To reset progress, manually delete `~/.claude/PROGRESS.md` and re-run `/coach:install`
