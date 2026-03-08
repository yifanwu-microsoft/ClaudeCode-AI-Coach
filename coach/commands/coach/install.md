AI coaching system one-click install. Running this command will automatically complete the installation — no manual steps required.

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
- **First install** (output contains "created"): ✅ Installation successful! Run `/coach:assess` in any project for initial assessment.
- **Update** (output contains "already exists, skipping"): ✅ Configuration updated! Progress preserved.

## Notes
- Existing PROGRESS.md is never overwritten (local progress protected)
- CLAUDE.md uses tagged block merging — user's own rules are preserved
- To reset progress: delete `~/.claude/PROGRESS.md` and re-run `/coach:install`
