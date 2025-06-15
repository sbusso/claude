# Break Down Issue Into Implementation Tasks

You are breaking down a PRD or feature GitHub issue into specific, implementable task issues. Follow this systematic approach to create a comprehensive task breakdown.

**Task:** Break down GitHub issue $ARGUMENTS into implementation tasks

## Step 1: Fetch and Analyze Source Issue

**Use the GitHub tool to gather complete information:**
1. Fetch the source issue details using the issue number from $ARGUMENTS
2. Read the full issue description and all requirements
3. Identify the issue type (PRD vs Feature) from labels and title
4. Extract all acceptance criteria and technical requirements
5. Review any comments or additional context provided

## Step 2: Perform Deep Requirements Analysis

**For complex breakdowns, engage in extended thinking:**
Think deeply about breaking down this work from issue $ARGUMENTS. Consider all technical areas, integration challenges, dependency ordering, and the most logical decomposition into implementable tasks. Consider edge cases, testing requirements, and incremental delivery opportunities. What are the natural phases of implementation?

**Apply systematic analysis framework:**
1. **Extract acceptance criteria**: List all testable requirements from the issue
2. **Identify functional requirements**: Determine core capabilities needed
3. **Map technical scope**: Identify affected system areas (Frontend, Backend, CLI, Database, Infrastructure)
4. **Note dependencies**: Document prerequisites and integration points
5. **Assess complexity**: Evaluate implementation difficulty and unknowns

## Step 3: Assess Technical Scope

**Analyze which system areas will be affected:**
1. **Frontend**: Identify needed components, user interactions, state management, routing changes
2. **Backend**: Determine required APIs, business logic, data models, validation, authentication
3. **CLI**: Note needed commands, help text, configuration handling, user experience improvements
4. **Database**: Check for schema changes, migrations, queries, performance optimization needs
5. **Infrastructure**: Consider deployment, monitoring, configuration, scaling requirements
6. **Testing**: Plan unit tests, integration tests, end-to-end testing, performance testing
7. **Documentation**: Identify user guides, API docs, development documentation needs

**Map integration points that require attention:**
1. External service integrations and their dependencies
2. Inter-service communication patterns
3. Data flow and transformation requirements
4. Security and authentication boundaries

## Step 4: Determine Task Breakdown Strategy

**Choose your breakdown approach based on complexity:**

**For Simple Issues (2-4 tasks):**
1. Core implementation task
2. Testing task
3. Documentation task

**For Moderate Issues (4-8 tasks):**
1. Research/design task
2. Backend implementation task(s)
3. Frontend implementation task(s)
4. Integration testing task
5. Documentation task

**For Complex Issues (8+ tasks):**
1. Research and architecture task
2. Multiple implementation tasks by area/component
3. Multiple testing tasks (unit, integration, e2e)
4. Documentation and deployment tasks

## Step 5: Create Task Issues

**For each identified task, use the GitHub tool to create task issues:**

**Use this title pattern:** `[Task] {Area}: {Specific Implementation}`

**Example titles to guide your formatting:**
- `[Task] Backend: User authentication API endpoints`
- `[Task] Frontend: Login form component`
- `[Task] Database: User schema and migrations`
- `[Task] Testing: Authentication flow integration tests`

**Use this template for each task issue body:**
```markdown
# Task: {Specific Implementation}

**Parent Issue:** #{parent_issue_number}
**Area:** {Frontend/Backend/CLI/Database/Infrastructure/Testing/Documentation}
**Estimated Effort:** {S/M/L} ({timeframe})

## Description
{Clear description of what needs to be implemented}

## Acceptance Criteria
- [ ] {Specific deliverable 1}
- [ ] {Specific deliverable 2}
- [ ] {Specific deliverable 3}
- [ ] Tests written and passing
- [ ] Documentation updated (if needed)

## Implementation Details
### Approach
{Step-by-step implementation approach}

### Files to Modify/Create
- {File 1}: {Changes needed}
- {File 2}: {Changes needed}

### Technical Specifications
{API changes, data models, configuration updates}

## Testing Requirements
- [ ] {Test scenario 1}
- [ ] {Test scenario 2}

## Dependencies
- Task: #{dependent_task_number}
- External: {library/service}

## Definition of Done
- [ ] All acceptance criteria met
- [ ] Code follows project standards
- [ ] Tests passing
- [ ] Documentation updated
- [ ] Code reviewed and merged
```

**Add appropriate labels:** `task`, `{area}` (frontend/backend/etc.), `{size}` (S/M/L), and link to parent issue

## Step 6: Organize and Link Tasks

**Manage task dependencies:**
1. Identify which tasks must be completed before others can start
2. Note external dependencies (libraries, services, approvals)
3. Plan the critical path through the work

**Establish issue relationships:**
1. Link all task issues to the parent PRD/feature issue using GitHub's linking syntax
2. Use "Closes" or "Related to" syntax in task descriptions
3. Plan to create a task checklist in the parent issue description

**Set task priorities:**
1. **High**: Foundational work, blocking other tasks, high risk/uncertainty
2. **Medium**: Core functionality, standard implementation
3. **Low**: Enhancements, nice-to-have features, optimization

## Step 7: Update Parent Issue

**Use the GitHub tool to update the parent issue:**
1. Add a task breakdown summary to the issue description
2. Create a checklist of all created task issues
3. Update labels to indicate "ready for implementation"
4. Add a comment summarizing the breakdown

**Parent Issue Update:**
```markdown
## Task Breakdown

This issue has been broken down into the following implementation tasks:

### Core Implementation
- [ ] #{task1} - Backend API endpoints
- [ ] #{task2} - Frontend components
- [ ] #{task3} - Database schema

### Testing & Quality
- [ ] #{task4} - Unit tests
- [ ] #{task5} - Integration tests

### Documentation
- [ ] #{task6} - API documentation
- [ ] #{task7} - User guide updates

**Total Tasks:** {count}
**Estimated Effort:** {total_estimate}
**Critical Path:** Task {x} → Task {y} → Task {z}
```

## Step 8: Validate Task Breakdown

**Check completeness:**
1. Verify all acceptance criteria are covered by tasks
2. Ensure no implementation areas are missing
3. Confirm dependencies are identified and sequenced
4. Verify testing tasks are included for each major component

**Check clarity:**
1. Ensure each task has clear, actionable deliverables
2. Verify implementation approach is obvious to developers
3. Confirm effort estimates are realistic
4. Check that dependencies don't create circular blocking

**Check quality:**
1. Verify tasks are appropriately sized (avoid too large or too small)
2. Ensure critical path is clearly identified
3. Confirm risk/uncertainty tasks are prioritized early

## Step 9: Request Human Review If Needed

**Stop and request human review when:**
- Task breakdown reveals significantly higher complexity than expected
- New architectural decisions are needed that weren't in the original issue
- External dependencies or approvals are required
- Security or performance implications are discovered

## Step 10: Provide Comprehensive Summary

**Create a detailed breakdown summary:**
- **Parent Issue**: Issue number and full title
- **Total Tasks Created**: Count and effort distribution across areas
- **Task Categories**: Distribution across areas (Frontend, Backend, Testing, etc.)
- **Critical Path**: Key dependency chain for implementation
- **Next Steps**: Recommended priority order for implementation
- **Dependencies**: Any blocking factors or prerequisites identified

This systematic approach ensures comprehensive task breakdown while maintaining clear traceability through GitHub's issue system.