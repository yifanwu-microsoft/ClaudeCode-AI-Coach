Analyze a prompt provided by the user, assess its AI engineering operation level, and provide upgrade recommendations.

The user should provide a prompt they use in their daily workflow: $ARGUMENTS

## Analysis Process

### Step 1: Identify Prompt Level

Classify according to the following criteria:

**Level 1-2 Characteristics (Basic Q&A)**
- Simple questions without context ("How do I use this?", "This is broken")
- Copy-pasting error messages without providing related files or environment info
- Vague one-liner requests ("Write me a function", "Fix this bug")
- No project background, file locations, or expected behavior

**Level 3-4 Characteristics (Prompt Engineering)**
- Specifies concrete technical implementation (e.g., "use useState", "add a useEffect", "write a for loop")
- Tells the AI exactly how to do each step
- Provides context and reference files, but lacks business context and constraints
- How > Why/What

**Level 5 Characteristics (Intent-Driven)**
- Describes the business scenario and user needs
- Provides constraints without specifying implementation
- Why/What > How
- Includes performance requirements, data scale, and other context

**Level 6 Characteristics (Multi-Agent Parallel)**
- Task decomposition and interface contract definitions
- Parallelism analysis
- Cross-agent context synchronization

**Level 7 Characteristics (Workflow Orchestration)**
- Uses Custom Command templates
- Defines workflow steps and checkpoints
- Systematic quality review process

**Level 8 Characteristics (Automated Systems)**
- Event trigger design
- CI/CD integration configuration
- Monitoring and cost controls
- Unattended operation

### Step 2: Quantitative Analysis

Analyze the prompt for:
- Number of How statements vs. Why/What statements
- Ratio of technical details vs. business context
- Whether it includes acceptance criteria
- Whether it includes constraints and boundary conditions

### Step 3: Generate Upgraded Version

Rewrite the user's prompt at a higher Level, showing the comparison. Based on the detected Level, show a **step-by-step upgrade path**:

```
## Prompt Analysis Results

**Original Prompt**:
> [user's original prompt]

**Detected Level**: Level N
**How/What Ratio**: X% How / Y% What

### Diagnosis
- [Point out specific parts of the prompt that can be improved]

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

**Upgrade examples by Level:**

| Original Level | Upgrade Direction | Example |
|---------------|------------------|---------|
| Level 1-2 → 3-4 | Add context and references | "This is broken" → "This code throws error Y when calling X, related files are in src/service/" |
| Level 3-4 → 5 | Replace implementation with intent | "Use library X for caching" → "This API response is slow (>2s), needs to be under 200ms" |
| Level 5 → 6 | Identify parallelism opportunities | "Implement modules A, B, and C" → "A and C have no dependencies and can be parallel — define interfaces first, then implement separately" |
| Level 6 → 7 | Codify workflows into Commands | "I always do this in three steps" → "Turn this workflow into a /xxx Command for one-click execution" |
| Level 7 → 8 | Manual triggers to event-driven | "I manually run /review on every PR" → "Configure CI to auto-trigger AI Review when a PR is created" |

### Step 4: Provide Practice Recommendations

Suggest that the user try using the higher-level expression style in their next 5 AI interactions and track the differences in results.
