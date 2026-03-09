[Chinese 中文](README.zh.md) | **English**

<div align="center">

# 🏋️ AI Engineering Coach System

### Level up your AI-assisted development skills — from beginner to automation expert

*An always-on coaching system for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that observes how you work with AI, assesses your proficiency level (1→8), and gives you personalized growth advice — automatically, in every interaction.*

[Quick Start](#-quick-start) · [How It Works](#-how-it-works) · [Commands](#-commands-reference) · [Levels Guide](#-the-8-levels) · [FAQ](#-faq)

</div>

---

## 🤔 Why This Exists

Most developers use AI coding tools at a fraction of their potential. You might be writing every prompt by hand when you could be delegating entire features. You might be running one task at a time when you could be running three in parallel.

**The problem isn't the tool — it's that no one teaches you the progression.** This coaching system does.

## ✨ What It Does

Install once, then just use Claude Code normally. The coach watches how you interact with AI and appends brief, actionable feedback after every response:

**💡 Upgrade suggestion** — when you could be prompting at a higher level:
```
---
📊 **AI Coach** · Level 4

💡 **Upgrade**: You said "Add a search box with useState and filter the list"

→ **Try**: "Users need to quickly find items in a list of ~200 entries, optimized for mobile"

→ **Why**: AI will choose between client-side filtering or server search, and handle edge cases you didn't think of
```

**✅ Positive reinforcement** — when you're doing great:
```
---
📊 **AI Coach** · Level 5

✅ **Good**: Your intent-driven prompt let AI independently choose the pagination strategy

💡 **Next**: Try delegating the full feature (API + component + tests) in one go to practice L5 Feature Delegation
```

**⚠️ Anti-pattern warning** — when it detects a common pitfall:
```
---
📊 **AI Coach** · Level 6

⚠️ You have 5 agents running simultaneously — that's hard to manage. Start with 2-3 and scale up as you build confidence.
```

### Core Capabilities

| Capability | Description |
|---|---|
| 🔍 **Auto-detection** | Identifies your operational level from prompt patterns (Level 1-8) |
| 📈 **Progressive resistance** | When you give low-level prompts, suggests higher-level alternatives using *your own words* |
| 🚫 **Anti-pattern interception** | Real-time detection and warning of common pitfalls at each level |
| 📊 **Progress tracking** | Records sub-skill status, achievements, and milestones in a local progress file |
| 🏅 **Achievement system** | Automatically unlocks achievements as you demonstrate new skills (15 achievements total) |
| 🧠 **Context-aware coaching** | Adapts advice to your tech stack, task type, and project context |

## 📋 Prerequisites

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed and working
- Git

## 🚀 Quick Start

### Step 1 — Clone

```bash
git clone https://github.com/anthropics/ClaudeCode-AI-Coach.git
cd ClaudeCode-AI-Coach
```

### Step 2 — Install

The simplest way: open Claude Code inside this repo and run:

```
/coach:install
```

Claude auto-detects your OS and runs the install script.

<details>
<summary>Or install manually</summary>

**macOS / Linux:**
```bash
chmod +x scripts/install.sh
./scripts/install.sh
```

**Windows (PowerShell):**
```powershell
.\scripts\install.ps1
```
</details>

> The install script deploys everything to `~/.claude/` — it takes effect **globally** for all your projects. If you already have a `~/.claude/CLAUDE.md`, the script merges the coach config using marker blocks without touching your existing rules.

### Step 3 — Get Assessed

Open Claude Code in **any project** and run:

```
/coach:assess
```

Claude asks about your AI tool usage habits, scores each dimension, and determines your starting Level.

**That's it!** From now on, every Claude Code interaction includes coaching feedback automatically.

## 🔬 How It Works

```
┌─────────────────────────────────────────────────────────┐
│  You use Claude Code normally (write code, ask questions) │
└──────────────────────────┬──────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│  Coach system (injected via CLAUDE.md) observes:         │
│  • Your prompt patterns (how you describe tasks)         │
│  • Your interaction style (how many rounds, edits)       │
│  • Your project context (tech stack, file structure)     │
└──────────────────────────┬──────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│  After completing your request, Claude appends:          │
│  • Level assessment (what level this interaction was)    │
│  • Upgrade suggestion / positive feedback / warning      │
│  • Progress updates (achievements, sub-skill changes)    │
└─────────────────────────────────────────────────────────┘
```

**Key files installed to `~/.claude/`:**

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Coaching rules injected into Claude's system prompt (merged with your existing rules) |
| `PROGRESS.md` | Your personal progress tracker — levels, sub-skills, achievements, milestones |
| `ai-engineering-leveling-guide.md` | The complete Level 1-8 reference guide (1200+ lines of techniques and exercises) |
| `commands/coach/*.md` | Slash commands (`/coach:assess`, `/coach:practice`, etc.) |

## 🎮 Commands Reference

### `/coach:assess` — Full Assessment

Performs a comprehensive evaluation of your AI engineering proficiency. Scans your CLAUDE.md configuration, custom commands, hooks, CI/CD setup, git conventions, and project structure. Outputs a scored report across 5 dimensions with specific improvement recommendations.

**When to use:** On first install, periodically to check progress, or when you feel you've leveled up.

### `/coach:practice` — Practice Session

Generates practice exercises tailored to your current level and weakest sub-skills. Offers 4 exercise modes:

| Mode | Focus | Example |
|------|-------|---------|
| 🏋️ Prompt Gym | Improve prompt quality | Rewrite a L3 prompt as L5 intent-driven |
| 🎯 Delegation Drill | Feature delegation | Delegate a full CRUD feature to AI |
| ⚡ Parallel Planning | Task decomposition | Split a feature into 3 parallel streams |
| 🔧 Automation Hunt | Workflow automation | Create a custom command for repeated tasks |

**When to use:** When you want targeted practice but aren't sure what to work on.

### `/coach:review-prompt <prompt>` — Prompt Review

Analyzes a prompt you provide, assesses its current level (L1-8), and generates an upgrade path showing how the same request could be expressed at progressively higher levels.

**When to use:** Before sending an important prompt, or to learn how to express requests more effectively.

### `/coach:progress-report` — Progress Report

Generates a structured progress report summarizing your level, sub-skill status, achievements, and recent milestones. Formatted for sharing with a team lead or manager.

**When to use:** When you need to report on your AI engineering skill growth.

### `/coach:uninstall` — Uninstall

Removes the coaching system from your machine. Optionally preserves your `PROGRESS.md` so you don't lose your progress data.

## 📊 The 8 Levels

The coaching system is built on a comprehensive [AI Engineering Skills Guide](coach/ai-engineering-leveling-guide.md) that defines 8 levels of AI-assisted development proficiency:

| Level | Name | What You Do | What AI Does | Key Skill |
|-------|------|-------------|--------------|-----------|
| **1** | Zero Contact | Write all code by hand | Nothing | — |
| **2** | Completion Reliance | Press Tab for autocomplete | Typing assistant | Trust building |
| **3** | Conversational | Ask questions, copy-paste answers | Search engine | Basic dialogue |
| **4** | Prompt Engineering | Write structured prompts with context | Junior engineer | CRATE framework |
| **5** | Intent-Driven | Describe *what* and *why*, not *how* | Mid-level engineer | Feature delegation |
| **6** | Multi-Agent Parallel | Run 3+ AI tasks simultaneously | Dev team | Worktree + parallelism |
| **7** | Workflow Orchestration | Design processes, AI executes them | Automation pipeline | Commands + Hooks |
| **8** | Automated System | Configure triggers, AI runs 24/7 | Infrastructure | CI/CD integration |

Each level has:
- ✅ **Acceptance criteria** — clear checklist to know when you've graduated
- 🧠 **Mindset shift** — the mental model change required
- 📝 **Step-by-step execution plan** — weekly practice routines
- 🏋️ **Hands-on exercises** — concrete practice tasks
- ⚠️ **Anti-patterns** — common mistakes to avoid
- 🔧 **Stuck? Diagnosis** — symptoms, root causes, and fixes

> 📖 [Read the full guide →](coach/ai-engineering-leveling-guide.md)

## 🏅 Achievements

The coach tracks 15 achievements that unlock automatically as you demonstrate new skills:

| Achievement | How to Unlock |
|-------------|---------------|
| 🎯 First Contact | Complete any assessment |
| 💬 Conversation Starter | 3+ substantive exchanges in one session |
| 🔍 Code Reviewer | Explicitly reject, modify, or critique AI code |
| 📋 Context Provider | Include file paths + error details + env info in a prompt |
| 📐 Plan Mode Adopter | Use Plan Mode for a complex task |
| ✨ One-Shot Wonder | AI output accepted without modification in one round |
| 🎤 Intent Speaker | Describe business intent without specifying implementation |
| 🏗️ Feature Delegator | Delegate a multi-module feature to AI |
| 👀 Architecture Critic | Review and critique an AI architecture proposal |
| ⚡ Parallel Pioneer | Manage parallel AI tasks |
| 🔀 Worktree Warrior | Use git worktree for parallel development |
| 🤖 Command Creator | Create a custom slash command |
| 🪝 Hook Master | Configure Hooks in Claude settings |
| 🔄 CI Integrator | Configure AI in CI/CD workflows |
| 📊 Cost Watcher | Check `/cost` or discuss API spend |

Achievements serve as evidence for sub-skill progression — when you unlock one, the coach may suggest updating the related sub-skill status.

## 🔄 Updating & Multi-device

### Update to Latest Version

```bash
cd ClaudeCode-AI-Coach
git pull
./scripts/install.sh   # or Windows: .\scripts\install.ps1
```

The install script updates configs and commands but **never overwrites your PROGRESS.md**.

### Using on Multiple Devices

Progress is maintained independently per machine. On a new device:

```bash
git clone https://github.com/anthropics/ClaudeCode-AI-Coach.git
cd ClaudeCode-AI-Coach && ./scripts/install.sh
```

Then run `/coach:assess` — it will quickly determine your level based on your current skills. No manual data migration needed.

## 🛠️ Customization

| What | How |
|------|-----|
| **Add commands** | Create `.md` files in `coach/commands/coach/`, then reinstall |
| **Modify coaching rules** | Edit `coach/CLAUDE.md`, then reinstall. Marker-block merging keeps your other `~/.claude/CLAUDE.md` rules intact |
| **Adjust progress template** | Edit `coach/PROGRESS.md` (only affects new installs — existing progress is preserved) |

## 📁 Project Structure

```
ClaudeCode-AI-Coach/
├── coach/                               ← Distributable source (installed to ~/.claude/)
│   ├── CLAUDE.md                        ← Coaching system rules & behavior
│   ├── PROGRESS.md                      ← Progress tracker template
│   ├── ai-engineering-leveling-guide.md ← Complete Level 1-8 guide (1200+ lines)
│   ├── achievement-triggers.md          ← Achievement definitions & unlock conditions
│   └── commands/coach/                  ← Slash commands
│       ├── assess.md                    ← /coach:assess
│       ├── practice.md                  ← /coach:practice
│       ├── progress-report.md           ← /coach:progress-report
│       ├── review-prompt.md             ← /coach:review-prompt
│       └── uninstall.md                 ← /coach:uninstall
├── scripts/
│   ├── install.sh / install.ps1         ← Install scripts (macOS/Linux/Windows)
│   └── uninstall.sh / uninstall.ps1     ← Uninstall scripts
├── .claude/commands/coach/
│   └── install.md                       ← /coach:install (project-scope only)
├── README.md                            ← This file
└── README.zh.md                         ← Chinese README
```

## ❓ FAQ

<details>
<summary><b>Does this slow down Claude Code?</b></summary>

No. The coaching system adds a few lines of feedback at the end of each response. It doesn't add extra API calls or processing steps — it's just additional instructions in Claude's system prompt.
</details>

<details>
<summary><b>Can I use this with my existing CLAUDE.md?</b></summary>

Yes. The install script uses HTML comment markers (`<!-- AI-COACH-START -->` / `<!-- AI-COACH-END -->`) to inject the coach config. Your existing rules outside these markers are untouched.
</details>

<details>
<summary><b>What if I want to temporarily disable coaching?</b></summary>

You can remove the coach block from `~/.claude/CLAUDE.md` (everything between the `AI-COACH-START` and `AI-COACH-END` markers). Reinstall when you want it back. Your progress is preserved in `PROGRESS.md`.
</details>

<details>
<summary><b>Does this work with projects in any programming language?</b></summary>

Yes. The coaching system is language-agnostic — it evaluates your *prompting patterns and AI usage habits*, not the specific code you write. Examples in the leveling guide use React/TypeScript, but all concepts apply to any tech stack.
</details>

<details>
<summary><b>How do I completely uninstall?</b></summary>

Run `/coach:uninstall` in Claude Code, or manually:

```bash
./scripts/uninstall.sh   # or Windows: .\scripts\uninstall.ps1
```

This removes the coach config block, commands, and guide. You'll be asked whether to keep your PROGRESS.md.
</details>

<details>
<summary><b>I'm stuck at my current level — what should I do?</b></summary>

Run `/coach:practice` to get exercises targeting your weakest sub-skills. The leveling guide also has a "Stuck? Diagnosis Checklist" section for each level with symptoms, root causes, and fixes.
</details>

## 🤝 Contributing

Contributions are welcome! Here's how to get involved:

1. **Edit** coach files in the `coach/` directory
2. **Install** locally with `./scripts/install.sh` to deploy to `~/.claude/`
3. **Test** by opening a different project and verifying the coaching experience
4. **Iterate** — changes in `coach/` don't take effect until reinstalled

> The root `CLAUDE.md` is for project development. The coaching rules live in `coach/CLAUDE.md`.

## 📄 License

Personal use.
