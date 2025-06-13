# Claude Code Commands Setup

This repository provides Claude Code commands for GitHub Projects workflow automation. Before using the commands, you need to complete this one-time setup.

## Prerequisites

You need:
- GitHub CLI installed (`gh`)
- A GitHub repository 
- A GitHub Project (can be empty)

## Setup Steps

### 1. GitHub CLI Authentication

Your GitHub CLI needs special permissions to work with GitHub Projects.

**Check your current setup:**
```bash
gh auth status
```

**If you see `project` in the token scopes, you're good to go. Skip to step 2.**

**If you don't see `project` scope, you need to add it:**
```bash
gh auth refresh -s project --hostname github.com
```
This will open your browser to grant the additional permission.

### 2. Repository Labels

Your repository needs these labels for the workflow:
- `feature` - For feature requests
- `backlog` - For items in backlog  
- `task` - For implementation tasks

**Use the framework utility:**
```bash
# After running install.sh in your project
.claude/utils/setup-labels.sh
```

**Or create manually in GitHub UI:**
Go to your repo → Issues → Labels → New label

### 3. Project Information

You need to know:
- Your GitHub username
- Your repository name (e.g., `claude`)
- Your project number

**Find your project number:**
```bash
gh project list
```
Look for your project in the list - the number is in the first column.

### 4. Auto-Configuration

The system will automatically discover your project configuration when first used. No configuration files needed!

## Testing the Setup

Once the prerequisites are complete, test with:
```bash
# The system will auto-discover your project configuration on first use
gh issue create --title "[FEATURE] Test setup" --label "feature,backlog"
```

This should:
1. Create a GitHub issue  
2. Auto-discover your project configuration
3. Cache configuration in `project-config.json`

## Troubleshooting

**"Missing project scope"** → Run step 1 again
**"Label not found"** → Create the labels in step 2  
**"Project not found"** → Check your project ID in step 3

That's it! The commands should now work with your GitHub Projects.

## 🔌 Model Context Protocol (MCP) Integration

This template includes pre-configured MCP servers:

- **Context7** - Up-to-date documentation (add `use context7` to any prompt)
- **Playwright** - Browser automation and testing
- **GitHub** - Enhanced repository integration

MCPs are automatically installed when you run `install.sh` if Claude Code is detected.