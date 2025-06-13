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

# Offer to create project commands directory
if [ -d ".git" ]; then
    echo ""
    if [ -d ".claude/commands" ]; then
        echo -n "📁 .claude/commands already exists. Replace example commands? (y/n): "
    else
        echo -n "📁 Git repository detected. Create .claude/commands for project-specific commands? (y/n): "
    fi
    
    read response
    if [[ "$response" == "y" ]]; then
        mkdir -p ".claude/commands"
        
        # Create example command
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
    fi
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
echo "To start using the commands:"
echo "  1. Run: source ~/.zshrc"
echo "  2. Try: cchelp"
echo "  3. Example: cci \"add user authentication\""
echo ""
if [ -d ".claude/utils" ]; then
    echo "🛠️ Framework utilities available:"
    echo "  • .claude/utils/setup-labels.sh - Create required GitHub labels"
    echo "  • .claude/utils/get-project-config.sh - Auto-discover project config"
    echo "  • .claude/utils/move-item-status.sh - Manage GitHub Projects status"
    echo "  • .claude/utils/assign-iteration.sh - Assign items to iterations"
fi
echo ""
if command -v claude >/dev/null 2>&1; then
    echo "📚 Available MCPs:"
    echo "  • Context7: Add 'use context7' to any prompt for up-to-date docs"
    echo "  • Playwright: Browser automation and testing capabilities"
    echo "  • GitHub: Enhanced repository and API integration"
fi