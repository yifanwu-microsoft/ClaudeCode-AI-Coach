# CLAUDE.md — Development Configuration

This is the development repository for the **AI Engineering Coach System**, a Claude Code-based tool that coaches developers on AI-assisted engineering practices (Levels 1–8). The distributable coach files live in `coach/` — this root `CLAUDE.md` is for project development only.

## Directory Structure

```
coach/                  # Distributable source files (installed to ~/.claude/)
├── CLAUDE.md           #   Coach system prompt (custom instructions)
├── PROGRESS.md         #   User progress template
├── ai-engineering-leveling-guide.md  # Level 1-8 definitions
└── commands/coach/     #   Slash commands (/coach:assess, /coach:practice, etc.)
scripts/                # Install/uninstall scripts
├── install.sh          #   Deploys coach files to ~/.claude/
├── uninstall.sh        #   Removes coach files from ~/.claude/
├── install.ps1         #   Windows install (PowerShell)
└── uninstall.ps1       #   Windows uninstall (PowerShell)
.claude/                # Project-level Claude Code settings (dev only)
README.md / README.zh.md   # Project documentation (EN/CN)
CLAUDE.md               # This file — dev configuration
```

## Development Workflow

1. **Edit** coach files in `coach/` directory
2. **Install** by running `./scripts/install.sh` to deploy to `~/.claude/`
3. **Test** by opening a different project and verifying the coaching experience
4. **Iterate** — changes in `coach/` don't take effect until reinstalled

## Key Conventions

### Relative References in coach/CLAUDE.md

The coach system prompt (`coach/CLAUDE.md`) references `PROGRESS.md` and `ai-engineering-leveling-guide.md` as "in this directory." This is intentional — after install, all three files land in `~/.claude/`, so the references resolve correctly. **Do NOT change these to absolute paths or add `coach/` prefixes.**

### Install Script Marker Blocks

The install script merges coach content into the user's existing `~/.claude/CLAUDE.md` using marker blocks:

```
<!-- AI-COACH-START -->
... coach system prompt content ...
<!-- AI-COACH-END -->
```

This allows users to have their own custom instructions alongside the coach. The uninstall script removes only the marked block.

### Command Files

Commands in `coach/commands/coach/` are installed to `~/.claude/commands/coach/`. Each command file (e.g., `assess.md`, `practice.md`) becomes a `/coach:*` slash command.

## i18n

Both English and Chinese versions of README exist at the root (`README.md`, `README.zh.md`). Translation sync is managed via the `/coach:i18n` command. When updating user-facing text, ensure both languages stay in sync.

## Testing Checklist

- [ ] Run `./scripts/install.sh` — verify files appear in `~/.claude/`
- [ ] Open a **different** project with Claude Code — verify `/coach:assess` and other commands work
- [ ] Test install with an existing `~/.claude/CLAUDE.md` — confirm marker block merging preserves user content
- [ ] Run `./scripts/uninstall.sh` — verify clean removal (marker block removed, other content intact)
- [ ] Test on a fresh machine (no `~/.claude/` directory) — verify install creates everything needed
