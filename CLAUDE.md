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
│   │   ├── brainstorm.md  # Brainstorming sessions
│   │   ├── feature.md     # Feature specification generation
│   │   ├── planning.md    # Project planning workflows
│   │   └── prd.md         # Product requirements documents
│   └── do/                # Execution commands
│       ├── commit.md      # Git commit workflow with semantic messages
│       ├── create-pr.md   # Pull request creation with templates
│       ├── fix-issue.md   # Issue resolution workflow
│       └── do-issue.md    # Issue handling automation
├── code-guidelines/       # Language-specific coding standards
│   ├── python.md         # Python development guidelines
│   └── typescript.md     # TypeScript/React guidelines
├── templates/            # Project templates and boilerplates
│   └── ISSUE-TEMPLATE.md # GitHub issue template
└── settings.json         # Claude Code configuration
install.sh                # Shell integration installer
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

## Code Guidelines Management

### Updating Guidelines
- Keep guidelines current with latest best practices
- Maintain consistency between language-specific guides
- Update package management recommendations (uv for Python, bun for Node.js)
- Ensure 300-line file limit is consistently enforced

### Adding New Language Guidelines
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

## Planning Workflow

This template provides a complete GitHub Projects-based planning workflow:

### Planning Commands Flow
1. **@brainstorm.md** - Ideation and requirements refinement (no direct output)
2. **@feature.md** - Create GitHub issues in backlog at product/user level
3. **@planning.md** - Break down backlog features into implementation tasks for iterations

### GitHub Projects Integration
- **Backlog**: Features awaiting planning (created by @feature.md)
- **Planned**: Features broken down into tasks (processed by @planning.md)
- **In Progress**: Tasks being actively implemented (handled by @do-issue.md)
- **Review/Done**: Completed work

### Automation Using GitHub CLI
- All planning commands use `gh` CLI for GitHub API integration
- Automated issue creation, labeling, and project management
- Status transitions managed through command workflows
- Manual handover between planning and implementation phases

## Maintenance Tasks

- Regular review and update of command templates
- Testing installation script across different environments  
- Updating code guidelines with current best practices
- Expanding command library based on common development patterns
- Ensuring all templates remain current and functional
- Maintaining GitHub Projects workflow automation