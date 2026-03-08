# PROGRESS.md — AI Engineering Skills Progress Tracker

## Overall Assessment

- **Current Level**: 5
- **Target Level**: 6
- **Assessment Date**: 2026-03-08

## Level 1-2 Sub-skills Status (AI-Assisted Programming Basics)

| # | Sub-skill | Status | Acceptance Criteria |
|---|-----------|--------|-------------------|
| 1 | AI Code Completion Habits | 🟢 Verified | Naturally uses AI completion in daily development |
| 2 | Claude Code Basic Dialogue | 🟢 Verified | 3+ effective conversations per day |
| 3 | AI Code Judgment | 🟡 Practicing | Has a habit of accepting/modifying/rejecting each piece of AI-generated code |

Graduation Test: Use AI assistance to complete 3 small component features (form + list + detail view), with AI contributing 20%+ of the code, and be able to explain every line.

## Level 3-4 Sub-skills Status (Prompt Engineering + Context Management)

| # | Sub-skill | Status | Acceptance Criteria |
|---|-----------|--------|-------------------|
| 1 | Claude Code Core Functions | 🟢 Verified | Proficient with /init, /plan, /compact, /cost |
| 2 | Plan Mode Usage | 🔴 Not Started | 100% use of Plan Mode for complex tasks (3+ files) |
| 3 | Structured Prompts (CRATE) | 🟢 Verified | Average 1-3 prompt rounds to get satisfactory results |
| 4 | CLAUDE.md Configuration & Maintenance | 🟢 Verified | Includes tech stack, conventions, directory structure; kept up to date |

Graduation Test: Complete a data table with filtering + sorting + pagination, using Plan Mode, within 1-3 prompt rounds, with manual modifications < 20%.

## Level 5 Sub-skills Status (Intent-Driven Development)

| # | Sub-skill | Status | Acceptance Criteria |
|---|-----------|--------|-------------------|
| 1 | Intent Description (Why/What, not How) | 🟢 Verified | >70% of recent 10 prompts use What/Why framing |
| 2 | Feature-Level Delegation | 🟡 Practicing | Completed 3+ full feature delegations (frontend + API + tests) |
| 3 | Architecture Review Ability | 🟡 Practicing | AI solutions pass review on first attempt >80% of the time |
| 4 | Task Decomposition & Dependency Analysis | 🔴 Not Started | Can break complex features into 3+ sub-tasks and map dependencies |

Graduation Test: Complete a full feature (frontend + API + database), fully intent-driven without specifying implementation, AI solution passes review on first attempt, total time 2x+ faster than manual.

## Level 6 Sub-skills Status (Multi-Agent Parallelism)

| # | Sub-skill | Status | Acceptance Criteria |
|---|-----------|--------|-------------------|
| 1 | Parallel Task Identification | 🔴 Not Started | Can correctly distinguish parallelizable vs sequential tasks |
| 2 | Git Worktree Isolation | 🔴 Not Started | Proficient with worktree for managing parallel branches |
| 3 | Interface Contracts First | 🔴 Not Started | Defines interfaces before parallel development begins |
| 4 | Multi-Agent Management (3+) | 🔴 Not Started | Stably manages 3+ concurrent agents, task throughput 2x+ |

Graduation Test: 3 agents simultaneously complete different parts of a feature (API + component + tests), total time 2x+ faster than serial, all tests pass after merge.

## Level 7 Graduation Test

- **Status**: ❌ Not Passed
- **Test Content**: A fresh Claude instance independently completes a CRUD page using only CLAUDE.md + Custom Commands
- **Notes**: Must pass this test before starting Level 8 CI/CD configuration

## Level 7 Sub-skills Status

| # | Sub-skill | Status | Acceptance Criteria |
|---|-----------|--------|-------------------|
| 1 | CLAUDE.md Workflow Rules | 🟢 Verified | Includes file creation rules, Git conventions, testing rules |
| 2 | Custom Slash Commands | 🟢 Verified | 5+ Commands covering daily scenarios |
| 3 | Hooks Automated QA | 🔴 Not Started | Auto type-checking configured after writing files |

Status Legend: 🔴 Not Started / 🟡 Practicing / 🟢 Verified

## Level 8 Sub-skills Status

| # | Sub-skill | Status | Acceptance Criteria |
|---|-----------|--------|-------------------|
| 1 | Headless Mode Scripting | 🔴 Not Started | Can batch-generate test files with `claude -p` |
| 2 | CI/CD PR Auto Review | 🔴 Not Started | GitHub Action running for 2 weeks, 100% coverage |
| 3 | CI Failure Auto-fix Pipeline | 🔴 Not Started | Running for 2 weeks, success rate >30% |
| 4 | Issue Auto-triage System | 🔴 Not Started | At least 10 issues auto-classified |
| 5 | Cost Monitoring & Metrics | 🔴 Not Started | API spend trackable, cost alerts configured |

Status Legend: 🔴 Not Started / 🟡 Practicing / 🟢 Verified

## Current Focus

- **Focus Sub-skill**: Hooks Automated QA
- **Reason**: Next frontier for Level 6-7 advancement; you have Commands but no Hooks yet
- **Next Step**: Configure a Hook in .claude/settings.json to auto-run type-checking after file writes

## Achievements 🏅

Small wins on your journey. These unlock automatically as the coach detects matching behavior.

| Achievement | Description | Status |
|-------------|-------------|--------|
| 🎯 First Contact | Completed initial assessment | ✅ |
| 💬 Conversation Starter | Had 3+ effective AI conversations in one day | ⬜ |
| 🔍 Code Reviewer | Rejected or modified AI code with clear reasoning | ⬜ |
| 📋 Context Provider | Included file paths, error messages, and env info in a prompt | ⬜ |
| 📐 Plan Mode Adopter | Used Plan Mode for a multi-file task | ⬜ |
| ✨ One-Shot Wonder | Got satisfactory AI output in a single prompt round | ⬜ |
| 🎤 Intent Speaker | Described What/Why without specifying How | ⬜ |
| 🏗️ Feature Delegator | Delegated a complete feature (frontend + API + tests) to AI | ⬜ |
| 👀 Architecture Critic | Reviewed and improved an AI-proposed architecture | ⬜ |
| ⚡ Parallel Pioneer | Successfully ran 2+ AI tasks in parallel | ⬜ |
| 🔀 Worktree Warrior | Used git worktree for isolated parallel development | ⬜ |
| 🤖 Command Creator | Created a custom slash command | ⬜ |
| 🪝 Hook Master | Configured an automated Hook | ⬜ |
| 🔄 CI Integrator | Integrated AI into a CI/CD pipeline | ⬜ |
| 📊 Cost Watcher | Checked and discussed API costs | ⬜ |

Status: ⬜ Locked / ✅ Unlocked

## Milestone Log

| Date | Milestone | Notes |
|------|-----------|-------|
| 2026-03-08 | Initial Assessment Completed | Level 5 (Intent-Driven), Target Level 6 |

<!-- 
Update Guide:
- Run /coach:assess on first use for assessment, the system will auto-fill the fields above
- After completing a sub-skill verification, change status from 🔴/🟡 to 🟢
- After starting practice on a sub-skill, change status from 🔴 to 🟡
- Update "Overall Assessment" and "Assessment Date" after each assessment
- Add entries to "Milestone Log" when important milestones are reached
- Update Level 7 Graduation Test status after passing
- When switching devices, no sync needed — just run /coach:assess again
-->
