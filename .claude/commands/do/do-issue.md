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

## Phase 3: Test-First Development Workflow

### 3.1 Reference Code Guidelines

Ensure implementation follows project standards:

- **Python**: Use `.claude/code-guidelines/python.md` (uv, FastAPI, 300-line limit)
- **TypeScript**: Use `.claude/code-guidelines/typescript.md` (bun, TanStack Router, shadcn/ui)
- **React**: Use `.claude/code-guidelines/react.md` (React 19, Server Components, modern patterns)
- **General**: Maintain file size limits, modular design, proper error handling

### 3.2 TDD Workflow: Write Test → Commit → Code → Iterate

#### Step 1: Write Tests First (RED)

**A. Unit Tests**
```bash
# Create test files for core functionality
# Focus on business logic and API contracts

# Example for backend (Python/FastAPI)
touch tests/test_user_service.py
touch tests/test_auth_endpoints.py

# Example for frontend (React/TypeScript)  
touch src/components/__tests__/LoginForm.test.tsx
touch src/hooks/__tests__/useAuth.test.tsx
```

**B. Integration Tests**
```bash
# API integration tests
touch tests/integration/test_auth_flow.py

# Frontend integration tests
touch src/__tests__/auth-flow.integration.test.tsx
```

**C. UI Tests with Playwright MCP**
```bash
# Create Playwright test files
mkdir -p tests/e2e
touch tests/e2e/auth-flow.spec.ts

# Use Playwright MCP for UI validation
# Tests will be created using natural language with MCP
```

#### Step 2: Commit Tests (Initial Commit)

```bash
# Commit failing tests first
git add tests/ src/**/*.test.*
git commit -m "test: Add comprehensive test suite for issue #$ARGUMENTS

- Unit tests for core business logic
- Integration tests for API endpoints  
- E2E tests for user workflows
- Tests currently failing (RED phase)

Related to #$ARGUMENTS"
```

#### Step 3: Implement Code (GREEN)

**A. Backend Implementation**
```bash
# Implement minimal code to pass tests
# Follow test requirements exactly
# Use TDD red-green-refactor cycle
```

**B. Frontend Implementation**  
```bash
# Implement UI components
# Follow React 2025 best practices
# Use Server Components where appropriate
```

**C. Validate with Playwright MCP**
```bash
# Use Playwright MCP to validate UI behavior
# Natural language commands like:
# "Test the login form with valid credentials"
# "Verify error messages display correctly"
# "Check responsive design on mobile viewport"
```

#### Step 4: Iterate and Refactor (GREEN → REFACTOR)

**A. Code Quality Pass**
```bash
# Refactor while keeping tests green
# Extract reusable components
# Optimize performance
# Improve readability
```

**B. Additional Test Coverage**
```bash
# Add edge case tests
# Test error conditions
# Add accessibility tests with Playwright
```

#### Step 5: Final Commit

```bash
# Commit working implementation
git add .
git commit -m "feat: Implement [feature] for issue #$ARGUMENTS

- ✅ All tests passing (GREEN phase)
- ✅ Code refactored for quality
- ✅ UI validated with Playwright
- ✅ Accessibility requirements met
- ✅ Performance optimized

Closes #$ARGUMENTS"
```

### 3.3 Playwright MCP Integration for UI Validation

#### Automated UI Testing
Use Playwright MCP for comprehensive UI validation:

**A. Functional Testing**
- Form submissions and validations
- User interaction flows
- State management verification
- API integration testing

**B. Visual Testing**
- Cross-browser compatibility
- Responsive design validation
- Accessibility compliance (WCAG 2.2)
- Performance metrics collection

**C. User Journey Testing**
- Complete user workflows
- Error state handling
- Loading state validation
- Multi-step form processes

#### MCP Commands for UI Testing
```javascript
// Use natural language with Playwright MCP:
// "Create a test that validates the login form"
// "Test the user registration flow end-to-end"
// "Verify mobile responsiveness of the dashboard"
// "Check accessibility compliance for the form"
```

### 3.4 Quality Gates

**Before Each Commit:**
- [ ] All tests passing (GREEN)
- [ ] Code coverage targets met
- [ ] UI validation with Playwright complete
- [ ] No TypeScript errors
- [ ] Linting passes
- [ ] Performance benchmarks acceptable

**Human Review Checkpoints:**
⚠️ **STOP FOR HUMAN REVIEW** when:
- Tests reveal design flaws or missing requirements
- Implementation requires architectural changes
- Performance issues discovered during testing
- Accessibility concerns identified
- Security implications found in testing

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

## Phase 4: Final Quality Validation

### 4.1 Comprehensive Test Suite Execution

```bash
# Run full test suite (should already be passing from TDD)
npm test                    # Unit and integration tests
npm run test:e2e           # End-to-end Playwright tests  
npm run test:coverage      # Verify coverage targets
npm run test:accessibility # Accessibility compliance tests
```

### 4.2 Code Quality Validation

```bash
# Automated quality checks
npm run lint               # ESLint for code quality
npm run typecheck         # TypeScript strict checking
npm run format            # Prettier formatting
uv run ruff check         # Python linting (if applicable)
uv run mypy .            # Python type checking (if applicable)
```

### 4.3 Playwright MCP Final Validation

Use Playwright MCP for comprehensive final validation:

**Cross-Browser Testing**
- Test on Chrome, Firefox, Safari
- Validate mobile and desktop viewports
- Check touch interactions on mobile

**Performance Validation**
- Measure page load times
- Check Core Web Vitals
- Validate lazy loading behavior

**Accessibility Final Check**
- Screen reader compatibility
- Keyboard navigation validation
- Color contrast verification
- ARIA labels and roles

### 4.4 Manual Review Checklist

Since tests were written first, manual testing should confirm:
- [ ] All acceptance criteria met (should be covered by tests)
- [ ] User experience flows smoothly
- [ ] Visual design matches specifications
- [ ] Performance meets requirements
- [ ] No console errors or warnings

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

### 6.1 Final Implementation Commit

```bash
# Ensure all tests are still passing
npm test && npm run test:e2e

# Stage final implementation
git add .

# Create comprehensive final commit
git commit -m "feat: Complete implementation for issue #$ARGUMENTS

✅ TDD Workflow Summary:
- Tests written first and committed (RED phase)
- Implementation follows test requirements (GREEN phase)  
- Code refactored for quality (REFACTOR phase)
- Playwright MCP validation completed
- All quality gates passed

🧪 Test Coverage:
- Unit tests: [X]% coverage
- Integration tests: Complete API flows
- E2E tests: Full user journeys with Playwright
- Accessibility tests: WCAG 2.2 compliant

🎯 Quality Validation:
- All tests passing
- TypeScript strict mode clean
- Linting and formatting applied
- Cross-browser compatibility verified
- Performance benchmarks met

Closes #$ARGUMENTS"
```

### 6.2 Create Pull Request

Use @create-pr.md for standardized PR creation:

```bash
# Follow PR creation guidelines from @create-pr.md
# Include comprehensive testing summary
```

### 6.3 Enhanced PR Content Requirements

**Required PR Content:**
- **Link**: "Closes #$ARGUMENTS"
- **TDD Summary**: Overview of test-first approach used
- **Test Coverage**: Unit, integration, and E2E test results
- **Playwright Validation**: UI testing and accessibility results
- **Quality Metrics**: Performance, coverage, and compliance data
- **Screenshots/Videos**: For UI changes (captured via Playwright)
- **Breaking Changes**: Any API or interface changes
- **Migration Steps**: Database or configuration changes needed

**Playwright Test Evidence:**
- Include automated screenshots from Playwright tests
- Cross-browser compatibility results
- Mobile responsiveness validation
- Accessibility compliance report

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

## Quality Standards Checklist (Test-First Approach)

**TDD Workflow Compliance**

- [ ] Tests written before implementation (RED phase)
- [ ] Initial failing tests committed first
- [ ] Implementation makes tests pass (GREEN phase)
- [ ] Code refactored while keeping tests green (REFACTOR phase)
- [ ] Multiple commit cycle followed (test → commit → code → commit)

**Code Quality**

- [ ] All files under 300 lines
- [ ] Single responsibility principle followed
- [ ] Existing patterns and utilities used
- [ ] Proper error handling implemented
- [ ] No hardcoded values or magic numbers
- [ ] TypeScript strict mode compliance

**Comprehensive Testing**

- [ ] **Unit Tests**: All business logic covered (>90% coverage)
- [ ] **Integration Tests**: API endpoints and data flows tested
- [ ] **E2E Tests**: Complete user journeys with Playwright MCP
- [ ] **Accessibility Tests**: WCAG 2.2 compliance verified
- [ ] **Performance Tests**: Load times and Core Web Vitals measured
- [ ] **Cross-Browser Tests**: Chrome, Firefox, Safari validated
- [ ] All tests passing with no flakiness

**Playwright MCP Validation**

- [ ] UI functionality tested via natural language commands
- [ ] Mobile responsiveness validated
- [ ] Form interactions and validations tested
- [ ] Error states and loading states verified
- [ ] Accessibility compliance automated testing
- [ ] Screenshots/videos captured for PR documentation

**Documentation & Communication**

- [ ] Code comments for complex logic
- [ ] API documentation updated
- [ ] User-facing changes documented
- [ ] Migration guides provided (if needed)
- [ ] Test strategy documented in PR
- [ ] Playwright test results included

**Performance & Accessibility**

- [ ] **WCAG 2.2 Guidelines**: Automated and manual validation
- [ ] **Keyboard Navigation**: Full keyboard accessibility
- [ ] **Screen Reader**: Compatible with assistive technologies
- [ ] **Performance**: No regressions, efficient algorithms
- [ ] **Bundle Size**: Minimal impact on application size
- [ ] **Core Web Vitals**: LCP, FID, CLS within targets

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
