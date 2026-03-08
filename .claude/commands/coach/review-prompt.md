Analyze a prompt provided by the user, assess its AI engineering operation level, and provide upgrade recommendations.

The user should provide a prompt they use in their daily workflow: $ARGUMENTS

## Analysis Process

### Step 1: Identify Prompt Level

Use the Level Detection Rules from CLAUDE.md to classify the prompt (Level 1-2 through Level 8). Key signals:
- **L1-2**: No context, vague, copy-pasted errors
- **L3-4**: Specifies How (concrete tech/implementation), provides structured context
- **L5**: Describes Why/What (business intent, constraints), no implementation details
- **L6**: Task decomposition, parallelism, interface contracts
- **L7**: Custom Commands, workflow definitions, systematic processes
- **L8**: Event triggers, CI/CD integration, monitoring, unattended operation

### Step 2: Quantitative Analysis

Analyze the prompt for:
- How statements vs. Why/What statements ratio
- Technical details vs. business context ratio
- Whether it includes acceptance criteria
- Whether it includes constraints and boundary conditions

### Step 3: Generate Upgraded Version

Rewrite the user's prompt at a higher Level, showing a step-by-step upgrade path:

```
## Prompt Analysis Results

**Original Prompt**:
> [user's original prompt]

**Detected Level**: Level N
**How/What Ratio**: X% How / Y% What

### Diagnosis
- [Point out specific parts that can be improved]

### Step-by-Step Upgrade Path

**Current (Level N):**
> [user's original prompt]

**Upgrade to Level N+1:**
> [rewritten prompt at the next level]
> Key improvement: [one sentence explaining what changed]

**Further upgrade to Level N+2 (outlook):**
> [prompt example at an even higher level]
> Key improvement: [one sentence explaining the further improvement]
```

Refer to the Prompt Upgrade Examples table in CLAUDE.md for the upgrade direction at each level transition.

### Step 4: Provide Practice Recommendations

Suggest that the user try using the higher-level expression style in their next 5 AI interactions and track the differences in results.
