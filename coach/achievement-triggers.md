# Achievement Trigger Definitions

Achievements in PROGRESS.md unlock automatically when the coach detects matching behavior.

## Unlocking Rules
1. Change status from ⬜ to ✅ (no user confirmation needed)
2. Celebrate inline: `🏅 Achievement unlocked: [name]! [one sentence]`
3. Append in a clearly separated section after the main response (use `---` separator)

## Trigger Definitions

| Achievement | Trigger Condition | Related Sub-skill |
|-------------|-------------------|-------------------|
| 🎯 First Contact | Completes any assessment (quick or full) | — |
| 💬 Conversation Starter | 3+ substantive exchanges in one session | L1-2: Basic Dialogue |
| 🔍 Code Reviewer | Explicitly rejects, modifies, or critiques AI code | L1-2: AI Code Judgment |
| 📋 Context Provider | Prompt includes file paths + error details + env info | L3-4: Structured Prompts |
| 📐 Plan Mode Adopter | Uses Plan Mode or asks for plan before execution | L3-4: Plan Mode Usage |
| ✨ One-Shot Wonder | AI output accepted without modification in single round | L3-4: Structured Prompts |
| 🎤 Intent Speaker | Prompt describes business intent without specifying implementation | L5: Intent Description |
| 🏗️ Feature Delegator | Delegates a multi-module feature to AI | L5: Feature-Level Delegation |
| 👀 Architecture Critic | Reviews and provides architectural feedback on AI proposal | L5: Architecture Review |
| ⚡ Parallel Pioneer | Requests or manages parallel AI tasks | L6: Parallel Task ID |
| 🔀 Worktree Warrior | Uses git worktree for parallel development | L6: Git Worktree |
| 🤖 Command Creator | Creates or modifies a custom slash command | L7: Custom Commands |
| 🪝 Hook Master | Configures Hooks in Claude settings | L7: Hooks Automated QA |
| 🔄 CI Integrator | Configures AI in CI/CD workflows | L8: CI/CD PR Review |
| 📊 Cost Watcher | Checks `/cost` or discusses API spend | L8: Cost Monitoring |

## Achievement → Sub-skill Signal

When an achievement unlocks, consider it as objective evidence for the related sub-skill:
- If the sub-skill is 🔴 (Not Started), this is a signal it should be 🟡 (Practicing) — suggest the update to the user
- If the sub-skill is 🟡 (Practicing) and 3+ related achievements have been unlocked, this is a signal it may be ready for 🟢 (Verified) — suggest running `/coach:assess`
