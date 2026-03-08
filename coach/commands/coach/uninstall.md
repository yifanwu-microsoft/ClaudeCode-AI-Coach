One-click uninstall for the AI Coach system. After executing this command, uninstallation completes automatically — no manual steps needed.

## Steps

### Step 1: Confirm Intent
Ask the user whether to keep PROGRESS.md (contains learning progress). Default recommendation: keep it.

### Step 2: Detect Environment and Execute
1. Detect current OS
2. Confirm we're in the AI Coach repo (scripts/uninstall.sh must exist)
3. If not in repo, prompt user to `cd` into it first
4. Execute based on user choice:
   - macOS/Linux: `chmod +x scripts/uninstall.sh && ./scripts/uninstall.sh [--keep-progress]`
   - Windows: `powershell -File scripts\uninstall.ps1 [-KeepProgress]`

### Step 3: Verify
Check that: `~/.claude/CLAUDE.md` no longer contains `<!-- AI-COACH-START -->`, coach command files are removed, `~/.claude/ai-engineering-leveling-guide.md` is deleted, and (if chosen) PROGRESS.md is deleted. Report errors with manual cleanup steps if verification fails.

### Step 4: Summary
- ✅ Uninstall complete! If PROGRESS.md was kept, note it's preserved for reinstall.
- To reinstall: run `/coach:install`

## Notes
- Only removes coaching system content — user's own CLAUDE.md rules are preserved
- Default: keep PROGRESS.md to avoid losing learning progress
