Generate a structured progress report based on the user's AI engineering capability progress. This report should be professional, concise, and suitable for sharing with a team leader or manager.

## Generation Process

### Step 1: Collect Data
1. Read `PROGRESS.md` to get current progress and milestones
2. Review git log to understand recent commits and activity
3. If a `.github/workflows/` directory exists, check CI/CD configuration status

### Step 2: Generate Report

Format:

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

## Level 8 Sub-Skill Progress Overview

| Sub-Skill | Status | Completion |
|-----------|--------|------------|
| Headless Mode Scripting | [status] | [progress bar] |
| PR Auto-Review | [status] | [progress bar] |
| CI Auto-Fix | [status] | [progress bar] |
| Issue Auto-Triage | [status] | [progress bar] |
| Cost Monitoring | [status] | [progress bar] |

## Blockers

- [If any, list current blockers and support needed]

## Next Steps

- [List the next 1-3 action items]
```

### Step 3: Review and Output

After generating the report, ask the user if they'd like to adjust the wording or add supplementary content, then output the final version.
