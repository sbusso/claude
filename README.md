# Claude Code Workflow Framework

A lean, practical development workflow framework for Claude Code with GitHub Projects integration and smart testing approach.

## Overview

This framework provides a complete development workflow that emphasizes:
- **Move fast, test smart, keep it simple**
- **GitHub Projects integration** for automated planning and tracking
- **Smart test-first development** that tests what matters
- **Lean TDD approach** without over-engineering
- **Automated workflow utilities** for common tasks

## Quick Install

### For New Projects

```bash
# Install directly in your project directory
curl -sSL https://raw.githubusercontent.com/sbusso/claude-workflow/main/install.sh | bash

# Follow the setup instructions that appear
```

### From Template Repository

```bash
# Clone this repository
git clone https://github.com/sbusso/claude-workflow.git
cd claude-workflow

# Run installer in your target project
cd /path/to/your/project
/path/to/claude-workflow/install.sh
```

## What Gets Installed

✅ **Project CLAUDE.md** - Workflow documentation for your project  
✅ **Core Commands** - Planning and implementation workflows (@feature, @tasks, @do-issue)  
✅ **Automation Utilities** - GitHub Projects status management and label setup  
✅ **Code Guidelines** - Python, TypeScript, and React 2025 best practices  
✅ **MCP Integration** - Context7, Playwright, and GitHub servers  
✅ **Shell Aliases** - Quick command shortcuts (cci, cfi, etc.)

## Quick Start

1. **Install and source shell integration:**
   ```bash
   source ~/.zshrc
   cchelp  # See available commands
   ```

2. **Set up GitHub Projects (one-time setup):**
   ```bash
   gh auth refresh -s project --hostname github.com
   .claude/utils/setup-labels.sh
   ```

3. **Start developing:**
   ```bash
   @feature "add user authentication"
   @tasks "User Authentication System"  
   @do-issue 123
   ```

## Core Workflow

### 1. Planning Phase
- **@feature** - Create features with extended thinking analysis
- **@tasks** - Break features into implementable tasks with iteration assignment

### 2. Implementation Phase  
- **@do-issue** - Smart test-first development with lean TDD
- **@commit** - Semantic commits with proper formatting
- **@create-pr** - Standardized pull request creation

### 3. Automated Management
- **GitHub Projects status tracking** (Todo → In Progress → Done)
- **Automatic issue closure** when PRs merge
- **Iteration assignment** for sprint planning

## Smart Testing Philosophy

**Test what matters, skip what doesn't.**

### Test These:
- Core business logic and API contracts
- Critical user flows (login, checkout, etc.)
- Bug reproductions before fixing
- Main happy path + one error case

### Skip These:
- Trivial getters/setters
- Framework/library code
- One-off scripts  
- Pure UI styling

### Lean TDD Cycle:
1. Write minimal test for core functionality
2. Commit failing test
3. Make it pass with simplest code
4. Commit working code
5. Refactor only if needed

## Code Quality Standards

- **300-line file limit** - Keep components focused
- **uv for Python, bun for Node.js** - Modern package management
- **TypeScript strict mode** - Catch errors early
- **Smart documentation** - Comment complex logic, document breaking changes

## Available Tools

### Shell Commands
```bash
cci "feature description"    # Create issue  
cfi 123                      # Fix issue
cco "code"                   # Optimize code
ccr "code"                   # Review code
cct "code"                   # Generate tests
```

### Workflow Utilities
```bash
.claude/utils/setup-labels.sh              # Create GitHub labels
.claude/utils/move-item-status.sh 123 done # Manage status
.claude/utils/assign-iteration.sh 123 current # Assign iteration
```

### MCPs (Model Context Protocol)
- **Context7**: `use context7` for up-to-date documentation
- **Playwright**: Browser automation and testing
- **GitHub**: Enhanced repository integration

## GitHub Projects Setup

### Required Project Fields:
- **Status**: Todo, In Progress, Done
- **Iteration**: Current and future iterations

### Required Automations:
- ✅ Auto-set status to "Done" when PR merged
- ✅ Auto-close issues when status = "Done"  
- ✅ Auto-set status to "Todo" when items added

### Labels Created:
`feature`, `backlog`, `task`, `planned`, `in-progress`, `ready-for-review`, `research`, `design`

## Framework Structure

```
your-project/
├── CLAUDE.md                    # Project workflow documentation
├── .mcp.json                    # MCP server configuration
└── .claude/
    ├── commands/                # Workflow commands (@feature, @tasks, @do-issue)
    ├── utils/                   # GitHub Projects automation scripts
    ├── code-guidelines/         # Python, TypeScript, React standards
    └── project-config.json      # Auto-discovered GitHub config
```

## Philosophy

**Move fast, test smart, keep it simple.**

This framework is designed for teams who want to:
- Ship features quickly without sacrificing quality
- Use automation to handle repetitive tasks
- Focus testing effort on what actually matters
- Maintain clean, readable code without over-engineering
- Integrate naturally with GitHub's project management tools

## Contributing

Found a bug or want to improve the framework? 

1. Create an issue describing the problem
2. Fork and create a feature branch
3. Test your changes with the actual workflow
4. Submit a PR with clear description

## License

MIT - Use this framework in any project, commercial or personal.