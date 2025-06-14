# CLAUDE.md

This file provides guidance to Claude Code when working with this project.

## Development Workflow

This project uses a streamlined GitHub Projects workflow with Claude Code automation:

### Planning Phase
- **/project:feature** - Create feature GitHub issues with extended thinking analysis
- **/project:breakdown** - Break features into implementable tasks assigned to current iteration
- **/project:implement** - Direct technical implementation planning (skips feature analysis)
- **/project:brainstorm** - Critical thinking brainstorming for problem exploration

### Implementation Phase  
- **/project:do-issue** - Smart test-first development with lean TDD approach
- **/project:commit** - Semantic commits with proper formatting
- **/project:create-pr** - Standardized pull request creation

### GitHub Projects Integration
- **Status Flow**: Todo → In Progress → Done (auto-managed)
- **Iteration Assignment**: Tasks automatically assigned to current iteration
- **Label Management**: Automated workflow labels and status tracking

## Development Standards

### Package Management
- **Python**: Use `uv` for dependencies and script running
- **Node.js**: Use `bun` instead of npm for all operations
- **TypeScript**: Strict mode enabled, follow project conventions

### Code Quality
- **File Size Limit**: Maximum 300 lines per file
- **Testing Strategy**: Test what matters - core business logic and critical user flows
- **Linting**: Always run lint checks before committing
- **Documentation**: Comment complex logic, document breaking changes

### Framework Guidelines
- **Python**: FastAPI, Pydantic, 300-line limit (see `.claude/code-guidelines/python.md`)
- **TypeScript**: TanStack Router, shadcn/ui (see `.claude/code-guidelines/typescript.md`) 
- **React**: React 19, Server Components, modern patterns (see `.claude/code-guidelines/react.md`)

## Smart Testing Philosophy

### Test What Matters
- **New features**: Test main happy path + one error case
- **Bug fixes**: Write test that reproduces bug, then fix
- **UI changes**: Quick Playwright test for critical user flows
- **Refactoring**: Existing tests should continue passing

### Skip Tests For
- Trivial getters/setters
- Framework/library code  
- One-off scripts
- Pure UI styling

### Lean TDD Cycle
1. **Write minimal test** for core functionality
2. **Commit failing test**: `git commit -m "test: reproduce issue #X"`
3. **Make it pass** with simplest code
4. **Commit working code**: `git commit -m "feat: fix issue #X"`
5. **Refactor if needed** (only if messy)

## Available Tools & MCPs

### Model Context Protocol Servers
- **Context7**: Add `use context7` for up-to-date documentation
- **Playwright**: Browser automation and UI testing
- **GitHub**: Enhanced repository and project management

### Workflow Utilities
Located in `.claude/utils/`:
- **setup-labels.sh** - Create required GitHub workflow labels
- **get-project-config.sh** - Auto-discover project configuration
- **move-item-status.sh** - Manage GitHub Projects item status
- **assign-iteration.sh** - Assign items to project iterations

## GitHub Projects Setup

### Step 1: Create GitHub Project
```bash
# 1. Go to your repository on GitHub.com
# 2. Click "Projects" tab → "Link a project" → "New project"
# 3. Choose "Table" view
# 4. Name it (e.g., "Development Workflow")
```

### Step 2: Configure Project Fields
Add these required fields to your project:

**Status Field** (Single select):
- Todo
- In Progress  
- Done

**Iteration Field** (Iteration):
- Create iterations for your development cycles
- Mark one as "Current" for active work

### Step 3: Setup Repository Integration
```bash
# Ensure GitHub CLI has project access
gh auth refresh -s project --hostname github.com

# Create workflow labels (run once per repository)
.claude/utils/setup-labels.sh

# Configure project (choose one):
.claude/utils/get-project-config.sh                    # Auto-detect if single project
.claude/utils/get-project-config.sh "My Project"       # Specify by name
.claude/utils/get-project-config.sh 5                  # Specify by number
```

### Step 4: Enable Project Automations
In your GitHub Project settings, enable:
- ✅ Auto-set status to "Done" when PR merged
- ✅ Auto-close issues when status = "Done"
- ✅ Auto-set status to "Todo" when items added

### Project Configuration
The framework auto-discovers your GitHub Project:
- **Auto-detection**: Finds project linked to your repository
- **Field mapping**: Maps Status and Iteration fields automatically
- **Caching**: Stores configuration in `project-config.json` for speed

## Command Reference

### Quick Start Commands
```bash
# Planning workflows
/project:feature "add user authentication system"           # Complex features
/project:implement "add CORS support to API"                # Direct technical tasks
/project:brainstorm "users need better search"              # Problem exploration

# Break down planned feature into tasks
/project:breakdown 123                                      # Feature issue #123

# Implementation workflow
/project:do-issue 124                                       # Implement task #124
/project:commit "implement user login endpoint"             # Semantic commit
/project:create-pr                                          # Create pull request

# Using shell aliases (after install.sh)
ccf "add user authentication system"     # feature
ccbd 123                                 # breakdown
ccim "add CORS support to API"           # implement
cci 124                                  # do-issue
ccc "implement user login endpoint"      # commit
ccpr                                     # create-pr
ccb "better search experience"           # brainstorm
```

### Project Management
```bash
# Move item status
.claude/utils/move-item-status.sh 123 in_progress

# Assign to current iteration
.claude/utils/assign-iteration.sh 123 current

# Set up project labels (one time)
.claude/utils/setup-labels.sh
```

## Quality Standards

### Basic Quality Checklist
- [ ] Feature works as expected
- [ ] Tests pass for important functionality  
- [ ] No TypeScript errors
- [ ] Files under 300 lines
- [ ] Code is readable and well-structured

### Documentation Requirements
- [ ] Complex logic has clear comments
- [ ] Breaking changes are documented
- [ ] User-facing changes have clear descriptions
- [ ] API changes include examples

## Development Philosophy

**Move fast, test smart, keep it simple.**

- Focus on building features that solve real problems
- Test the critical paths that would break user workflows
- Use automation to handle repetitive tasks
- Maintain code quality without over-engineering
- Document decisions and changes for team clarity

## Getting Help

- **Command help**: Use `@` followed by command name for usage
- **Workflow issues**: Check `.claude/utils/` scripts and GitHub Project setup
- **Code standards**: Refer to `.claude/code-guidelines/` for language-specific guidance
- **MCP usage**: Add `use [mcp-name]` to prompts for enhanced capabilities