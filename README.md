# Claude Code Workflow Framework

A synchronized workspace installer for Claude Code that provides consistent development workflows across all your projects.

## Overview

This installer sets up a **synchronized Claude Code workspace** that:
- **Syncs across all projects** - One workspace, shared everywhere
- **Pure memory + settings approach** - No file copying, just git sync
- **Native Claude Code integration** - Uses built-in memory and settings systems
- **Two-way synchronization** - Share improvements back to the framework

## Architecture

### Two Repository System
1. **claude-workflow** (this repo) - Installer script only
2. **[dotclaude](https://github.com/sbusso/dotclaude)** - Shared workspace that syncs to `.claude/`

### How It Works
- `.claude/` in each project is a git repository synced with dotclaude
- Project `CLAUDE.md` imports framework memory: `@.claude/memory/workflow.md`
- MCP configuration lives in `.claude/settings.json` (shared)
- Local overrides use `*.local.*` files (ignored by git)

## Quick Install

### One-Liner Installation

```bash
curl -sSL https://raw.githubusercontent.com/sbusso/claude-workflow/main/install.sh | bash
```

The installer will:
- Install shell integration with command aliases
- Clone the dotclaude workspace to `.claude/`
- Create minimal project `CLAUDE.md` with workflow import
- Set up MCP integration (Context7, Playwright, GitHub)
- Configure proper gitignore for local files

### What Gets Created

**In your project:**
```
your-project/
├── CLAUDE.md                    # Imports @.claude/memory/workflow.md
├── .claude/                     # Git repo synced with dotclaude
│   ├── commands/               # Planning & implementation commands
│   ├── memory/                 # Workflow context and guidelines
│   ├── settings.json           # MCP config & permissions (shared)
│   ├── settings.local.json     # Your personal overrides (ignored)
│   ├── utils/                  # GitHub Projects automation
│   └── templates/              # Project templates
└── .claude-config.json          # Project-specific configuration
```

## Core Workflow

### Planning Commands
- `/project:feature "description"` - Create feature issues with analysis
- `/project:breakdown 123` - Break features into implementation tasks  
- `/project:implement "tech task"` - Direct technical implementation planning
- `/project:brainstorm "problem"` - Critical thinking problem exploration

### Implementation Commands  
- `/project:do-issue 123` - Smart test-first development
- `/project:commit "message"` - Semantic commits
- `/project:create-pr` - Standardized pull requests

### Shell Aliases
```bash
ccf "feature description"    # Create feature
ccbd 123                    # Break down feature  
ccim "add CORS support"     # Implement technical task
cci 123                     # Implement issue
ccc "commit message"        # Create commit
ccpr                        # Create PR
ccb "problem"               # Brainstorm
ccsync                      # Pull workspace updates
ccpush                      # Push workspace improvements
```

## Workspace Synchronization

### Pull Updates
```bash
ccsync                      # Shell alias
# or
cd .claude && git pull origin main
```

### Push Improvements  
```bash
ccpush                      # Shell alias
# or  
cd .claude && git add . && git commit -m "improve: description" && git push
```

### Framework Updates
When the dotclaude repository is updated:
1. All projects can `ccsync` to get latest commands/guidelines
2. New memory files and utilities automatically available
3. MCP configuration stays current across projects

## Memory System

Claude Code automatically loads memory files:

**Project Memory (tracked):**
```markdown
# CLAUDE.md
@.claude/memory/workflow.md

## Project-Specific Context
Add your project instructions here.
```

**Framework Memory (synced):**
- `.claude/memory/workflow.md` - Core workflow commands and aliases
- `.claude/memory/project-setup.md` - Package manager guidelines
- Additional memory files for specific contexts

## Settings & MCP

**Shared Configuration (`.claude/settings.json`):**
- MCP server definitions
- Shared permissions
- Framework defaults

**Local Overrides (`.claude/settings.local.json`):**
- Personal preferences
- Environment-specific settings
- Authentication tokens

Example MCP setup:
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp"]
    },
    "github": {
      "command": "npx", 
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": ""
      }
    }
  }
}
```

## Development Philosophy

**Move fast, test smart, keep it simple.**

- **Test what matters** - Core business logic and critical user flows
- **Skip trivial tests** - Getters, framework code, styling
- **300-line file limit** - Keep components focused
- **Modern tooling** - uv for Python, bun for Node.js
- **Smart automation** - Let GitHub Projects handle tracking

## GitHub Projects Integration

### Setup (One-Time)
```bash
# Grant GitHub CLI project permissions
gh auth refresh -s project --hostname github.com

# Create workflow labels
.claude/utils/setup-labels.sh

# Configure project integration
.claude/utils/get-project-config.sh
```

### Required Project Fields
- **Status**: Todo, In Progress, Done  
- **Iteration**: For sprint planning

### Automation Utilities
```bash
.claude/utils/move-item-status.sh 123 done
.claude/utils/assign-iteration.sh 123 current
```

## Contributing to Framework

To improve the shared workspace:

1. **Make changes** in any project's `.claude/` directory
2. **Test locally** with your workflow
3. **Push improvements**:
   ```bash
   cd .claude
   git add .
   git commit -m "improve: description of changes"
   git push origin main
   ```
4. **Changes sync** to other projects on next `ccsync`

## Troubleshooting

### Installation Issues
```bash
# Reload shell after install
source ~/.zshrc

# Force reinstall
rm -rf .claude && ./install.sh --force

# Check workspace sync
cd .claude && git status
```

### Workspace Sync Issues
```bash
# Reset workspace
rm -rf .claude
git clone https://github.com/sbusso/dotclaude.git .claude

# Fix sync conflicts
cd .claude && git stash && git pull && git stash pop
```

### Missing Commands
```bash
# Check memory loading
/memory

# Verify command files exist
ls .claude/commands/*/

# Restart Claude Code to reload memory
```

## Repositories

- **Installer**: https://github.com/sbusso/claude-workflow
- **Workspace**: https://github.com/sbusso/dotclaude
- **Issues**: https://github.com/sbusso/claude-workflow/issues

## License

MIT - Use this framework in any project, commercial or personal.