One-click uninstall for the AI Coach system. After executing this command, uninstallation completes automatically — no manual steps needed.

## Steps

### Step 1: Confirm Uninstall Intent

Ask the user:
- Whether to keep PROGRESS.md (which contains learning progress data)
- Default recommendation: keep it (`--keep-progress`)

### Step 2: Detect Environment and Execute Uninstall

1. Detect the current operating system
2. Confirm the current directory is the AI Coach repo (check if scripts/uninstall.sh exists)
3. If not in the repo directory, prompt the user to `cd` into the repo directory first
4. Execute the uninstall script based on user choice:
   - macOS/Linux: `chmod +x scripts/uninstall.sh && ./scripts/uninstall.sh [--keep-progress]`
   - Windows: `powershell -File scripts\uninstall.ps1 [-KeepProgress]`

### Step 3: Verify Uninstall Results

The uninstall script has built-in verification, but additionally check:
- `~/.claude/CLAUDE.md` no longer contains the `<!-- AI-COACH-START -->` marker
- `~/.claude/commands/` no longer contains coach system command files (assess.md, practice.md, etc.)
- `~/.claude/ai-engineering-leveling-guide.md` has been deleted
- If the user chose to delete progress: `~/.claude/PROGRESS.md` has been deleted

If any verification fails, report the error and provide manual cleanup instructions.

### Step 4: Post-Uninstall Summary

- Inform the user: ✅ Uninstall complete! The coaching system has been removed from this machine.
- If PROGRESS.md was kept, note: Your learning progress has been preserved and will be available if you reinstall.
- Remind: To reinstall, run `/coach:install`

## Notes

- Uninstall only removes content installed by the coaching system — it does not affect user's own rules in CLAUDE.md
- Default recommendation is to keep PROGRESS.md to avoid losing learning progress
- After uninstalling, `/coach:assess`, `/coach:practice` and other coach commands will no longer be available
