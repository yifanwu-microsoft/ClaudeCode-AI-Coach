Generate a visual ASCII dashboard that gives the user an instant snapshot of their AI engineering growth journey.

## Generation Process

### Step 1: Read & Parse PROGRESS.md

Read `~/.claude/PROGRESS.md` and extract:

1. **Overall Assessment**: Current Level, Target Level, Assessment Date
2. **All sub-skill tables** (L1-2 through L8): For each sub-skill row, extract the name and status emoji (🔴 / 🟡 / 🟢)
3. **Level 7 Graduation Test** status (❌ / ✅)
4. **Achievements section**: Count ✅ (unlocked) vs ⬜ (locked). List the achievement names that are ✅.
5. **Milestone Log**: Count entries, note the earliest and latest dates
6. **Current Focus**: Focus sub-skill, reason, next step

If PROGRESS.md shows "Pending Assessment", output a short message suggesting `/coach:assess` and stop.

### Step 2: Calculate Metrics

For each level band, compute:
- `completed` = count of 🟢 sub-skills
- `in_progress` = count of 🟡 sub-skills
- `not_started` = count of 🔴 sub-skills
- `total` = completed + in_progress + not_started
- `fill_ratio` = (completed + in_progress × 0.5) / total

Determine level band status:
- ✅ **Graduated** — all sub-skills 🟢
- 🔵 **Active** — at least one 🟡 or 🟢, not all 🟢
- ⬜ **Locked** — all 🔴

Overall journey progress (0–100%):
- Assign each level band a weight: L1-2 = 1, L3-4 = 1, L5 = 1.5, L6 = 1.5, L7 = 2, L8 = 2
- `overall_pct` = weighted sum of each band's fill_ratio × weight / total_weight × 100

Days at current level:
- If Assessment Date is available, compute days since then. Otherwise show "—".

### Step 3: Render Dashboard

Use **exactly** this layout. Replace placeholders `{...}` with computed values. For progress bars, use `█` for filled and `░` for empty, scaled to the specified width.

Progress bar rendering rules:
- For sub-skill bars (per-level): width = 12 chars. `filled = round(fill_ratio × 12)`. Remainder = `░`.
- For overall level bar: width = 30 chars.
- For achievement bar: width = 15 chars.
- For current-level detail bars: width = 18 chars. 🟢 = full, 🟡 = half (9 █ + 9 ░), 🔴 = empty.

```
╔══════════════════════════════════════════════════════════╗
║            📊  AI Engineering — Stats Dashboard          ║
╚══════════════════════════════════════════════════════════╝

🎯 Level Progress

   L{current} {current_name}  ──▶  L{target} {target_name}
   [{bar 30 chars}] {overall_pct}%

   Assessed: {date} ({days_ago} days ago)

📈 Sub-skill Breakdown
                                     Progress      Status
   L1-2 Basics      [{bar}] {n}/{t}  {pct}%  {status}
   L3-4 Prompts     [{bar}] {n}/{t}  {pct}%  {status}
   L5   Intent      [{bar}] {n}/{t}  {pct}%  {status}
   L6   Parallel    [{bar}] {n}/{t}  {pct}%  {status}
   L7   Workflow    [{bar}] {n}/{t}  {pct}%  {status}
   L8   Automation  [{bar}] {n}/{t}  {pct}%  {status}

🔬 Current Level Detail: L{current} {current_name}

   {sub-skill 1 name}     {emoji} {bar 18 chars} {label}
   {sub-skill 2 name}     {emoji} {bar 18 chars} {label}
   ...

🎯 Next Up: L{target} {target_name}

   {target sub-skill 1}   {emoji} {bar 18 chars} {label}
   {target sub-skill 2}   {emoji} {bar 18 chars} {label}
   ...

🏅 Achievements: {unlocked} / {total}
   [{bar 15 chars}] {pct}%
   {if any unlocked: "Latest: {most_recent_achievement}"}
   {if none: "Run /coach:assess to start unlocking!"}

📅 Journey
   Assessed:     {date}
   Days at L{n}: {days}
   Milestones:   {count} recorded
   {if milestone dates: "First: {earliest}  Latest: {latest}"}

💡 Insight
   {actionable recommendation — see rules below}
```

### Step 4: Generate Insight

Choose ONE insight based on priority:

1. **Graduation proximity**: If current level has only 1 sub-skill not 🟢, say: `"1 sub-skill to graduate L{n}! Focus on: {sub-skill name}"`
2. **Stale assessment**: If assessed > 30 days ago, say: `"Last assessed {N} days ago — run /coach:assess to recalibrate"`
3. **Quick win**: If target level has any 🟡 sub-skill, say: `"Keep practicing: {sub-skill name} is almost there"`
4. **Encouragement**: If 3+ achievements unlocked, say: `"Great momentum — {N} achievements unlocked! Push for the next level."`
5. **Getting started**: Default: `"Focus on one sub-skill at a time. Try /coach:practice for guided exercises."`

### Formatting Rules

- Output as a **single fenced code block** (` ```text ... ``` `) so it renders with monospace alignment
- Align columns using spaces — all bars and numbers should line up vertically
- Level names: L1-2 = "Basics", L3-4 = "Prompts", L5 = "Intent", L6 = "Parallel", L7 = "Workflow", L8 = "Automation"
- Keep the entire dashboard under 40 lines — compact but complete
- Use the user's language (detect from their previous messages) for the Insight section only; all labels and structure stay in English for consistent alignment
