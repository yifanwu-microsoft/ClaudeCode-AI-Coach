One-click uninstall for the AI Coach system. After executing this command, uninstallation completes automatically — no manual steps needed.

## Steps

### Step 1: Detect Environment and Execute
1. Detect current OS
2. Confirm we're in the AI Coach repo (scripts/uninstall.sh must exist)
3. If not in repo, prompt user to `cd` into it first
4. Execute (with `--yes` to skip interactive prompts):
   - macOS/Linux: `chmod +x scripts/uninstall.sh && ./scripts/uninstall.sh --yes`
   - Windows: `powershell -ExecutionPolicy Bypass -File scripts/uninstall.ps1 --yes`

### Step 2: Verify
Check that: `~/.claude/CLAUDE.md` no longer contains `<!-- AI-COACH-START -->`, coach command files are removed, `~/.claude/ai-engineering-leveling-guide.md` is deleted, and PROGRESS.md is deleted. Report errors with manual cleanup steps if verification fails.

### Step 3: Summary
- ✅ Uninstall complete!
- To reinstall: run `/coach:install`

## Notes
- Only removes coaching system content — user's own CLAUDE.md rules are preserved
- PROGRESS.md is always removed during uninstall; it will be recreated on reinstall
