# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a **template repository** for managing Claude Code enhancements. It provides:

- **Command Templates**: Reusable command definitions for common development tasks
- **Installation Scripts**: Automated setup for shell integration across projects
- **Code Guidelines**: Language-specific development standards and best practices
- **Project Templates**: Boilerplate generators for new project setups

This repository is the **source of truth** for Claude Code productivity tools that get installed into other projects.

## Repository Structure

```
.claude/
├── commands/
│   ├── plan/              # Planning and design commands
│   │   ├── brainstorm.md  # Brainstorming sessions with extended thinking
│   │   ├── feature.md     # Feature creation with GitHub Projects integration
│   │   └── tasks.md       # Task breakdown and iteration planning
│   └── do/                # Execution commands
│       ├── commit.md      # Git commit workflow with semantic messages
│       ├── create-pr.md   # Pull request creation with templates
│       ├── fix-issue.md   # Issue resolution workflow
│       └── do-issue.md    # Implementation workflow with status management
├── utils/                 # Workflow automation utilities
│   ├── get-project-config.sh    # Auto-discover GitHub project configuration
│   ├── move-item-status.sh      # Move items between project statuses
│   ├── assign-iteration.sh      # Assign items to project iterations
│   └── setup-labels.sh          # Create required workflow labels
├── contexts/             # Language-specific coding standards and contexts
│   ├── python.md         # Python development guidelines (uv, FastAPI)
│   ├── typescript.md     # TypeScript development guidelines (bun, TanStack)
│   └── react.md          # React + TypeScript guidelines (2025 best practices)
├── templates/            # Project templates and boilerplates
│   └── ISSUE-TEMPLATE.md # GitHub issue template
├── settings.json         # Claude Code configuration
├── project-config.json   # Auto-generated project configuration cache
└── .mcp.json            # Model Context Protocol server configuration
install.sh                # Shell integration installer with MCP setup
```

## Command Development Workflow

### Adding New Commands
1. Create new `.md` file in appropriate subdirectory (`plan/` or `do/`)
2. Follow command template structure with clear argument handling
3. Include usage examples and expected outputs
4. Test command functionality before committing

### Updating Existing Commands
1. Maintain backward compatibility with `$ARGUMENTS` variable
2. Update documentation and examples
3. Test changes across different project types

### Command Structure Standards
- Use `$ARGUMENTS` for user input capture
- Include clear task descriptions and expected outcomes
- Provide error handling and validation steps
- Follow consistent markdown formatting

## Installation Management

### install.sh Maintenance
- Update shell integration commands as needed
- Maintain compatibility with zsh environment
- Handle existing installation detection and updates
- Provide clear user feedback during installation

### Testing Installation
- Test on clean environment without existing Claude setup
- Test update scenarios with existing installations
- Verify all command aliases work correctly after installation

## Context Management

### Updating Contexts
- Keep contexts current with latest best practices
- Maintain consistency between language-specific guides
- Update package management recommendations (uv for Python, bun for Node.js)
- Ensure 300-line file limit is consistently enforced

### Adding New Language Contexts
- Follow existing structure and format
- Include package management, project setup, and best practices
- Provide clear examples and command references
- Integrate with existing command system

## Quality Standards

### Command Quality
- All commands must be thoroughly tested
- Include proper error handling and user feedback
- Maintain consistent argument parsing and output formatting
- Provide clear usage documentation

### Documentation Standards
- Keep all documentation current and accurate
- Use consistent markdown formatting
- Include practical examples and use cases
- Maintain clear separation between template content and instructions

## GitHub Projects Workflow System

This template provides a complete GitHub Projects-based development workflow with automation utilities:

### Complete Workflow Process
1. **@feature.md** - Create features in backlog with extended thinking for complex requirements
2. **@tasks.md** - Break down features into implementable tasks with iteration assignment
3. **@do-issue.md** - Implement tasks with status management and branch creation
4. **GitHub Automation** - PR merge automatically moves tasks to "Done" and closes issues

### GitHub Projects Status Flow
- **Todo** (Backlog): Features awaiting planning, tasks ready for implementation
- **In Progress**: Tasks being actively implemented
- **Done**: Completed tasks (auto-set when PRs merged, auto-closes issues)

### Workflow Automation Utilities
The `.claude/utils/` directory contains automation scripts:
- **`get-project-config.sh`** - Auto-discovers project configuration (fields, iterations, options)
- **`move-item-status.sh <issue> <status>`** - Moves items between project statuses
- **`assign-iteration.sh <issue> <iteration>`** - Assigns items to project iterations  
- **`setup-labels.sh`** - Creates required workflow labels for repositories

### Extended Thinking Integration
Commands use extended thinking prompts for complex scenarios:
- **Feature creation**: "Think deeply about this feature request..."
- **Task planning**: "Think deeply about breaking down this feature..."
- **Implementation**: "Think deeply about implementing this issue..."

### Tested Workflow Example
✅ **Fully tested end-to-end workflow:**
- Feature #4: User Authentication System
- Tasks: #5 (Backend), #6 (Frontend), #7 (Security), #8 (Testing)
- Status transitions: Backlog → Todo → In Progress → Done
- All utilities working with real GitHub Projects integration

## Model Context Protocol (MCP) Integration

The framework includes pre-configured MCP servers for enhanced functionality:

### Included MCP Servers
- **Context7**: Up-to-date documentation for any library or framework
- **Playwright**: Browser automation and testing capabilities  
- **GitHub**: Enhanced repository and API integration

### MCP Configuration
MCP servers are defined in `.mcp.json` and automatically installed by `install.sh`:

```json
{
  "servers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "description": "Up-to-date documentation for any library or framework"
    },
    "playwright": {
      "command": "npx", 
      "args": ["@playwright/mcp@latest"],
      "description": "Browser automation and testing with Playwright"
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "description": "GitHub repository integration and API access"
    }
  }
}
```

### Usage Examples
- **Context7**: Add `use context7` to any prompt for current documentation
- **Playwright**: Browser automation for testing GitHub Projects workflow
- **GitHub**: Enhanced GitHub API access and repository management

### MCP Scope
MCPs are installed with `--scope project` so they're available to all users of the template but isolated per project.

## Sub-Task Usage Guidelines

When working on complex tasks that require multiple independent operations, use the **Task tool** to spawn sub-agents:

### When to Use Sub-Tasks
- **Workflow Testing**: Testing complete feature → planning → implementation flows
- **Multi-Repository Operations**: When work spans multiple repositories or projects
- **Parallel Task Execution**: When multiple independent tasks can be done simultaneously
- **Complex Automation**: When testing or executing complex workflows end-to-end
- **Isolation Required**: When testing should not affect current working state

### Sub-Task Best Practices
```
Task(
  description="Brief 3-5 word description",
  prompt="Detailed instructions with:
    - Specific steps to execute
    - Expected outputs/results to report back
    - Context about the current project state
    - Clear success criteria"
)
```

### Sub-Task Guidelines
- **Be Specific**: Provide detailed step-by-step instructions
- **Include Context**: Sub-agents need full context about project state
- **Define Success**: Clearly state what constitutes successful completion
- **Report Results**: Ask sub-agents to provide comprehensive status reports
- **Use for Testing**: Ideal for testing workflows without affecting main agent state

### Example Usage
Successfully used sub-tasks for:
- ✅ Testing feature creation workflow (created issue #4)
- ✅ Testing planning workflow (created tasks #5-#9)  
- ✅ Testing implementation workflow (status transitions, branch creation)
- ✅ Validating end-to-end GitHub Projects integration

## GitHub Projects Setup Requirements

To use the workflow automation system, projects need:

### Required GitHub CLI Setup
```bash
# Ensure GitHub CLI has project scope
gh auth refresh -s project --hostname github.com

# Verify access to projects
gh project list --owner [USERNAME]
```

### Required Labels
Run the setup utility to create workflow labels:
```bash
.claude/utils/setup-labels.sh
```

### Required Project Fields
GitHub Projects should have these fields:
- **Status**: Single select with options: Todo, In Progress, Done
- **Iteration**: Iteration field with current and future iterations
- **Priority**: Single select (optional, recommended: P0, P1, P2)
- **Size**: Single select (optional, recommended: XS, S, M, L, XL)

### Auto-Configuration System
- **Auto-discovery**: Run `.claude/utils/get-project-config.sh [project-name]` to discover configuration
- **Caching**: Configuration cached in `project-config.json` for fast utility access
- **Project targeting**: Pass project name as argument, defaults to "Test"
- **Updates**: Re-run configuration discovery when project structure changes

### GitHub's Built-in Automations
Enable these default workflows in your GitHub Project:
- ✅ Auto-set status to "Done" when PR merged
- ✅ Auto-close issues when status = "Done"  
- ✅ Auto-set status to "Todo" when items added

## Maintenance Tasks

- Regular review and update of command templates
- Testing installation script across different environments  
- Updating code guidelines with current best practices
- Expanding command library based on common development patterns
- Ensuring all templates remain current and functional
- Testing workflow automation utilities with new GitHub features
- Updating project configuration discovery for GitHub API changes
- Maintaining MCP server configurations and versions