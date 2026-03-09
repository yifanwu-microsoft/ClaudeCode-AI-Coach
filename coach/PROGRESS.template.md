# PROGRESS.template.md — AI Engineering Skills Progress Tracker (Template)

## Overall Assessment

- **Current Level**: Pending Assessment
- **Target Level**: —
- **Assessment Date**: —

## Level 1-2 Sub-skills Status (AI-Assisted Programming Basics)

| # | Sub-skill | Status | Acceptance Criteria |
|---|-----------|--------|-------------------|
| 1 | AI Code Completion Habits | 🔴 Not Started | Naturally uses AI completion in daily development |
| 2 | Claude Code Basic Dialogue | 🔴 Not Started | 3+ effective conversations per day |
| 3 | AI Code Judgment | 🔴 Not Started | Has a habit of accepting/modifying/rejecting each piece of AI-generated code |

Graduation Test: Use AI assistance to complete 3 small component features (form + list + detail view), with AI contributing 20%+ of the code, and be able to explain every line.

## Level 3-4 Sub-skills Status (Prompt Engineering + Context Management)

| # | Sub-skill | Status | Acceptance Criteria |
|---|-----------|--------|-------------------|
| 1 | Claude Code Core Functions | 🔴 Not Started | Proficient with /init, /plan, /compact, /cost |
| 2 | Plan Mode Usage | 🔴 Not Started | 100% use of Plan Mode for complex tasks (3+ files) |
| 3 | Structured Prompts (CRATE) | 🔴 Not Started | Average 1-3 prompt rounds to get satisfactory results |
| 4 | CLAUDE.md Configuration & Maintenance | 🔴 Not Started | Includes tech stack, conventions, directory structure; kept up to date |

Graduation Test: Complete a data table with filtering + sorting + pagination, using Plan Mode, within 1-3 prompt rounds, with manual modifications < 20%.

## Level 5 Sub-skills Status (Intent-Driven Development)

| # | Sub-skill | Status | Acceptance Criteria |
|---|-----------|--------|-------------------|
| 1 | Intent Description (Why/What, not How) | 🔴 Not Started | >70% of recent 10 prompts use What/Why framing |
| 2 | Feature-Level Delegation | 🔴 Not Started | Completed 3+ full feature delegations (frontend + API + tests) |
| 3 | Architecture Review Ability | 🔴 Not Started | AI solutions pass review on first attempt >80% of the time |
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
| 1 | CLAUDE.md Workflow Rules | 🔴 Not Started | Includes file creation rules, Git conventions, testing rules |
| 2 | Custom Slash Commands | 🔴 Not Started | 5+ Commands covering daily scenarios |
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

- **Focus Sub-skill**: Pending Assessment
- **Reason**: —
- **Next Step**: —

## Achievements 🏅

Small wins on your journey. These unlock automatically as the coach detects matching behavior.

**Achievement definitions and trigger conditions** → see `achievement-triggers.md`

Status: ⬜ Locked / ✅ Unlocked

## Milestone Log

| Date | Milestone | Notes |
|------|-----------|-------|

<!-- 
Update Guide:
- After first install, /coach:install will auto-run the assessment and fill the fields above
- After completing a sub-skill verification, change status from 🔴/🟡 to 🟢
- After starting practice on a sub-skill, change status from 🔴 to 🟡
- Update "Overall Assessment" and "Assessment Date" after each assessment
- Add entries to "Milestone Log" when important milestones are reached
- Update Level 7 Graduation Test status after passing
- When switching devices, no sync needed — just run /coach:install again
-->
