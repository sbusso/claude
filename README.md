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

### One-Liner Installation

```bash
# Install directly in your project directory
curl -sSL https://raw.githubusercontent.com/sbusso/claude-workflow/main/install.sh | bash
```

That's it! The installer will:
- Set up shell integration with command aliases
- Install the complete workflow framework in your project
- Configure MCPs (Context7, Playwright, GitHub)
- Track installation version to avoid redundant installs
- Provide setup instructions for GitHub Projects

**Smart Installation Features**:
- **Version Tracking**: Skips installation if already up-to-date
- **Claude-Powered Merging**: Uses Claude's intelligence for semantic file merging
- **Intelligent Conflict Resolution**: Preserves project-specific content while adding framework features
- **Backup Protection**: Creates timestamped backups before modifications
- **Fallback Safety**: Basic merge when Claude not available
- **Force Reinstall**: `rm ~/.claude/.framework_version && curl -sSL ... | bash`

### Alternative: Manual Installation

```bash
# Clone this repository first
git clone https://github.com/sbusso/claude-workflow.git
cd claude-workflow

# Then run installer in your target project
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

## Quick Start After Installation

After running the one-liner installer, follow these steps:

### 1. Activate Shell Integration
```bash
source ~/.zshrc
cchelp  # See all available commands
```

### 2. Set Up GitHub Projects (One-Time)
```bash
# Grant GitHub CLI project permissions
gh auth refresh -s project --hostname github.com

# Create workflow labels in your repository
.claude/utils/setup-labels.sh
```

### 3. Configure GitHub Project
In your GitHub Project, ensure you have:
- **Status field**: Todo, In Progress, Done
- **Iteration field**: For sprint planning
- **Automations enabled**: Auto-close issues when PR merged

### 4. Start Using the Workflow
```bash
# In Claude Code REPL
/project:feature "add user authentication system"
/project:tasks "User Authentication System"
/project:do-issue 123
/project:commit "implement login endpoint"
/project:create-pr

# Using shell aliases
ccf "add user authentication system"    # create feature
cct "User Authentication System"       # create tasks  
cci 123                                # implement issue
ccc "implement login endpoint"         # create commit
ccpr                                   # create PR
```

## Core Workflow

### 1. Planning Phase
- **/project:feature** - Create features with extended thinking analysis
- **/project:tasks** - Break features into implementable tasks with iteration assignment

### 2. Implementation Phase  
- **/project:do-issue** - Smart test-first development with lean TDD
- **/project:commit** - Semantic commits with proper formatting
- **/project:create-pr** - Standardized pull request creation

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

## Command Usage

### Two Ways to Run Commands

**1. Claude Code REPL (Recommended)**
```bash
# Direct project commands
/project:feature "description"
/project:do-issue 123
```

**2. Shell Aliases (After Installation)**
```bash
# Generic command runner  
ccmd feature "description"
ccmd do-issue 123

# Or use aliases
ccf "description"  # feature
cci 123           # do-issue
```

## Available Tools

### Shell Commands
```bash
ccf "feature description"    # Create feature
cct "feature name"           # Create tasks  
cci 123                      # Implement issue
ccfi 123                     # Fix issue
ccc "commit message"         # Create commit
ccpr                         # Create PR
ccb "brainstorm topic"       # Brainstorm ideas
ccw                          # Create worktrees
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

## Troubleshooting

### Installation Issues

**"Command not found" after installation:**
```bash
source ~/.zshrc  # Reload shell configuration
```

**"Permission denied" on utilities:**
```bash
chmod +x .claude/utils/*.sh  # Make scripts executable
```

**"Missing project scope" error:**
```bash
gh auth refresh -s project --hostname github.com  # Grant project permissions
```

### GitHub Projects Issues

**"Label not found" errors:**
```bash
.claude/utils/setup-labels.sh  # Create required labels
```

**"Project not found":**
- Check project exists: `gh project list`
- Verify repository connection to project
- Run `.claude/utils/get-project-config.sh` to refresh config

### MCP Issues

**MCPs not working:**
- Ensure Claude Code is installed
- Check `.mcp.json` exists in project
- Try: `claude mcp list` to see installed servers

### Smart Merge Issues

**Claude merge failed:**
- Installation falls back to basic append merge
- Check backup files (`*.backup.*`) for original content
- Manually refine using: `/project:smart-merge CLAUDE.md CLAUDE.md.backup.* CLAUDE.md`
- Or use utility: `.claude/utils/smart-merge.sh claude-md CLAUDE.md framework.md`

**Merge quality concerns:**
- Use manual `/project:smart-merge` command for better control
- Or run utility script: `.claude/utils/smart-merge.sh`
- Review merged content and adjust as needed
- Framework preserves your project-specific content
- Use backup files to restore if unsatisfied with merge

**MCP configuration conflicts:**
- Claude intelligently merges JSON configurations
- Check `.mcp.json.backup.*` for your original configuration
- Framework adds: context7, playwright, github servers
- Manual merge available if automatic merge fails

## Contributing

Found a bug or want to improve the framework? 

1. Create an issue describing the problem
2. Fork and create a feature branch
3. Test your changes with the actual workflow
4. Submit a PR with clear description

## License

MIT - Use this framework in any project, commercial or personal.