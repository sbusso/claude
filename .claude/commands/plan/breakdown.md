Take feature issue #$ARGUMENTS from the backlog, analyze its requirements, and break it down into specific implementation tasks as new GitHub Issues assigned to the current iteration.

## 1. Analyze Feature Issue

Review the GitHub issue to extract:

**Acceptance Criteria**
- List all testable criteria from the issue
- Identify complex vs simple requirements  
- Note dependencies between criteria

**Technical Scope Assessment**
- Determine affected system areas (Frontend, Backend, CLI, etc.)
- Identify integration points
- Assess implementation complexity

**Extended Thinking for Complex Features:**
For complex features requiring deep analysis:
> "Think deeply about breaking down this feature. Consider all technical areas, integration challenges, dependency ordering, and the most logical decomposition into implementable tasks. Consider edge cases and testing requirements."

## 2. Break Down Into Tasks

Organize tasks by category and system area:

**Task Categories:**
- **Implementation**: Core functionality, integration work, configuration
- **Testing**: Unit tests, integration tests, user acceptance testing  
- **Documentation**: User guides, API docs, development documentation
- **Research**: For unknowns or new technology exploration (when needed)

**System Areas:**
- **Frontend**: Components, user interactions, state management
- **Backend**: Endpoints, business logic, data models, validation
- **CLI**: Commands, help text, configuration handling
- **Infrastructure**: Deployment, configuration, environment setup

## 3. Create GitHub Issues for Tasks

For each identified task:

```bash
# Create the task issue
gh issue create \
  --title "[TASK] [Area]: [Specific implementation]" \
  --body "[Use template below]" \
  --label "task" \
  --assignee "@me"

# Move to Todo status and assign to current iteration
gh issue view [TASK_NUMBER] # Get the issue number from creation
.claude/utils/move-item-status.sh [TASK_NUMBER] "todo"
.claude/utils/assign-iteration.sh [TASK_NUMBER] "current"

# Link to parent feature
gh issue comment $ARGUMENTS --body "Related task: #[TASK_NUMBER]"
```

Use this template for each task issue:

**Parent Feature:** #$ARGUMENTS

**Task Description:** [Specific implementation description]

**Acceptance Criteria:**
- [ ] [Specific deliverable 1]
- [ ] [Specific deliverable 2]
- [ ] [Tests written and passing]
- [ ] [Documentation updated if needed]

**Dependencies:** [List any prerequisite tasks]

**Area:** [Frontend/Backend/CLI/Infrastructure/Documentation]

**Estimated Effort:** [Small: <1 day, Medium: 1-3 days, Large: 3-5 days]

## 4. Prioritize and Assign Tasks

**Priority Order:**
1. **Dependencies**: Tasks that block other work
2. **Risk**: High-uncertainty tasks first  
3. **Value**: Core functionality before enhancements
4. **Effort**: Balance small and large tasks per iteration

**Assignment:**
- Assign priority tasks to current iteration
- Assign future tasks to specific iterations by name
- Move all tasks to "Todo" status for implementation

```bash
# Update parent feature status
.claude/utils/move-item-status.sh $ARGUMENTS "todo"

# Add completion comment to parent feature
gh issue comment $ARGUMENTS --body "✅ Feature broken down into implementation tasks. Ready for development."
```

## 5. Validation Checklist

**Ensure completeness:**
- [ ] All acceptance criteria covered by tasks
- [ ] No missing implementation areas  
- [ ] Dependencies identified and planned
- [ ] Testing tasks included

**Ensure clarity:**
- [ ] Each task has clear deliverables
- [ ] Implementation approach is obvious
- [ ] Effort estimates are reasonable
- [ ] Tasks properly linked to parent feature

**Human Review Required** when:
- Task breakdown reveals higher complexity than expected
- New technical dependencies discovered
- Architecture decisions required

**Extended Thinking for Architectural Decisions:**
When architectural decisions are needed:
> "Think longer about the architectural implications of this feature implementation. Consider long-term maintainability, scalability, and integration patterns. Think about alternative approaches and their trade-offs."
