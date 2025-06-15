# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a **template repository** for Claude Code local todo system. It provides:

- **Slash Commands**: Context-aware command definitions for development workflows
- **Local Todo System**: File-based project management with hierarchical task organization
- **Project Templates**: Context-aware templates for different project types
- **Zero Installation**: Just copy `.claude/` directory to any project and start using

This repository contains a complete Claude Code setup that works by simply copying the `.claude/` directory to any project.

## Repository Structure

```
.claude/
├── commands/
│   ├── plan/                    # Planning and design slash commands
│   │   ├── brainstorm.md        # /project:plan:brainstorm - Extended thinking sessions
│   │   ├── prd.md              # /project:plan:prd - Product Requirements Documents
│   │   ├── feature.md          # /project:plan:feature - Technical feature planning
│   │   └── tasks.md            # /project:plan:tasks - Task breakdown with hierarchy
│   ├── do/                     # Execution slash commands
│   │   ├── task.md             # /project:do:task - Execute specific tasks
│   │   ├── commit.md           # /project:do:commit - Git commit workflow
│   │   ├── changelog.md        # /project:do:changelog - Generate changelogs
│   │   └── create-worktrees.md # /project:do:create-worktrees - Git worktree management
│   ├── setup/                  # Setup and configuration commands
│   │   └── smart-merge.md      # /project:setup:smart-merge - Intelligent file merging
│   └── project.md              # /project:current - Show current context
├── templates/                  # Context-aware project templates
│   ├── base/                   # Universal templates
│   ├── web-app/               # React/Next.js optimized templates
│   ├── api-service/           # FastAPI/Express optimized templates
│   ├── cli-tool/              # CLI application templates
│   └── saas-platform/         # Multi-service platform templates
├── todo/                      # Local todo system (auto-generated)
│   ├── templates/             # Template files for PRDs, features, tasks
│   ├── prd-001-example/       # Product Requirements Documents
│   │   ├── prd.md
│   │   ├── status.md
│   │   └── tasks/             # Hierarchical task breakdown
│   └── feature-002-example/   # Technical features
│       ├── feature.md
│       ├── status.md
│       └── tasks/
├── contexts/                  # Language-specific coding standards
│   ├── python.md             # Python development guidelines (uv, FastAPI)
│   ├── typescript.md         # TypeScript development guidelines (bun, TanStack)
│   └── react.md              # React + TypeScript guidelines (2025 best practices)
├── archive/                   # Archived systems
│   ├── github-commands/       # Former GitHub Issues workflow commands
│   └── github-utils/          # Former GitHub Projects automation scripts
├── utils/                     # Current utilities
│   ├── merge-mcp.sh          # MCP configuration merging
│   └── smart-merge.sh        # Intelligent file merging
├── settings.json             # Claude Code configuration
└── .mcp.json                # Model Context Protocol server configuration
README.md                     # Copy-and-go setup instructions
```

## Local Todo System Workflow

### **Core Slash Commands**

#### **Planning Commands**
```bash
/project:plan:prd "user authentication system"        # Create comprehensive PRD
/project:plan:feature "dark mode toggle"              # Create focused technical feature  
/project:plan:tasks "prd-001-user-auth"              # Break down into hierarchical tasks
```

#### **Execution Commands**
```bash
/project:do:task "prd-001-user-auth/tasks/1-research" # Execute specific task
/project:current                                      # Show project context
```

### **Context-Aware System**

The system automatically detects project type and adapts:

#### **Project Type Detection**
- **Web Application**: React, Next.js, frontend frameworks → Uses web-app templates
- **API Service**: FastAPI, Django, Express, Go APIs → Uses api-service templates  
- **CLI Tool**: Command-line applications → Uses cli-tool templates
- **SaaS Platform**: Multi-service architecture → Uses saas-platform templates

#### **Hierarchical Task Organization**
```
Tasks use intelligent numbering:
├── 1-research-requirements.md           # Simple sequence
├── 2-backend-implementation.md          
├── 2.1-api-endpoints.md                # Nested breakdown
├── 2.2-data-models.md
├── 3-frontend-development.md
├── 3.1-components.md
├── 3.2-integration.md
└── 4-testing-and-deployment.md
```

### **Complete Workflow Process**
1. **`/project:plan:prd`** - Create comprehensive product requirements with market research
2. **`/project:plan:feature`** - Create focused technical features for specific capabilities
3. **`/project:plan:tasks`** - Break down PRDs/features into implementable tasks with hierarchy
4. **`/project:do:task`** - Execute individual tasks with progress tracking
5. **`/project:current`** - Monitor progress and get context-aware suggestions

## Command Development Standards

### **Slash Command Structure**
- **Path Format**: `/project:category:command` (e.g., `/project:plan:prd`)
- **Parameter**: Use `$ARGUMENTS` for dynamic content
- **Documentation**: Include usage examples and clear descriptions
- **Context-Aware**: Adapt behavior based on detected project type

### **Adding New Commands**
1. Create `.md` file in appropriate subdirectory (`plan/`, `do/`, `setup/`)
2. Follow command template structure with `$ARGUMENTS` variable
3. Include usage examples and expected outputs
4. Test command functionality across different project types
5. Update this documentation

### **Template Development**
1. Create base template in `.claude/templates/base/`
2. Create project-specific variants in appropriate subdirectories
3. Use template variables: `{TITLE}`, `{DATE}`, `{PRIORITY}`, etc.
4. Test template selection and customization

## Context-Aware Features

### **Intelligent Thinking Prompts**
Commands include context-aware extended thinking based on:
- **Project Type**: Web app, API service, CLI tool, SaaS platform
- **Complexity Level**: Simple, moderate, complex
- **Command Purpose**: Research, planning, implementation, architecture

### **Smart Template Selection**
- Automatically detects project technology stack
- Selects appropriate template based on project type
- Provides project-specific guidance and best practices
- Adapts requirements and validation criteria

### **Project Context Preservation**
- Maintains working context between command executions
- Tracks recent commands and suggests next actions
- Provides intelligent defaults based on project state
- Enables seamless workflow continuation

## Migration from GitHub Issues System

### **Former GitHub Workflow** (Archived)
The repository previously used GitHub Issues and Projects for task management. These components have been moved to `.claude/archive/`:

- **GitHub Commands**: `do-issue.md`, `fix-issue.md`, `create-pr.md`
- **GitHub Utilities**: Project status management, iteration assignment, label setup
- **GitHub Integration**: Issues, Projects, automated status updates

### **Benefits of Local System**
- **No External Dependencies**: Works completely offline
- **Faster Operation**: No API calls or network dependencies
- **Flexible Organization**: Hierarchical task numbering and custom structures
- **Project Type Awareness**: Context-aware templates and thinking prompts
- **Team Collaboration**: File-based system works with any git workflow

## Quality Standards

### **Command Quality**
- All commands thoroughly tested across project types
- Include proper error handling and user feedback
- Maintain consistent argument parsing and output formatting
- Provide clear usage documentation and examples

### **Template Quality**
- Keep templates current with technology best practices
- Maintain consistency between project-type variants
- Include comprehensive sections for different use cases
- Provide clear guidance and validation criteria

### **Documentation Standards**
- Use consistent markdown formatting throughout
- Include practical examples and use cases
- Maintain clear separation between instructions and content
- Update documentation when adding or changing commands

## Model Context Protocol (MCP) Integration

### **Included MCP Servers**
- **Context7**: Up-to-date documentation for any library or framework
- **Playwright**: Browser automation and testing capabilities  
- **GitHub**: Enhanced repository and API integration

### **MCP Configuration**
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

## Usage Instructions

### Copy-and-Go Setup
1. **Copy** the `.claude/` directory to any project
2. **Start using** slash commands immediately
3. **No installation** or configuration required

### Example Usage
```bash
# Copy to your project
cp -r /path/to/this-repo/.claude/ /path/to/your-project/

# Start using commands
/project:plan:prd "user authentication system"
/project:plan:feature "dark mode toggle"
/project:current
```

## Maintenance Tasks

- Regular review and update of command templates
- Testing slash commands across different project types
- Updating project-type detection and template selection
- Expanding template library based on common development patterns
- Ensuring all templates remain current and functional
- Testing context-aware features with real projects
- Maintaining MCP server configurations and versions

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.