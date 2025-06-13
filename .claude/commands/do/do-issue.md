# Complete Issue Implementation

Complete end-to-end feature development workflow for issue #$ARGUMENTS

## Phase 1: Deep Analysis & Planning

### 1.1 Fetch and Analyze Issue

```bash
# Ensure project configuration is available
if [[ ! -f ".claude/project-config.json" ]]; then
    echo "🔄 Discovering project configuration..."
    .claude/utils/get-project-config.sh
fi

# Get issue details and move to "In Progress" in GitHub Projects
gh issue view $ARGUMENTS
.claude/utils/move-item-status.sh "$ARGUMENTS" "in_progress"
gh issue edit $ARGUMENTS --add-label "in-progress"
```

### 1.2 Requirements Analysis

Perform deep thinking analysis:

- **User Story**: Extract who, what, why from issue description
- **Acceptance Criteria**: Identify all must-have requirements
- **Technical Scope**: Determine affected components/areas
- **Dependencies**: Check for blocking issues or prerequisite work
- **Edge Cases**: Consider error states, boundary conditions
- **Non-Functional Requirements**: Performance, security, accessibility

### 1.3 Human Validation Required

⚠️ **STOP FOR HUMAN REVIEW** when any of these apply:

- **Architectural Changes**: New patterns, frameworks, or system design
- **Database Schema Changes**: New tables, columns, or relationships
- **API Breaking Changes**: Changes that affect existing integrations
- **Security Implications**: Authentication, authorization, or data handling
- **Performance Critical**: Changes affecting system performance
- **External Dependencies**: New third-party services or libraries
- **Infrastructure Changes**: Deployment, configuration, or environment changes

**Extended Thinking for Critical Decisions:**
For complex architectural or security-related changes:
> "Think deeply about implementing this issue: $ARGUMENTS. Consider the architectural implications, security considerations, performance impact, and integration challenges. Think harder about potential edge cases, failure modes, and long-term maintainability."

**Present Analysis to Human**:
- Summary of technical approach
- Extended thinking analysis results
- Architectural decisions and alternatives considered
- Risk assessment and mitigation strategies
- Implementation timeline and complexity estimate
- Wait for explicit approval before proceeding

### 1.4 Break Down Into Tasks

If complex feature, create implementation plan:

- Research tasks for unknowns
- Design tasks for UI/UX work
- Implementation tasks by area (UI, Core, CLI, etc.)
- Testing tasks for each component
- Documentation tasks

## Phase 2: Environment Setup

### 2.1 Create Feature Branch

```bash
# Create branch following project naming convention
# Adapt prefix based on issue type: feature/, fix/, hotfix/, etc.
git checkout -b feature/issue-$ARGUMENTS
git push -u origin feature/issue-$ARGUMENTS
```

### 2.2 Optional: Create Worktree for Isolation

For complex features requiring parallel work, see @create-worktrees.md:

```bash
# Example using worktree for isolation
git worktree add ../$(basename $(pwd))-issue-$ARGUMENTS feature/issue-$ARGUMENTS
cd ../$(basename $(pwd))-issue-$ARGUMENTS
```

## Phase 3: Implementation (TDD Approach)

### 3.1 Reference Code Guidelines

Ensure implementation follows project standards:

- **Python**: Use `.claude/code-guidelines/python.md` (uv, FastAPI, 300-line limit)
- **TypeScript**: Use `.claude/code-guidelines/typescript.md` (bun, TanStack Router, shadcn/ui)
- **General**: Maintain file size limits, modular design, proper error handling

### 3.2 Test-Driven Development

1. **Write Tests First**: Create tests that capture acceptance criteria

   - Focus on behavior, not implementation details
   - Test user-facing functionality
   - Include edge cases and error conditions

2. **Red Phase**: Verify tests fail appropriately

3. **Green Phase**: Implement minimal code to pass tests

   - Follow existing patterns in codebase
   - Use established utilities and libraries
   - Maintain single responsibility principle

4. **Refactor Phase**: Improve code quality while keeping tests green
   - Extract reusable components
   - Optimize performance if needed
   - Ensure clean, readable code

⚠️ **Human Review Checkpoint**: If implementation revealed architectural complexity or deviations from original plan, present changes to human for approval before proceeding.

### 3.3 Implementation Areas

Implement across relevant areas based on issue scope:

**Frontend (if UI changes)**

- Create/update React components
- Implement responsive design
- Add proper loading/error states
- Ensure accessibility compliance

**Backend (if API changes)**

- Add/update FastAPI endpoints
- Implement business logic
- Update data models
- Add proper validation

**CLI (if command-line features)**

- Add new commands or options
- Update help text and documentation
- Implement proper error handling

**Documentation**

- Update API documentation
- Add/update user guides
- Document new features or changes

## Phase 4: Quality Assurance

### 4.1 Testing Verification

```bash
# Run all tests to ensure nothing breaks
npm test  # or appropriate test command
npm run test:e2e  # if end-to-end tests exist
```

### 4.2 Code Quality Checks

```bash
# Run linting and type checking
npm run lint
npm run typecheck  # for TypeScript projects
uv run ruff check  # for Python projects
```

### 4.3 Manual Testing

- Test all acceptance criteria manually
- Verify edge cases work correctly
- Check responsive design on different screen sizes
- Test accessibility with screen readers
- Verify error states display appropriately

## Phase 5: Documentation

### 5.1 Update Relevant Documentation

- API documentation for new endpoints
- User guides for new features
- Developer documentation for new patterns
- README updates if needed

### 5.2 Add Code Comments

- Document complex business logic
- Explain non-obvious implementation decisions
- Add JSDoc/docstrings for public APIs

## Phase 6: Commit and PR Creation

### 6.1 Semantic Commit

Use @commit.md for proper commit message format:

```bash
# Stage all changes
git add .

# Follow semantic commit guidelines from @commit.md
# Example: [scope] description of changes
```

### 6.2 Create Pull Request

Use @create-pr.md for standardized PR creation:

```bash
# Follow PR creation guidelines from @create-pr.md
# Ensure proper linking to issue #$ARGUMENTS
```

### 6.3 PR Content Requirements

- Link to original issue: "Closes #$ARGUMENTS"
- Summary of changes made
- Testing approach and results
- Screenshots/GIFs for UI changes
- Breaking changes (if any)
- Migration steps (if needed)

## Phase 7: GitHub Project Management

### 7.1 Update Issue Status

```bash
# Issue will be automatically moved to "Done" when PR is merged via GitHub automation
# Just update labels for tracking
gh issue edit $ARGUMENTS --add-label "ready-for-review"
gh issue edit $ARGUMENTS --remove-label "in-progress"
```

### 7.2 Link PR to Issue

```bash
# Ensure PR properly references the issue
gh pr edit --add-label "ready-for-review"
```

## Quality Standards Checklist

**Code Quality**

- [ ] All files under 300 lines
- [ ] Single responsibility principle followed
- [ ] Existing patterns and utilities used
- [ ] Proper error handling implemented
- [ ] No hardcoded values or magic numbers

**Testing**

- [ ] All acceptance criteria covered by tests
- [ ] Edge cases tested
- [ ] Tests focus on behavior, not implementation
- [ ] All tests passing
- [ ] No test flakiness

**Documentation**

- [ ] Code comments for complex logic
- [ ] API documentation updated
- [ ] User-facing changes documented
- [ ] Migration guides provided (if needed)

**Accessibility & UX**

- [ ] WCAG guidelines followed
- [ ] Keyboard navigation works
- [ ] Screen reader compatible
- [ ] Loading states implemented
- [ ] Error states user-friendly

**Performance**

- [ ] No performance regressions
- [ ] Efficient algorithms used
- [ ] Proper caching implemented
- [ ] Bundle size impact minimal

## Integration Points

**Planning Integration**
- Features come from @tasks.md task breakdown
- Issue should already be in "Todo" status with clear tasks
- Implementation follows the planned task structure
- Use `.claude/utils/` scripts for GitHub Projects status tracking throughout

**Code Guidelines Integration**
- Always reference `.claude/code-guidelines/` before implementation
- Follow language-specific best practices
- Maintain consistency with existing codebase

**Command Integration**
- Use @commit.md for semantic commits
- Use @create-pr.md for standardized PRs
- Use @create-worktrees.md for parallel development
