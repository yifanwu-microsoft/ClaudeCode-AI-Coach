AI coaching system one-click install. Running this command will automatically complete the installation — no manual steps required.

## Execution Steps

### Step 0: Language Selection

1. Ask the user: "Please select installation language / 请选择安装语言"
2. Provide two options:
   - English
   - 中文
3. Based on the selection, remember the corresponding `--lang` flag:
   - English → `--lang en`
   - 中文 → `--lang zh`

### Step 1: Detect Environment and Run Installation

1. Detect the current operating system
2. Confirm the current directory is the AI Coach repo (check that CLAUDE.md and scripts/ exist)
3. If not in the repo directory, prompt the user to `cd` into the repo directory first
4. Run the install script directly (using the language selected in Step 0):
   - macOS/Linux: `chmod +x scripts/install.sh && ./scripts/install.sh --lang <selected>`
   - Windows: `powershell -File scripts\install.ps1 -Lang <selected>`

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
