# Claude Code GitHub Workflow Framework

This repository contains AI instruction templates for intelligent GitHub Issues-based development workflows.

## Structure

```
.claude/
├── commands/          # AI instruction templates (enhanced prompts)
│   ├── do/           # Implementation instruction templates
│   ├── plan/         # Planning instruction templates
│   └── project/      # Context analysis instruction templates
├── contexts/          # Language-specific coding standards and contexts
├── settings.json     # Claude Code settings with GitHub MCP
├── .mcp.json         # MCP server configuration
└── CLAUDE.md         # Project guidance file (automatically loaded by Claude Code)
```

## Usage

This framework provides copy-and-go GitHub workflow automation for any project.

### Project Setup

1. Copy the framework to your project:
   ```bash
   # Copy the .claude directory
   cp -r /path/to/this-repo/.claude/ /path/to/your-project/
   
   # Copy the project guidance file
   cp /path/to/this-repo/.claude/CLAUDE.md /path/to/your-project/.claude/
   ```

2. Set up GitHub access:
   ```bash
   export GITHUB_PERSONAL_ACCESS_TOKEN="your_github_token"
   ```

3. Start using slash commands immediately!

### Framework Benefits

- **Copy-and-go**: No installation scripts or complex setup
- **GitHub native**: Uses GitHub Issues and MCP for all tracking
- **AI-powered**: Commands are sophisticated AI instruction templates
- **Project-aware**: Automatically adapts to your technology stack

## Development

### Core Command Templates

All commands are AI instruction templates located in `.claude/commands/`:

- **Planning commands**: `/project:plan:prd`, `/project:plan:feature`, `/project:plan:tasks`
- **Implementation commands**: `/project:do:task`
- **Context commands**: `/project:current`

### Adding New Commands

1. Create a new `.md` file in the appropriate subdirectory
2. Structure it as step-by-step AI instructions
3. Include explicit tool usage (e.g., "Use the GitHub tool to...")
4. Add extended thinking prompts for complex scenarios

### AI Instruction Guidelines

Commands should:
- Be written as instructions TO the AI, not documentation
- Use numbered steps for clear progression
- Specify exact tools to use ("Use the GitHub tool to...")
- Include validation and quality checks
- Handle both simple and complex scenarios

## Command Categories

- **`/project:plan:*`** - Create and plan work as GitHub issues
- **`/project:do:*`** - Execute and implement work
- **`/project:current`** - Analyze current project state

This framework transforms complex development workflows into systematic, AI-guided processes.