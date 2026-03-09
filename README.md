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
git clone https://github.com/yifanwu-microsoft/ClaudeCode-AI-Coach.git
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

If you used `/coach:install`, the initial assessment starts **automatically** right after installation — no need to exit or switch projects. Claude will ask 3 quick questions to calibrate your Level.

If you installed manually via the shell script, open Claude Code in any project and the coach will detect first-time setup and start the assessment automatically. You can also run:

```
/coach:assess
```

for a deeper project-specific assessment at any time.

**That's it!** From now on, every Claude Code interaction includes coaching feedback automatically.

## 🔬 How It Works

The coach uses a **four-tier architecture** to guarantee coaching always happens — even if the LLM skips its instructions:

```
┌──────────────────────────────────────────────────────────┐
│  Tier 1: LLM Inline Coaching                             │
│  CLAUDE.md instructions → richest feedback, not guaranteed│
├──────────────────────────────────────────────────────────┤
│  Tier 2: Dedicated LLM Coaching Call (Hook-triggered)    │
│  Stop hook → claude -p → focused coaching, guaranteed     │
├──────────────────────────────────────────────────────────┤
│  Tier 3: Context-Aware Rules Engine (no LLM needed)      │
│  Signal scan + activity analysis + tech-stack tips        │
├──────────────────────────────────────────────────────────┤
│  Tier 4: Static Tip Fallback (always works)              │
│  Pre-written tips by level, zero dependencies             │
└──────────────────────────────────────────────────────────┘
```

**How the tiers cascade:**
1. Claude Code completes your request with inline coaching (Tier 1 — best case)
2. A `Stop` hook fires automatically after every interaction
3. The hook tries a dedicated `claude -p` coaching call (Tier 2 — high quality, guaranteed trigger)
4. If that fails, the rules engine selects a context-aware tip (Tier 3 — no LLM needed)
5. If that fails too, a static tip for your level is shown (Tier 4 — always works)

> **Result:** Coaching is delivered every time, with quality adapting to what's available.

### What do Levels mean?

| Level | What You Do | What AI Does |
|-------|-------------|--------------|
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

**Key files installed to `~/.claude/`:**

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Coaching rules injected into Claude's system prompt (merged with your existing rules) |
| `PROGRESS.md` | Your personal progress tracker — levels, sub-skills, achievements, milestones |
| `ai-engineering-leveling-guide.md` | The complete Level 1-8 reference guide (1200+ lines of techniques and exercises) |
| `commands/coach/*.md` | Slash commands (`/coach:assess`, `/coach:practice`, etc.) |
| `coach-engine/` | Deterministic coaching engine (signal scanner, tips database, progress tracker) |
| `coach-engine/hooks/` | Stop hook for guaranteed post-interaction coaching |
| `settings.json` | Claude Code hooks configuration (auto-merged with your existing settings) |

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

### `/coach:stats` — Stats Dashboard

Generates a visual ASCII dashboard showing an instant snapshot of your AI engineering growth journey. Displays level progress, sub-skill breakdown by level band, achievement progress, and actionable insights.

**When to use:** When you want a quick visual overview of your progress without reading the full PROGRESS.md.

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
git clone https://github.com/yifanwu-microsoft/ClaudeCode-AI-Coach.git
cd ClaudeCode-AI-Coach && ./scripts/install.sh
```

Then run `/coach:assess` — it will quickly determine your level based on your current skills. No manual data migration needed.

## 🛠️ Standalone Coach CLI

The coaching engine also works as a standalone CLI tool — no Claude Code session required:

```bash
# Quick project assessment (scans for objective signals)
~/.claude/coach-engine/coach-cli.sh assess

# Get a coaching tip for your current level
~/.claude/coach-engine/coach-cli.sh tip

# Check progress and suggested updates
~/.claude/coach-engine/coach-cli.sh progress

# Get practice suggestions
~/.claude/coach-engine/coach-cli.sh practice
```

### Coach Mode Configuration

Control how coaching is delivered via `~/.claude/coach-engine/config.json`:

| Mode | Behavior |
|------|----------|
| `"auto"` (default) | Try Tier 2 (LLM) → Tier 3 (rules) → Tier 4 (static) |
| `"llm-only"` | Only use dedicated LLM coaching call, skip rules engine |
| `"rules-only"` | Only use deterministic rules engine, no LLM calls |
| `"off"` | Disable hook-based coaching entirely |

## 🎨 Customization

| What | How |
|------|-----|
| **Add commands** | Create `.md` files in `coach/templates/commands/coach/`, then reinstall |
| **Modify coaching rules** | Edit `coach/CLAUDE.md`, then reinstall. Marker-block merging keeps your other `~/.claude/CLAUDE.md` rules intact |
| **Adjust progress template** | Edit `coach/PROGRESS.template.md` (only affects new installs — existing progress is preserved) |
| **Add/edit coaching tips** | Edit JSON files in `coach/engine/tips/`, then reinstall |
| **Customize coach mode** | Edit `~/.claude/coach-engine/config.json` directly (no reinstall needed) |

## 📁 Project Structure

```
ClaudeCode-AI-Coach/
├── coach/                               ← Distributable source (installed to ~/.claude/)
│   ├── CLAUDE.md                        ← Coaching system rules & behavior (~80 lines, focused)
│   ├── PROGRESS.template.md              ← Progress tracker template
│   ├── ai-engineering-leveling-guide.md ← Complete Level 1-8 guide (1200+ lines)
│   ├── achievement-triggers.md          ← Achievement definitions & unlock conditions
│   ├── templates/commands/coach/        ← Slash commands (hidden until install)
│   │   ├── assess.md                    ← /coach:assess
│   │   ├── practice.md                  ← /coach:practice
│   │   ├── progress-report.md           ← /coach:progress-report
│   │   ├── review-prompt.md             ← /coach:review-prompt
│   │   ├── stats.md                     ← /coach:stats
│   │   └── uninstall.md                 ← /coach:uninstall
│   ├── engine/                          ← Deterministic coaching engine (no LLM needed)
│   │   ├── coach-cli.sh                 ← Standalone CLI: tip / progress / practice
│   │   ├── tips.sh                      ← Context-aware tip selector
│   │   ├── progress.sh                  ← PROGRESS.md auto-updater
│   │   ├── tier2-prompt.md              ← Dedicated LLM coaching prompt template
│   │   ├── lib/                         ← Shared utilities
│   │   └── tips/                        ← Curated tips database (JSON, per level)
│   └── hooks/                           ← Claude Code hooks
│       ├── on-stop.sh                   ← Post-interaction coaching (4-tier fallback)
│       └── settings.template.json       ← Hook configuration template
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

Minimal impact. Tier 1 (inline coaching) adds a few lines to responses. Tier 2 (Stop hook) runs a quick coaching call after each interaction (~2s). You can set `coach_mode` to `"rules-only"` for near-zero overhead.
</details>

<details>
<summary><b>Does coaching require an API key or internet access?</b></summary>

No. Tier 3 (rules engine) and Tier 4 (static tips) work completely offline with no LLM. Tier 2 uses `claude -p` which requires an active Claude Code session. If it's unavailable, the engine falls back automatically.
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
