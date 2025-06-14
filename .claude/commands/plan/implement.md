# Direct Technical Implementation Planning

Create GitHub issues for direct technical implementation tasks and assign them to the current iteration. This command is for straightforward technical requirements that don't need feature analysis.

**Input:** $ARGUMENTS (simple technical requirement description)

**Examples:**
- "implement CORS support in backend API"
- "add dark mode toggle to user settings"
- "integrate Stripe payment processing"
- "add user authentication middleware"

## 1. Analyze Technical Requirement

Break down the technical requirement:

**Scope Assessment:**
- Identify affected system areas (Frontend, Backend, CLI, Infrastructure)
- Determine if this is a single focused implementation or needs breakdown
- Assess complexity and dependencies

**Implementation Approach:**
- Simple: Single area, straightforward implementation → Create 1-2 tasks
- Complex: Multiple areas or integration points → Create 3-5 focused tasks

## 2. Create Implementation Tasks

For simple requirements, create 1-2 GitHub issues:

```bash
# Create main implementation task
gh issue create \
  --title "[IMPLEMENT] [Area]: [Specific implementation]" \
  --body "[Use template below]" \
  --label "task,implementation" \
  --assignee "@me"

# Move to Todo status and assign to current iteration
.claude/utils/move-item-status.sh [TASK_NUMBER] "todo"
.claude/utils/assign-iteration.sh [TASK_NUMBER] "current"
```

For complex requirements, break into focused tasks by area:

```bash
# Create each focused task
gh issue create \
  --title "[IMPLEMENT] [Specific Area]: [Focused task]" \
  --body "[Use template below]" \
  --label "task,implementation" \
  --assignee "@me"

# Repeat for each task, then assign all to current iteration
```

## Task Content Template

**Implementation Requirement:** [Original requirement from $ARGUMENTS]

**Task Description:** [Specific implementation focus for this task]

**Acceptance Criteria:**
- [ ] [Core functionality implemented]
- [ ] [Integration points working]
- [ ] [Tests written and passing]
- [ ] [Documentation updated if needed]

**Technical Notes:** [Key implementation details, APIs, or constraints]

**Dependencies:** [List any prerequisite tasks or external dependencies]

**Area:** [Frontend/Backend/CLI/Infrastructure]

**Estimated Effort:** [Small: <1 day, Medium: 1-3 days, Large: 3-5 days]

## 3. Task Organization

**For Single Tasks:**
- Assign to current iteration
- Move to "Todo" status
- Ready for immediate implementation

**For Multiple Tasks:**
- Prioritize by dependencies
- Assign all to current iteration
- Ensure proper sequencing
- Link related tasks in comments

```bash
# Link related tasks
gh issue comment [TASK_1] --body "Related implementation task: #[TASK_2]"
```

## 4. Validation

**Ensure implementation readiness:**
- [ ] Clear technical scope defined
- [ ] Implementation approach is obvious
- [ ] Dependencies identified
- [ ] Tasks are appropriately sized
- [ ] All assigned to current iteration

**Human Review Required** when:
- Implementation touches multiple complex systems
- New architecture patterns needed
- Unclear technical requirements
- Significant integration challenges

This command creates actionable implementation tasks ready for immediate development work.