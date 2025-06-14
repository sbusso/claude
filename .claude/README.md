# Claude Code Workspace

This repository contains the shared Claude Code workspace that synchronizes across all your projects.

## Structure

```
.claude/
├── commands/          # Claude Code command definitions
│   ├── do/           # Implementation commands
│   ├── plan/         # Planning commands
│   ├── job/          # Analysis commands
│   └── setup/        # Setup commands
├── contexts/          # Language-specific coding standards and contexts
├── memory/           # Persistent context and guidelines
├── templates/        # Project template files
├── utils/            # Utility scripts for GitHub Projects
└── settings.json     # Global Claude Code settings
```

## Usage

This workspace is automatically synchronized to your projects via the Claude Code installer. 

### Project Setup

1. Run the installer in your project:
   ```bash
   curl -sSL https://raw.githubusercontent.com/sbusso/claude-workflow/main/install.sh | bash
   ```

2. The installer will:
   - Clone this dotclaude repo into `.claude/`
   - Set up project-specific configuration outside `.claude/`
   - Configure GitHub Projects integration

### Synchronization

- **Pull updates**: Changes to this repo sync to all your projects
- **Push improvements**: Local improvements can be pushed back to share across projects
- **Project isolation**: Project-specific settings stay outside `.claude/`

## Development

To contribute improvements to the Claude Code framework:

1. Make changes in any project's `.claude/` folder
2. Commit and push changes:
   ```bash
   cd .claude
   git add .
   git commit -m "improve: description of changes"
   git push origin main
   ```
3. Changes will sync to other projects on next update

## Project-Specific Settings

Project-specific configuration is stored outside `.claude/` in:
- `.claude-config.json` - Project configuration
- `claude.local.json` - Local overrides (gitignored)

This separation allows `.claude/` to be a clean, synchronized workspace while maintaining project-specific customization.