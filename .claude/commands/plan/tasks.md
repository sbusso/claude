# Feature Planning & Task Breakdown

Break down backlog feature #$ARGUMENTS into implementation tasks for iterations

## Purpose
Take a feature issue from the backlog, analyze its requirements, and break it down into specific implementation tasks that can be assigned to iterations and worked on incrementally.

## Phase 1: Feature Analysis

### 1.1 Initialize Project Configuration
```bash
# Ensure project configuration is available
if [[ ! -f ".claude/project-config.json" ]]; then
    echo "🔄 Discovering project configuration..."
    .claude/utils/get-project-config.sh
fi
```

### 1.2 Fetch Feature from Backlog
```bash
# Get the feature issue details
gh issue view $ARGUMENTS

# Verify issue exists in project
PROJECT_NUMBER=$(jq -r '.project.number' .claude/project-config.json)
OWNER=$(jq -r '.owner' .claude/project-config.json)
gh project item-list "$PROJECT_NUMBER" --owner "$OWNER" --format json | \
  jq -r ".items[] | select(.content.number == $ARGUMENTS) | .id" > /dev/null
```

### 1.3 Requirements Review
Extract from the feature issue:

**Acceptance Criteria**
- List all testable criteria
- Identify complex vs simple requirements
- Note dependencies between criteria

**Extended Thinking for Complex Features:**
When dealing with complex features, use extended thinking:
> "Think deeply about breaking down this feature: [FEATURE_DESCRIPTION]. Consider all the technical areas that need to be touched, potential integration challenges, dependency ordering, and the most logical way to decompose this into implementable tasks. Think harder about edge cases and testing requirements."

**Technical Scope Assessment**
- Determine affected system areas (Frontend, Backend, CLI, etc.)
- Identify integration points
- Assess complexity level

**Implementation Complexity**
- Simple: Single area, straightforward implementation
- Medium: Multiple areas or some technical challenges  
- Complex: Cross-system changes, new patterns, or unknowns

## Phase 2: Task Decomposition Strategy

### 2.1 Task Categories

**Research Tasks**
- For unknowns or new technology exploration
- Include specific questions to answer
- Define deliverables (findings, recommendations)

**Design Tasks**  
- For UI/UX work requiring design before implementation
- Architecture decisions needing documentation
- API design and contracts

**Implementation Tasks**
- Core feature functionality
- Integration work
- Configuration and setup

**Testing Tasks**
- Unit test creation
- Integration testing
- User acceptance testing

**Documentation Tasks**
- User guides
- API documentation
- Development documentation

### 2.2 Area-Based Breakdown
Organize tasks by system area:

**Frontend (if UI changes needed)**
- Component creation/updates
- User interaction implementation  
- State management
- Responsive design

**Backend (if API changes needed)**
- Endpoint implementation
- Business logic
- Data model updates
- Validation logic

**CLI (if command-line features needed)**
- Command implementation
- Help text updates
- Configuration handling

**Infrastructure (if system changes needed)**
- Deployment updates
- Configuration changes
- Environment setup

## Phase 3: Task Creation

### 3.1 Create Implementation Tasks

For each identified task:

```bash
# Create task with proper labeling
TASK_NUMBER=$(gh issue create \
  --title "[TASK] [Area]: [Specific implementation]" \
  --body "[Detailed task description with acceptance criteria]" \
  --label "task" \
  --assignee "@me" \
  --output json | jq -r '.number')

# Move task to Todo status in project
.claude/utils/move-item-status.sh "$TASK_NUMBER" "todo"

# Assign to current iteration
.claude/utils/assign-iteration.sh "$TASK_NUMBER" "current"

# Link to parent feature
gh issue comment $ARGUMENTS --body "Related task: #$TASK_NUMBER"
```

### 3.2 Task Content Template

```markdown
## Parent Feature
Related to feature #$ARGUMENTS

## Task Description
[Specific implementation task description]

## Acceptance Criteria
- [ ] [Specific deliverable 1]
- [ ] [Specific deliverable 2]
- [ ] [Specific deliverable 3]

## Implementation Notes
[Technical details and considerations]

## Definition of Done
- [ ] Implementation complete
- [ ] Tests written and passing
- [ ] Code reviewed
- [ ] Documentation updated (if needed)
- [ ] Integrated with existing system

## Dependencies
- [ ] [Prerequisite task or feature]
- [ ] [Required resource or decision]

## Area
[Frontend/Backend/CLI/Infrastructure/Documentation]

## Estimated Effort
[Small: <1 day, Medium: 1-3 days, Large: 3-5 days]
```

## Phase 4: Iteration Assignment

### 4.1 Prioritize Tasks
Order by:
1. **Dependencies**: Tasks that block other work
2. **Risk**: High-uncertainty tasks first
3. **Value**: Core functionality before enhancements
4. **Effort**: Balance small and large tasks per iteration

### 4.2 Assign to Iterations

```bash
# For priority tasks - assign to current iteration
.claude/utils/assign-iteration.sh "[TASK_NUMBER]" "current"

# For future tasks - assign to specific iteration by name
.claude/utils/assign-iteration.sh "[TASK_NUMBER]" "Iteration 2"

# Move tasks to todo status for implementation
.claude/utils/move-item-status.sh "[TASK_NUMBER]" "todo"
```

### 4.3 Update Feature Status

```bash
# Move feature from backlog to todo (indicating planning complete)
.claude/utils/move-item-status.sh "$ARGUMENTS" "todo"

# Add planning completion comment with task links
TASK_LIST=$(gh issue list --search "Related task" --state open --limit 20 | \
  grep "#$ARGUMENTS" | cut -d' ' -f1 | paste -sd, -)
gh issue comment $ARGUMENTS --body "✅ Feature broken down into implementation tasks: $TASK_LIST

Tasks assigned to iterations and ready for implementation."
```

## Phase 5: Planning Validation

### 5.1 Task Review Checklist

**Completeness**
- [ ] All acceptance criteria covered by tasks
- [ ] No missing implementation areas
- [ ] Dependencies identified and planned
- [ ] Testing tasks included

**Clarity**
- [ ] Each task has clear deliverables
- [ ] Implementation approach is obvious
- [ ] Effort estimates are reasonable
- [ ] Prerequisites are identified

**Integration**
- [ ] Tasks properly linked to parent feature
- [ ] Iteration assignments are balanced
- [ ] Dependencies between tasks mapped
- [ ] Status updates completed

### 5.2 Human Review Required

⚠️ **STOP FOR HUMAN REVIEW** when:
- Task breakdown reveals higher complexity than expected
- New technical dependencies discovered
- Resource constraints affect iteration planning
- Cross-team coordination needed
- Architecture decisions required

**Extended Thinking for Architectural Decisions:**
When architectural decisions are needed:
> "Think longer about the architectural implications of this feature implementation. Consider the long-term maintainability, scalability, and integration patterns. Think about alternative approaches and their trade-offs."

**Present to Human**:
- Task breakdown summary
- Extended architectural analysis
- Iteration timeline and resource allocation
- Risk factors and dependencies
- Implementation approach validation
- Alternative architectural approaches considered

## Phase 6: Workflow Transition

### 6.1 Planning Complete

```bash
# Get task count and iteration assignments
REPO=$(jq -r '.repository' .claude/project-config.json)
TASK_COUNT=$(gh issue list --repo "$REPO" --search "Related task #$ARGUMENTS" --state open | wc -l)
CURRENT_ITERATION=$(jq -r '.fields.iteration.current' .claude/project-config.json)

echo "Feature #$ARGUMENTS planning complete:"
echo "- Status: Backlog → Todo (ready for implementation)"
echo "- Tasks created: $TASK_COUNT tasks"
echo "- Current iteration: $(jq -r ".fields.iteration.iterations.\"$CURRENT_ITERATION\".title" .claude/project-config.json)"
echo "- Ready for implementation"
```

### 6.2 Next Steps

**Implementation Ready**
- Tasks are in "Planned" status
- Assigned to specific iterations
- Ready for @do-issue.md execution
- Dependencies clearly mapped

**Manual Handover**
- Development team can pick up tasks
- Each task has clear acceptance criteria
- Implementation approach documented
- Progress can be tracked in GitHub Projects

## Best Practices

### Task Granularity
- **Small Tasks**: 1-4 hours (quick wins, bug fixes)
- **Medium Tasks**: 1-3 days (feature components, integrations)
- **Large Tasks**: 3-5 days (complex features, new systems)

### Dependency Management
- Identify blocking relationships early
- Create tasks in dependency order
- Consider parallel work opportunities
- Plan integration points

### Iteration Balance
- Mix of small and medium tasks per iteration
- Include testing and documentation tasks
- Account for integration and review time
- Leave buffer for unexpected complexity

### Quality Standards
- Each task must have testable acceptance criteria
- Implementation approach should be clear
- Dependencies must be explicitly stated
- Effort estimates should be realistic

## Integration with GitHub Projects

### Status Flow
1. **Backlog**: Features awaiting planning (created by feature.md)
2. **Todo**: Features/tasks ready for implementation (moved by tasks.md)
3. **In Progress**: Tasks being actively worked (moved by do-issue.md)
4. **Done**: Tasks completed and validated

### Utility Commands
- `.claude/utils/get-project-config.sh` - Auto-discover project configuration
- `.claude/utils/move-item-status.sh <issue> <status>` - Move items between statuses
- `.claude/utils/assign-iteration.sh <issue> <iteration>` - Assign to iterations
- `.claude/utils/setup-labels.sh` - Create required workflow labels

### Automation Features
- ✅ Auto-assign tasks to current iteration
- ✅ Auto-link child tasks to parent features
- ✅ Auto-update status using utility scripts
- ✅ Dynamic project configuration discovery