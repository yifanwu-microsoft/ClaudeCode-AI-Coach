Generate a structured progress report based on the user's AI engineering capability progress. This report should be professional, concise, and suitable for sharing with a team leader or manager.

## Generation Process

### Step 1: Collect Data
1. Read `PROGRESS.md` for current progress and milestones
2. Review recent git log for activity context
3. Check `.github/workflows/` for CI/CD configuration status (if exists)

### Step 2: Generate Report

Use this template, adding level-specific sections based on the user's current Level:

```markdown
# AI Engineering Capability Progress Report

**Author**: [username] | **Date**: [today] | **Level**: [current] → [target]

## Completed This Period
- [Completed milestones and sub-skills]

## Currently In Progress
- **Current Level Sub-Skills**: [summary of 🔴/🟡/🟢 status]
- **Progress Summary**: [from git activity and file changes]

## Blockers
- [Current blockers and support needed, if any]

## Next Steps
- [1-3 action items]
```

**Level-specific additions:**
- **L1-4**: Simpler headings ("What I Learned" / "Difficulties"). Omit metrics.
- **L5-6**: Add "Efficiency Metrics" (AI delegation success rate, average prompt rounds, parallel task count).
- **L7-8**: Add "Automation Infrastructure Status" table and "Runtime Metrics" table (PR review coverage, auto-fix success rate, weekly API cost, issue triage accuracy — with trend arrows ↑/↓/→).

### Step 3: Review and Output
Ask the user if they'd like to adjust wording or add content, then output the final version.
