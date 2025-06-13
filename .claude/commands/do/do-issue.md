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

## Phase 3: Smart Test-First Development

### 3.1 Reference Code Guidelines

Follow project standards:
- **Python**: `.claude/code-guidelines/python.md` (uv, FastAPI, 300-line limit)
- **TypeScript**: `.claude/code-guidelines/typescript.md` (bun, TanStack Router, shadcn/ui)
- **React**: `.claude/code-guidelines/react.md` (React 19, Server Components)

### 3.2 Test What Matters

Choose the right tests for what you're building:

**API/Backend Logic**: Write focused tests for core business logic
```bash
# Test the important stuff: business rules, data validation, API contracts
touch tests/test_auth_service.py
```

**UI Components**: Test user interactions that matter
```bash  
# Use Playwright MCP for critical user flows only
# "Test the login flow works end-to-end"
```

**Bug Fixes**: Write a test that reproduces the bug first
```bash
# Prove the bug exists, then fix it
```

### 3.3 Lean TDD Cycle

1. **Write minimal test** for the core functionality
2. **Commit failing test**: `git commit -m "test: reproduce issue #$ARGUMENTS"`
3. **Make it pass** with simplest code
4. **Commit working code**: `git commit -m "feat: fix issue #$ARGUMENTS"`
5. **Refactor if needed** (only if messy)

### 3.4 Smart Testing Choices

- **New feature**: Test the main happy path + one error case
- **Bug fix**: Test that reproduces the bug + verify fix
- **UI change**: Quick Playwright test for critical user flow
- **Refactor**: Existing tests should still pass
- **Small change**: Maybe no new tests needed

Skip tests for:
- Trivial getters/setters
- Framework/library code
- One-off scripts
- Pure UI styling

### 3.5 Implementation Areas

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

## Phase 4: Quick Quality Check

### 4.1 Run Tests & Linting

```bash
# Quick quality check
npm test                   # Run existing tests
npm run lint              # Fix obvious issues
npm run typecheck         # TypeScript errors
```

### 4.2 Manual Smoke Test

- [ ] Feature works as expected
- [ ] No obvious errors in console
- [ ] Meets the original issue requirements

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

## Phase 6: Final Commit and PR Creation

### 6.1 Final Commit

```bash
# Quick final check
npm test && npm run lint

# Commit the work
git add .
git commit -m "feat: implement issue #$ARGUMENTS

- Core functionality working
- Tests passing  
- Ready for review

Closes #$ARGUMENTS"
```

### 6.2 Create Pull Request

Use @create-pr.md for standardized PR creation:

```bash
# Follow PR creation guidelines from @create-pr.md
# Include comprehensive testing summary
```

### 6.3 Simple PR Content

**Required:**
- "Closes #$ARGUMENTS"
- Brief description of what was implemented
- Any breaking changes or migration notes

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

## Quality Standards (Keep It Simple)

**Basic Quality**
- [ ] Feature works
- [ ] Tests pass
- [ ] No TypeScript errors
- [ ] Files under 300 lines
- [ ] Code is readable

**Smart Testing**
- [ ] Tests cover the important functionality
- [ ] Bug fixes have a test that would catch regression
- [ ] Critical user flows work (manual or Playwright test)

**Documentation** 
- [ ] Complex logic has comments
- [ ] Breaking changes documented
- [ ] User-facing changes explained

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
