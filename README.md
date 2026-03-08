[中文版](README.zh.md) | **English**

# AI Engineering Coach System

> A Claude Code-based AI engineering skills growth system. Once installed, it automatically assesses your operational level and provides growth suggestions during your daily Claude Code usage.

## What Is This?

You use Claude Code normally to write code, and this system **automatically appends** a brief coaching feedback after each interaction:

```
---
📊 AI Coach Assessment
- Current operation level: Level 4
- Current focus: Intent-driven development

💡 Upgrade suggestion:
- You said: "Add a search box with useState" (Level 4)
- Try: "Users need to quickly find items in a list of ~200 entries" (Level 5)
- Benefit: AI will decide between client-side filtering or server-side search, potentially giving you a better solution
```

It's based on the [AI Engineering Skills Complete Guide](coach/ai-engineering-leveling-guide.md) (Level 1→8), with core capabilities:

- **Auto-detection**: Identifies your operational level from prompt patterns (Level 3-8)
- **Progressive resistance**: When you give low-level prompts, suggests higher-level alternatives
- **Anti-pattern interception**: Real-time detection and warning of common pitfalls
- **Progress tracking**: Records sub-skill status and milestones

## Quick Start (3 Steps)

### Step 1: Clone the Repository

```bash
git clone https://github.com/anthropics/ClaudeCode-AI-Coach.git
cd ClaudeCode-AI-Coach
```

### Step 2: Install Locally

Open Claude Code in the repo directory, and type:

```
/coach:install
```

Claude will auto-detect your system and run the install script.

Or run manually:

**macOS / Linux**:
```bash
chmod +x scripts/install.sh
./scripts/install.sh
```

**Windows (PowerShell)**:
```powershell
.\scripts\install.ps1
```

The install script deploys the configuration to `~/.claude/`, taking effect globally for all projects on your machine.

### Step 3: Initial Assessment

If you used `/coach:install`, the initial assessment starts **automatically** right after installation — no need to exit or switch projects. Claude will ask 3 quick questions to calibrate your Level.

If you installed manually via the shell script, open Claude Code in any project and the coach will detect first-time setup and start the assessment automatically. You can also run:

```
/coach:assess
```

for a deeper project-specific assessment at any time.

**Done!** Just use Claude Code normally from now on — the coaching system works automatically.

## Daily Usage

### When Does It Appear?

**Every time you interact with Claude Code**, the coaching system runs in the background. No extra effort needed:

- Write code, ask questions, work on features — Claude handles your requests as usual
- After each interaction, Claude appends 2-3 lines of coaching assessment
- When your prompt has clear room for improvement, it provides specific upgrade suggestions

### When Should You Use Commands?

| Scenario | What to Do |
|----------|-----------|
| Want to check your progress | `/coach:assess` — Full re-assessment |
| Want practice but unsure what to do | `/coach:practice` — Get practice tasks for your current focus |
| Want to improve prompt quality | `/coach:review-prompt <your prompt>` — Analysis with upgrade suggestions |
| Need to report to your leader | `/coach:progress-report` — Generate a structured progress report |

### What Do the Levels Mean?

| Level | Your Status | AI's Role |
|-------|------------|-----------|
| 1-2 | Occasional autocomplete/Q&A | Typing assistant |
| 3-4 | Writing structured prompts, managing context | Junior engineer following instructions |
| 5 | Describing business intent, reviewing AI solutions | Mid-level engineer delivering independently |
| 6 | Managing multiple AI task streams simultaneously | A parallelizable dev team |
| 7 | Designing standardized workflows, AI executes by process | Automation pipeline |
| 8 | Configuring event triggers, AI runs autonomously | Infrastructure |

> See [Complete Level Definitions & Acceptance Criteria](coach/ai-engineering-leveling-guide.md)

## Multi-device Usage

Progress is maintained independently on each machine. When switching devices:

```bash
git clone → ./scripts/install.sh → auto assessment (or /coach:assess)
```

Re-assessment will quickly locate your Level based on your current skills — no manual data migration needed.

## Updating the Coach System

When the repo has a new version:

```bash
git pull
./scripts/install.sh  # or Windows: .\scripts\install.ps1
```

The install script updates configs and commands but **won't overwrite your local progress**.

## File Structure

```
ClaudeCode-AI-Coach/
├── README.md                            ← English README
├── README.zh.md                         ← Chinese README
├── CLAUDE.md                            ← Dev config (for project contributors)
├── coach/                               ← Distributable source files
│   ├── CLAUDE.md                        ← Core: coaching rules
│   ├── PROGRESS.md                      ← Progress template
│   ├── ai-engineering-leveling-guide.md ← Full Level 1-8 guide
│   └── commands/coach/                  ← Commands installed to user scope
│       ├── assess.md
│       ├── practice.md
│       ├── progress-report.md
│       ├── review-prompt.md
│       └── uninstall.md
├── .claude/
│   ├── commands/coach/
│   │   └── install.md                   ← /coach:install (project scope only)
│   └── settings.local.json              ← Project-level Claude settings
└── scripts/
    ├── install.sh                       ← macOS/Linux install
    ├── install.ps1                      ← Windows install
    ├── uninstall.sh                     ← macOS/Linux uninstall
    └── uninstall.ps1                    ← Windows uninstall
```

## Customization & Extension

- **Add commands**: Create `.md` files in `coach/commands/coach/`, then reinstall
- **Modify rules**: Edit `coach/CLAUDE.md`, then reinstall. The marker-block mechanism won't affect your other local rules
- **Project-level rules**: The root `CLAUDE.md` is for project contributors developing this coach system. The coaching rules live in `coach/CLAUDE.md` and get installed globally

## License

Personal use.
