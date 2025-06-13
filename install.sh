#!/bin/zsh
# install-claude-commands.sh

SHELL_RC="$HOME/.zshrc"

echo "🚀 Installing Claude command shortcuts for zsh..."

# Backup existing RC file
cp "$SHELL_RC" "$SHELL_RC.backup.$(date +%Y%m%d_%H%M%S)"
echo "✅ Created backup of $SHELL_RC"

# Check if our section already exists
if grep -q "# Claude Command Shortcuts" "$SHELL_RC"; then
    echo "⚠️  Claude commands already installed."
    echo -n "Replace existing installation? (y/n): "
    read response
    if [[ "$response" != "y" ]]; then
        echo "❌ Installation cancelled."
        exit 0
    fi
    
    # Remove existing section
    # Using a temporary file for compatibility with both Linux and macOS
    sed '/# Claude Command Shortcuts - START/,/# Claude Command Shortcuts - END/d' "$SHELL_RC" > "$SHELL_RC.tmp"
    mv "$SHELL_RC.tmp" "$SHELL_RC"
    echo "✅ Removed old version"
fi

# Add our commands section
cat >> "$SHELL_RC" << 'EOF'

# Claude Command Shortcuts - START
# Generic Claude command runner
ccmd() {
    if [ $# -lt 1 ]; then
        echo "Usage: ccmd <command-name> <arguments>"
        echo "Example: ccmd create-issue \"add dark mode support\""
        echo "Example: ccmd fix-issue \"123\""
        return 1
    fi
    
    local command=$1
    shift
    claude "/project:${command} \"$*\""
}

# Common aliases for frequently used commands
alias cci='ccmd create-issue'      # Create GitHub issue from feature request
alias cfi='ccmd fix-issue'         # Fix a specific issue
alias cco='ccmd optimize'          # Optimize code
alias ccr='ccmd review'            # Code review
alias cct='ccmd test'              # Generate tests
alias ccd='ccmd document'          # Generate documentation
alias ccs='ccmd security-review'   # Security analysis
alias ccref='ccmd refactor'        # Refactor code

# Help function to list all commands
cchelp() {
    echo "Claude Command Shortcuts:"
    echo "  ccmd <command> <args>  - Run any project command"
    echo ""
    echo "Common aliases:"
    echo "  cci \"feature\"        - Create GitHub issue"
    echo "  cfi \"issue #\"        - Fix specific issue"
    echo "  cco \"code\"           - Optimize code"
    echo "  ccr \"code\"           - Review code"
    echo "  cct \"code\"           - Generate tests"
    echo "  ccd \"code\"           - Document code"
    echo "  ccs \"code\"           - Security review"
    echo "  ccref \"code\"         - Refactor code"
    echo ""
    echo "Run 'ccmd' without arguments for usage"
}
# Claude Command Shortcuts - END

EOF

echo "✅ Added Claude command shortcuts to $SHELL_RC"

# Create commands directory if it doesn't exist
if [ ! -d "$HOME/.claude/commands" ]; then
    mkdir -p "$HOME/.claude/commands"
    echo "✅ Created ~/.claude/commands directory for personal commands"
else
    echo "✅ ~/.claude/commands directory already exists"
fi

# Note: Label setup utility is included in the framework at .claude/utils/setup-labels.sh
# Users can run it directly from the project after installation

# Install project template files
if [ -d ".git" ]; then
    echo ""
    echo "📁 Git repository detected. Installing Claude Code workflow framework..."
    
    # Create .claude directory structure
    mkdir -p ".claude/utils"
    mkdir -p ".claude/commands"
    mkdir -p ".claude/code-guidelines"
    
    # Get the script directory (where install.sh is located)
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Check if we're running from the template repository
    if [ -f "$SCRIPT_DIR/.claude/templates/CLAUDE.md" ]; then
        echo "🚀 Installing from template repository..."
        
        # Copy template CLAUDE.md to project root
        if [ -f "CLAUDE.md" ]; then
            echo -n "📄 CLAUDE.md already exists. Replace with framework template? (y/n): "
            read response
            if [[ "$response" == "y" ]]; then
                cp "$SCRIPT_DIR/.claude/templates/CLAUDE.md" "CLAUDE.md"
                echo "✅ Updated project CLAUDE.md with workflow framework"
            fi
        else
            cp "$SCRIPT_DIR/.claude/templates/CLAUDE.md" "CLAUDE.md"
            echo "✅ Created project CLAUDE.md with workflow framework"
        fi
        
        # Copy utilities
        cp -r "$SCRIPT_DIR/.claude/utils/"* ".claude/utils/"
        echo "✅ Installed workflow automation utilities"
        
        # Copy code guidelines  
        cp -r "$SCRIPT_DIR/.claude/code-guidelines/"* ".claude/code-guidelines/"
        echo "✅ Installed code quality guidelines"
        
        # Copy MCP configuration
        if [ -f "$SCRIPT_DIR/.mcp.json" ]; then
            cp "$SCRIPT_DIR/.mcp.json" ".mcp.json"
            echo "✅ Installed MCP server configuration"
        fi
        
        # Copy essential commands
        cp "$SCRIPT_DIR/.claude/commands/do/do-issue.md" ".claude/commands/"
        cp "$SCRIPT_DIR/.claude/commands/do/commit.md" ".claude/commands/"
        cp "$SCRIPT_DIR/.claude/commands/do/create-pr.md" ".claude/commands/"
        cp "$SCRIPT_DIR/.claude/commands/plan/feature.md" ".claude/commands/"
        cp "$SCRIPT_DIR/.claude/commands/plan/tasks.md" ".claude/commands/"
        echo "✅ Installed core workflow commands"
        
    else
        echo "⚠️  Template files not found. Creating basic structure..."
        
        # Create basic example command
        cat > ".claude/commands/create-issue.md" << 'EXAMPLE'
Transform the following feature request into a comprehensive GitHub issue: $ARGUMENTS

Create a well-structured issue with:
- Clear title (action verb + specific feature)
- User story (As a..., I want..., so that...)
- Acceptance criteria (Given-When-Then format)
- Technical requirements
- Implementation plan
- Testing strategy

Then create the issue using gh CLI.
EXAMPLE
        echo "✅ Created example create-issue command"
        echo "ℹ️  For full framework installation, run this script from the template repository"
    fi
    
    # Make utilities executable
    chmod +x .claude/utils/*.sh 2>/dev/null || true
    
fi

# Setup MCPs for Claude Code if available
echo ""
echo "🔌 Setting up Model Context Protocol (MCP) servers..."

# Check if Claude Code is available
if command -v claude >/dev/null 2>&1; then
    echo "✅ Claude Code detected"
    
    # Check if we're in the template repository
    if [ -f ".mcp.json" ]; then
        echo "📋 Found .mcp.json configuration"
        
        # Install MCPs from the configuration
        echo "🚀 Installing framework MCPs..."
        
        # Install Context7 for up-to-date documentation
        if claude mcp add --scope project context7 -- npx -y @upstash/context7-mcp 2>/dev/null; then
            echo "  ✅ Context7 MCP installed (up-to-date documentation)"
        else
            echo "  ⚠️  Context7 MCP installation failed"
        fi
        
        # Install Playwright for browser automation
        if claude mcp add --scope project playwright -- npx @playwright/mcp@latest 2>/dev/null; then
            echo "  ✅ Playwright MCP installed (browser automation)"
        else
            echo "  ⚠️  Playwright MCP installation failed"
        fi
        
        # Install GitHub MCP if not already configured
        if claude mcp add --scope project github -- npx -y @modelcontextprotocol/server-github 2>/dev/null; then
            echo "  ✅ GitHub MCP installed (repository integration)"
        else
            echo "  ℹ️  GitHub MCP already configured or installation failed"
        fi
        
        echo "✅ MCP setup complete"
        echo "ℹ️  MCPs will be available in all projects using this template"
    else
        echo "ℹ️  No .mcp.json found - MCPs not configured for this project"
    fi
else
    echo "ℹ️  Claude Code not found - MCP setup skipped"
    echo "   Install Claude Code first, then re-run this installer for MCP integration"
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "## Quick Start"
echo "1. Run: source ~/.zshrc"
echo "2. Try: cchelp"
echo ""
if [ -d ".claude/utils" ]; then
    echo "## Setup GitHub Projects Workflow"
    echo "1. Ensure GitHub CLI project access:"
    echo "   gh auth refresh -s project --hostname github.com"
    echo ""
    echo "2. Create workflow labels (run once per repository):"
    echo "   .claude/utils/setup-labels.sh"
    echo ""
    echo "3. Configure your GitHub Project with fields:"
    echo "   • Status: Todo, In Progress, Done"
    echo "   • Iteration: Current and future iterations"
    echo ""
    echo "4. Enable GitHub Project automations:"
    echo "   ✅ Auto-set status to 'Done' when PR merged"
    echo "   ✅ Auto-close issues when status = 'Done'"
    echo "   ✅ Auto-set status to 'Todo' when items added"
    echo ""
    echo "## Available Commands"
    echo "Planning:"
    echo "  @feature \"description\" - Create feature with GitHub Projects"
    echo "  @tasks \"feature\" - Break down into implementable tasks"
    echo ""
    echo "Implementation:"  
    echo "  @do-issue 123 - Smart test-first development workflow"
    echo "  @commit \"message\" - Semantic commits"
    echo "  @create-pr - Standardized pull requests"
    echo ""
    echo "## Workflow Utilities"
    echo "  .claude/utils/setup-labels.sh - Create required GitHub labels"
    echo "  .claude/utils/get-project-config.sh - Auto-discover project config"
    echo "  .claude/utils/move-item-status.sh - Manage GitHub Projects status"
    echo "  .claude/utils/assign-iteration.sh - Assign items to iterations"
fi
echo ""
if command -v claude >/dev/null 2>&1; then
    echo "## Available MCPs"
    echo "  • Context7: Add 'use context7' to any prompt for up-to-date docs"
    echo "  • Playwright: Browser automation and testing capabilities"
    echo "  • GitHub: Enhanced repository and API integration"
fi
echo ""
echo "📖 See CLAUDE.md for complete workflow documentation"