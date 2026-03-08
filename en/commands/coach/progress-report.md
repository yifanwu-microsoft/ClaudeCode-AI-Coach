Generate a structured progress report based on the user's AI engineering capability progress. This report should be professional, concise, and suitable for sharing with a team leader or manager.

## Generation Process

### Step 1: Collect Data
1. Read `PROGRESS.md` to get current progress and milestones
2. Review git log to understand recent commits and activity
3. If a `.github/workflows/` directory exists, check CI/CD configuration status

### Step 2: Generate a Report Matching the User's Level

Choose the appropriate report template based on the user's current Level:

---

**Level 1-4 Users: Simplified Report (Focused on Learning Growth)**

```markdown
# AI Engineering Learning Progress

**Author**: [username]
**Report Date**: [today's date]
**Current Level**: [read from PROGRESS.md]
**Target Level**: [read from PROGRESS.md]

## What I Learned This Period

- [List acquired skills and completed milestones in plain language]

## What I'm Currently Learning

- **Focused Sub-Skill**: [read from PROGRESS.md]
- **Learning Progress**: [summarize based on git activity and file changes]

## Difficulties Encountered

- [If any, list confusions and obstacles during learning]

## Next Steps

- [List the next 1-3 things to learn/practice]
```

---

**Level 5-6 Users: Standard Report (With Efficiency Metrics)**

```markdown
# AI Engineering Capability Progress Report

**Author**: [username]
**Report Date**: [today's date]
**Current Level**: [read from PROGRESS.md]
**Target Level**: [read from PROGRESS.md]

## Completed This Period

- [List completed milestones and sub-skills]

## Currently In Progress

- **Focused Sub-Skill**: [read from PROGRESS.md]
- **Progress Summary**: [summarize based on git activity and file changes]
- **Estimated Completion**: [estimate based on progress]

## Efficiency Metrics

| Metric | Value | Description |
|--------|-------|-------------|
| AI Delegation Success Rate | [estimated from actual usage] | Percentage of features delegated that passed on first attempt |
| Average Prompt Rounds | [estimated from interaction history] | Average conversation rounds to complete a task |
| Parallel Task Count | [from git branches/worktrees] | Number of independent tasks in progress simultaneously |

## Blockers

- [If any, list current blockers and support needed]

## Next Steps

- [List the next 1-3 action items]
```

---

**Level 7-8 Users: Full Report (With Automation Metrics)**

```markdown
# AI Engineering Capability Progress Report

**Author**: [username]
**Report Date**: [today's date]
**Current Level**: [read from PROGRESS.md]
**Target Level**: 8 (Automated Orchestration Systems)

## Completed This Period

- [List completed milestones and sub-skills]

## Currently In Progress

- **Focused Sub-Skill**: [read from PROGRESS.md]
- **Progress Summary**: [summarize based on git activity and file changes]
- **Estimated Completion**: [estimate based on progress]

## Automation Infrastructure Status

| Component | Status | Notes |
|-----------|--------|-------|
| CLAUDE.md Workflow Rules | [status] | [rule count and coverage] |
| Custom Commands | [status] | [command count and usage frequency] |
| Hooks Auto-QA | [status] | [hook count and interception rate] |

## Level 8 Sub-Skill Progress Overview

| Sub-Skill | Status | Completion |
|-----------|--------|------------|
| Headless Mode Scripting | [status] | [progress bar] |
| PR Auto-Review | [status] | [progress bar] |
| CI Auto-Fix | [status] | [progress bar] |
| Issue Auto-Triage | [status] | [progress bar] |
| Cost Monitoring | [status] | [progress bar] |

## Automation Runtime Metrics (Level 8)

| Metric | This Period | Trend |
|--------|-------------|-------|
| PR Review Coverage | [percentage] | [↑/↓/→] |
| Auto-Fix Success Rate | [percentage] | [↑/↓/→] |
| AI API Weekly Cost | [amount] | [↑/↓/→] |
| Issue Triage Accuracy | [percentage] | [↑/↓/→] |

## Blockers

- [If any, list current blockers and support needed]

## Next Steps

- [List the next 1-3 action items]
```

### Step 3: Review and Output

After generating the report, ask the user if they'd like to adjust the wording or add supplementary content, then output the final version.
