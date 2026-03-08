Analyze a prompt provided by the user, assess its AI engineering operation level, and provide upgrade recommendations.

The user should provide a prompt they use in their daily workflow: $ARGUMENTS

## Analysis Process

### Step 1: Identify Prompt Level

Classify according to the following criteria:

**Level 3-4 Characteristics (Prompt Engineering)**
- Specifies concrete technical implementation (e.g., "use useState", "add a useEffect")
- Tells the AI exactly how to do each step
- Lacks business context and constraints
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

Rewrite the user's prompt at a higher Level, showing the comparison:

```
## Prompt Analysis Results

**Original Prompt**:
> [user's original prompt]

**Detected Level**: Level N
**How/What Ratio**: X% How / Y% What

### Diagnosis
- [Point out specific parts of the prompt that can be improved]

### Upgraded Version (Level M)
> [rewritten prompt at a higher level]

### Key Improvements
1. [What was changed and why]
2. ...
3. ...
```

### Step 4: Provide Practice Recommendations

Suggest that the user try using the higher-level expression style in their next 5 AI interactions and track the differences in results.
