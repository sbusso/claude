# Execute Implementation Task

You are implementing a specific GitHub task issue. Follow this systematic approach for high-quality, complete implementation.

**Task:** Implement GitHub issue $ARGUMENTS with deep technical analysis and smart test-first development.

## Step 1: Fetch and Analyze the Task

**Use the GitHub tool to:**
1. Fetch the complete task issue details for issue number $ARGUMENTS
2. Read the full issue description, acceptance criteria, and implementation requirements
3. Identify the parent issue (PRD or Feature) to understand broader context
4. Check for any dependent tasks or prerequisite work that must be completed first
5. Review any linked pull requests or previous implementation attempts

## Step 2: Deep Technical Analysis

**Perform extended thinking for complex implementations:**
Think deeply about implementing this task issue $ARGUMENTS. Consider the technical approach, potential challenges, integration points, testing strategy, and how this fits into the overall system architecture. What are the key decisions that need to be made during implementation?

**Analyze the requirements systematically:**
1. **Extract the user story**: Identify who needs this, what functionality is required, and why it provides value
2. **Map acceptance criteria**: List all must-have requirements and identify edge cases that must be handled
3. **Determine technical scope**: Identify which components, files, and system areas will be affected
4. **Check dependencies**: Verify any blocking tasks or prerequisite work is completed
5. **Consider edge cases**: Think through error states, boundary conditions, null/empty inputs, and failure scenarios
6. **Assess non-functional requirements**: Evaluate performance, security, accessibility, and usability implications

## Step 3: System Impact Assessment

**Evaluate which system areas will be affected:**
1. **Frontend**: Determine if you need new components, state management changes, routing updates, or user interaction modifications
2. **Backend**: Identify required APIs, business logic changes, data model updates, or validation rules
3. **Database**: Check for schema changes, new queries, required migrations, or index optimizations
4. **Infrastructure**: Consider configuration updates, deployment changes, or monitoring requirements
5. **Testing**: Plan unit tests, integration tests, and end-to-end testing strategy
6. **Documentation**: Identify code docs, API documentation, or user guide updates needed

**Identify integration points that require attention:**
1. External service integrations and their impact
2. Inter-service communication patterns that may change
3. Data flow and transformation requirements
4. Authentication and authorization boundary changes
5. Caching strategies and performance considerations

## Step 4: Human Validation Check

**STOP and request human review if any of these apply:**

- **Architectural Changes**: New patterns, frameworks, or system design decisions
- **Database Schema Changes**: New tables, columns, relationships, or major queries
- **API Breaking Changes**: Changes that affect existing integrations or contracts
- **Security Implications**: Authentication, authorization, data handling, or privacy
- **Performance Critical**: Changes affecting system performance or scalability
- **External Dependencies**: New third-party services, libraries, or integrations
- **Infrastructure Changes**: Deployment, configuration, or environment changes
- **Cross-Team Impact**: Changes affecting other teams or systems

**If human review is required, present this analysis:**
1. Summary of technical approach and key decisions
2. Identified risks and your mitigation strategies
3. Timeline and effort estimate
4. Dependencies and prerequisites
5. Wait for explicit approval before proceeding

## Step 5: Environment Setup

**Use the GitHub tool to update task status:**
1. Add "in-progress" label to the task issue
2. Add a comment indicating implementation has started
3. Update the assignee field if needed
4. Remove any "ready" or "todo" labels

**Use Git commands to create a feature branch:**
1. Create a new branch with naming pattern: `task/{issue-number}-{brief-description}`
2. Push the branch and set upstream tracking
3. Link the branch to the GitHub issue if your project supports this

## Step 6: Reference Project Guidelines

**Use the Read tool to check project-specific coding standards:**
1. For Python projects: Read `.claude/contexts/python.md` for uv, FastAPI, and 300-line file limit guidelines
2. For TypeScript projects: Read `.claude/contexts/typescript.md` for bun, TanStack Router, and shadcn/ui patterns
3. For React projects: Read `.claude/contexts/react.md` for React 19 and Server Components best practices
4. Follow the existing patterns, libraries, and architectural decisions in the codebase

## Step 7: Design Test Strategy

**Plan your test-first approach:**
1. **Focus testing on**: Business logic, critical user flows, and integration points
2. **Skip testing**: Simple getters/setters, framework code, and styling (unless critical to functionality)
3. **Choose test types**: Unit tests for core logic, integration tests for user workflows

**Design specific test scenarios:**
1. Identify the testable units and integration points in your implementation
2. Create test scenarios that verify each acceptance criteria
3. Plan test data and setup requirements for your scenarios
4. Consider mocking strategies for external dependencies

## Step 8: Plan Implementation Approach

**Break down your technical approach:**
1. Divide the implementation into logical, sequential steps
2. Identify specific files you need to create or modify
3. Plan the data structures and interfaces you'll need
4. Design error handling and validation strategies
5. Consider performance and security implications

**Choose your development strategy:**
1. Start with core functionality first
2. Build incrementally, adding tests as you go
3. Handle edge cases and error conditions
4. Add documentation and comments for complex logic

## Step 9: Execute Core Implementation

**Use development tools to implement the functionality:**
1. Follow test-first principles: write failing tests, then make them pass
2. Use the Edit or Write tools to create clean, maintainable code
3. Follow existing project conventions and patterns you identified earlier
4. Handle edge cases and error conditions appropriately
5. Add appropriate logging and monitoring where needed
6. Follow security best practices for data handling and validation

**Maintain high code quality standards:**
1. Write clear, self-documenting code with meaningful variable names
2. Add comments only for complex business logic that isn't obvious
3. Use consistent naming and structure with the existing codebase
4. Optimize for readability and maintainability over clever solutions

## Step 10: Implement and Run Tests

**Write comprehensive test coverage:**
1. Use appropriate testing tools to write unit tests for business logic
2. Create integration tests for complete user workflows
3. Add end-to-end tests for critical user paths (use Playwright tool if available)
4. Write tests that verify error handling and edge cases
5. Include performance and security testing where relevant

**Ensure high test quality:**
1. Write tests that are fast, reliable, and independent of each other
2. Use descriptive test names that explain what is being tested
3. Mock external dependencies appropriately to isolate your code
4. Cover both happy path scenarios and error conditions

## Step 11: Update Documentation

**Add necessary code documentation:**
1. Use the Edit tool to add comments for complex business logic
2. Document any new API endpoints and data structures
3. Update type definitions and interfaces if working with TypeScript

**Update user-facing documentation if needed:**
1. Update user guides for any user-facing changes
2. Add or update API documentation for new endpoints
3. Update configuration documentation if you added new settings

## Step 12: Quality Validation

**Verify functional requirements:**
1. Test that all acceptance criteria are met and working correctly
2. Verify edge cases are handled appropriately
3. Ensure error messages are clear and helpful to users
4. Confirm performance meets the stated requirements

**Validate code quality:**
1. Use linting tools to ensure code follows project standards
2. Review for security vulnerabilities and fix any found
3. Verify appropriate error handling and logging is in place
4. Confirm the implementation is clean and maintainable

**Test system integration:**
1. Verify your changes integrate well with the existing system
2. Ensure no breaking changes affect other components
3. Check that dependencies are properly handled
4. Test any configuration updates work correctly

## Step 13: Complete the Task

**Use the GitHub tool to update task status:**
1. Remove the "in-progress" label from the task issue
2. Add "completed" or "ready-for-review" label as appropriate
3. Add a completion comment summarizing what was implemented
4. Update the task issue description with implementation details if needed

**Document your completion:**
1. List all files you created or modified
2. Summarize key implementation decisions you made
3. Document test coverage and key test scenarios added
4. Note any documentation updates you made
5. Identify any follow-up items or notes for future tasks

## Step 14: Create Pull Request

**Use the GitHub tool to create a pull request:**
1. Create a PR that links to the task issue in the description
2. Include a clear summary of what changes were made
3. Add testing instructions for reviewers
4. Request appropriate reviewers based on the areas affected

**Structure your PR description like this:**
```markdown
## Summary
Implements task #{task_number}: {task_title}

## Changes
- {Specific change 1}
- {Specific change 2}
- {Specific change 3}

## Testing
- [ ] Unit tests added and passing
- [ ] Integration tests passing
- [ ] Manual testing completed

## Checklist
- [ ] Code follows project standards
- [ ] Documentation updated
- [ ] All acceptance criteria met

Closes #{task_number}
```

## Step 15: Follow Through to Completion

**Monitor the code review process:**
1. Respond promptly to reviewer feedback and questions
2. Make requested changes using the Edit tool
3. Ensure all CI/CD tests continue to pass
4. Update documentation based on reviewer feedback

**After the PR is merged, use the GitHub tool to:**
1. Verify the task issue was automatically closed (or close it manually)
2. Update the parent issue (PRD or Feature) with progress
3. Add a completion comment to the parent issue
4. Clean up the feature branch if your project doesn't do this automatically

## Final Summary

**Provide a comprehensive implementation summary:**
- **Task Completed**: Issue #{issue_number} and brief description
- **Files Modified**: List the specific files changed and major modifications
- **Tests Added**: Describe test coverage and key scenarios tested
- **Key Decisions**: Note important implementation choices and rationale
- **Next Steps**: Suggest any follow-up tasks or considerations
- **PR Status**: Pull request number and current status

This systematic approach ensures high-quality implementation with complete traceability through GitHub's issue and PR workflow.