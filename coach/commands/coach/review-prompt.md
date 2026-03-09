Analyze a prompt provided by the user, assess its AI engineering operation level, and provide upgrade recommendations.

The user should provide a prompt they use in their daily workflow: $ARGUMENTS

## Analysis Process

### Step 1: Identify Prompt Level

Classify the prompt using the Level Detection Rules from CLAUDE.md (L1-2: no context/vague; L3-4: specifies How with structured context; L5: describes Why/What with business intent; L6: task decomposition/parallelism; L7: Custom Commands/workflows; L8: CI/CD/automation triggers).

### Step 2: Quantitative Analysis

Analyze: How vs. Why/What ratio · technical details vs. business context · presence of acceptance criteria · constraints and boundary conditions.

### Step 3: Generate Upgraded Version

Rewrite the prompt at a higher Level, showing a step-by-step upgrade path:

```
## Prompt Analysis Results

**Original Prompt**: > [user's prompt]
**Detected Level**: Level N
**How/What Ratio**: X% How / Y% What

### Diagnosis
- [Specific areas for improvement]

### Upgrade Path
**Current (Level N):** > [original]
**→ Level N+1:** > [rewritten] — Key improvement: [one sentence]
**→ Level N+2 (outlook):** > [higher-level example] — Key improvement: [one sentence]
```

Refer to the "Transformation Rules by Level Transition" table in CLAUDE.md for the upgrade direction at each level transition.

### Step 4: Practice Recommendation

Suggest the user try the higher-level expression in their next 5 AI interactions and track result differences.
