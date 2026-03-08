Generate a structured progress report based on the user's AI engineering capability progress. This report should be professional, concise, and suitable for sharing with a team leader or manager.

## Generation Process

### Step 1: Collect Data
1. Read `PROGRESS.md` to get current progress and milestones
2. Review git log to understand recent commits and activity
3. If a `.github/workflows/` directory exists, check CI/CD configuration status

### Step 2: Generate a Report Matching the User's Level

Use the base template below. Add level-specific sections based on the user's current Level.

```markdown
# AI Engineering Capability Progress Report

**Author**: [username]
**Report Date**: [today's date]
**Current Level**: [from PROGRESS.md]
**Target Level**: [from PROGRESS.md]

## Completed This Period

- [List completed milestones and sub-skills]

## Currently In Progress

- **Focused Sub-Skill**: [from PROGRESS.md]
- **Progress Summary**: [from git activity and file changes]

## Blockers

- [If any, list current blockers and support needed]

## Next Steps

- [1-3 action items]
```

**Level-specific additions:**

- **Level 1-4**: Use simpler headings ("What I Learned" / "What I'm Learning" / "Difficulties"). Omit metrics.
- **Level 5-6**: Add an "Efficiency Metrics" section with: AI delegation success rate, average prompt rounds, parallel task count.
- **Level 7-8**: Add "Automation Infrastructure Status" table (CLAUDE.md rules, Commands, Hooks) and "Automation Runtime Metrics" table (PR review coverage, auto-fix success rate, AI API weekly cost, issue triage accuracy — each with trend arrows ↑/↓/→).

### Step 3: Review and Output

After generating the report, ask the user if they'd like to adjust the wording or add supplementary content, then output the final version.
