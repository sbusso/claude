#!/bin/zsh
# install-claude-commands.sh

SHELL_RC="$HOME/.zshrc"

# Check for force flag
FORCE_INSTALL=false
if [[ "$1" == "--force" ]]; then
    FORCE_INSTALL=true
fi

# Auto-detect framework version dynamically
if command -v git >/dev/null 2>&1 && [ -d ".git" ]; then
    # Check if we're in the claude-workflow repository by looking for install.sh
    if [ -f "install.sh" ] && [ -f ".claude/templates/CLAUDE.md" ]; then
        FRAMEWORK_VERSION=$(git rev-parse --short HEAD 2>/dev/null || echo "dev")
    else
        # We're in a user's repository, fetch latest version from GitHub
        if command -v curl >/dev/null 2>&1; then
            FRAMEWORK_VERSION=$(curl -sSL --connect-timeout 5 "https://api.github.com/repos/sbusso/claude-workflow/commits/main" 2>/dev/null | grep -o '"sha":"[^"]*"' | head -1 | cut -d'"' -f4 | cut -c1-7 2>/dev/null || echo "latest")
        else
            FRAMEWORK_VERSION="latest"
        fi
    fi
else
    # No git, fetch latest version from GitHub
    if command -v curl >/dev/null 2>&1; then
        FRAMEWORK_VERSION=$(curl -sSL --connect-timeout 5 "https://api.github.com/repos/sbusso/claude-workflow/commits/main" 2>/dev/null | grep -o '"sha":"[^"]*"' | head -1 | cut -d'"' -f4 | cut -c1-7 2>/dev/null || echo "latest")
    else
        FRAMEWORK_VERSION="latest"
    fi
fi

VERSION_FILE="$HOME/.claude/.framework_version"

echo "🚀 Installing Claude workflow framework..."

# Check shell integration version
SHELL_NEEDS_UPDATE=true
if [ -f "$VERSION_FILE" ] && [ "$FORCE_INSTALL" = false ]; then
    INSTALLED_VERSION=$(cat "$VERSION_FILE")
    if [ "$INSTALLED_VERSION" = "$FRAMEWORK_VERSION" ]; then
        echo "✅ Shell integration already up-to-date (version $FRAMEWORK_VERSION)"
        SHELL_NEEDS_UPDATE=false
    else
        echo "📦 Updating shell integration from $INSTALLED_VERSION to $FRAMEWORK_VERSION"
    fi
else
    if [ "$FORCE_INSTALL" = true ]; then
        echo "🔄 Force reinstalling framework version $FRAMEWORK_VERSION"
    else
        echo "📦 Installing framework version $FRAMEWORK_VERSION"
    fi
fi

# Update shell integration if needed
if [ "$SHELL_NEEDS_UPDATE" = true ] || [ "$FORCE_INSTALL" = true ]; then
    # Backup existing RC file
    cp "$SHELL_RC" "$SHELL_RC.backup.$(date +%Y%m%d_%H%M%S)"
    echo "✅ Created backup of $SHELL_RC"

    # Check if our section already exists
    if grep -q "# Claude Command Shortcuts" "$SHELL_RC"; then
        # Always auto-update for better user experience - no interactive prompts
        echo "🔄 Updating existing Claude commands installation..."
        
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

# Common aliases for available commands
alias ccf='ccmd feature'           # Create features with GitHub Projects
alias cct='ccmd tasks'             # Break features into tasks
alias cci='ccmd do-issue'          # Implement issue with TDD workflow
alias ccfi='ccmd fix-issue'        # Fix a specific issue
alias ccc='ccmd commit'            # Create semantic commits
alias ccpr='ccmd create-pr'        # Create pull requests
alias ccw='ccmd create-worktrees'  # Create git worktrees
alias ccb='ccmd brainstorm'        # Brainstorm with extended thinking

# Help function to list all commands
cchelp() {
    echo "Claude Command Shortcuts:"
    echo "  ccmd <command> <args>  - Run any project command"
    echo ""
    echo "Available aliases:"
    echo "  ccf \"description\"    - Create feature with GitHub Projects"
    echo "  cct \"feature\"        - Break feature into tasks"
    echo "  cci 123               - Implement issue with TDD workflow"
    echo "  ccfi 123              - Fix specific issue"
    echo "  ccc \"message\"        - Create semantic commit"
    echo "  ccpr                  - Create pull request"
    echo "  ccw                   - Create git worktrees"
    echo "  ccb \"topic\"          - Brainstorm with extended thinking"
    echo ""
    echo "Run 'ccmd' without arguments for usage"
}
# Claude Command Shortcuts - END

EOF

    echo "✅ Added Claude command shortcuts to $SHELL_RC"
    
    # Save shell integration version  
    mkdir -p "$(dirname "$VERSION_FILE")"
    echo "$FRAMEWORK_VERSION" > "$VERSION_FILE"
    echo "💾 Shell integration version $FRAMEWORK_VERSION"
else
    echo "ℹ️  Shell integration already up-to-date"
fi

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
    
    # Check if project framework is already up-to-date
    PROJECT_VERSION_FILE=".claude/.framework_version"
    if [ -f "$PROJECT_VERSION_FILE" ]; then
        PROJECT_INSTALLED_VERSION=$(cat "$PROJECT_VERSION_FILE")
        if [ "$PROJECT_INSTALLED_VERSION" = "$FRAMEWORK_VERSION" ] && [ "$FORCE_INSTALL" = false ]; then
            echo "✅ Project framework already up-to-date (version $FRAMEWORK_VERSION)"
            echo "ℹ️  Use --force flag to reinstall: curl -sSL ... | bash -s -- --force"
            # Skip installation but still continue to MCP setup
            SKIP_PROJECT_INSTALL=true
        else
            echo "📦 Updating project framework from $PROJECT_INSTALLED_VERSION to $FRAMEWORK_VERSION"
            SKIP_PROJECT_INSTALL=false
        fi
    else
        echo "📦 Installing project framework version $FRAMEWORK_VERSION"
        SKIP_PROJECT_INSTALL=false
    fi
    
    # Always check for missing files, regardless of version
    # Create .claude directory structure
    mkdir -p ".claude/utils"
    mkdir -p ".claude/commands"
    mkdir -p ".claude/code-guidelines"
    
    # Check what's missing instead of blanket skip
    MISSING_FILES=false
    if [ ! -f "CLAUDE.md" ] || [ ! -f ".mcp.json" ] || [ ! -f ".claude/commands/do-issue.md" ] || [ ! -f ".claude/utils/setup-labels.sh" ]; then
        MISSING_FILES=true
        echo "📦 Detected missing project files, installing..."
    fi
    
    if [ "$SKIP_PROJECT_INSTALL" = false ] || [ "$MISSING_FILES" = true ]; then
        # Get the script directory (where install.sh is located)
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        
        # Check if we're running from the template repository
        if [ -f "$SCRIPT_DIR/.claude/templates/CLAUDE.md" ]; then
        echo "🚀 Installing from template repository..."
        
        # Copy utilities first (needed for smart merge)
        cp -r "$SCRIPT_DIR/.claude/utils/"* ".claude/utils/"
        chmod +x .claude/utils/*.sh 2>/dev/null || true
        echo "✅ Installed workflow automation utilities"
        
        # Smart merge with existing CLAUDE.md using Claude
        if [ -f "CLAUDE.md" ]; then
            echo "📄 Analyzing existing CLAUDE.md for smart merge..."
            
            # Check if it already contains framework sections
            if grep -q "## Development Workflow" "CLAUDE.md" && grep -q "## Smart Testing Philosophy" "CLAUDE.md"; then
                echo "✅ CLAUDE.md already contains framework workflow - skipping"
            else
                echo "🤖 Using Claude for intelligent CLAUDE.md merge..."
                
                # Backup existing file
                cp "CLAUDE.md" "CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
                
                # Check if Claude Code is available for smart merge
                if command -v claude >/dev/null 2>&1; then
                    # Use smart merge utility
                    echo "🔄 Using Claude smart merge for CLAUDE.md..."
                    if [ -f ".claude/utils/smart-merge.sh" ]; then
                        bash ".claude/utils/smart-merge.sh" claude-md "CLAUDE.md" "$SCRIPT_DIR/.claude/templates/CLAUDE.md"
                        if [ $? -ne 0 ]; then
                            echo "⚠️  Claude merge failed, using fallback merge"
                            # Fallback to simple append
                            {
                                cat "CLAUDE.md"
                                echo ""
                                echo "---"
                                echo ""
                                echo "# Claude Code Workflow Framework"
                                echo ""
                                cat "$SCRIPT_DIR/.claude/templates/CLAUDE.md"
                            } > "CLAUDE.md.tmp"
                            mv "CLAUDE.md.tmp" "CLAUDE.md"
                        fi
                    else
                        echo "⚠️  Smart merge utility not found, using basic merge"
                        # Fallback to simple append
                        {
                            cat "CLAUDE.md"
                            echo ""
                            echo "---"
                            echo ""
                            echo "# Claude Code Workflow Framework"
                            echo ""
                            cat "$SCRIPT_DIR/.claude/templates/CLAUDE.md"
                        } > "CLAUDE.md.tmp"
                        mv "CLAUDE.md.tmp" "CLAUDE.md"
                    fi
                else
                    echo "🔄 Claude not available, using basic merge..."
                    # Simple merge when Claude not available
                    {
                        cat "CLAUDE.md"
                        echo ""
                        echo "---"
                        echo ""
                        echo "# Claude Code Workflow Framework"
                        echo ""
                        cat "$SCRIPT_DIR/.claude/templates/CLAUDE.md"
                    } > "CLAUDE.md.tmp"
                    mv "CLAUDE.md.tmp" "CLAUDE.md"
                fi
                
                echo "✅ Merged framework workflow into existing CLAUDE.md"
                echo "📋 Backup saved as CLAUDE.md.backup.*"
            fi
        else
            cp "$SCRIPT_DIR/.claude/templates/CLAUDE.md" "CLAUDE.md"
            echo "✅ Created project CLAUDE.md with workflow framework"
        fi
        
        # Copy code guidelines  
        cp -r "$SCRIPT_DIR/.claude/code-guidelines/"* ".claude/code-guidelines/"
        echo "✅ Installed code quality guidelines"
        
        # Smart merge MCP configuration using dedicated JSON merge
        if [ -f "$SCRIPT_DIR/.mcp.json" ]; then
            if [ -f ".mcp.json" ]; then
                echo "📄 Merging existing .mcp.json with framework MCPs..."
                
                # Use dedicated JSON merge utility
                if [ -f ".claude/utils/merge-mcp.sh" ]; then
                    bash ".claude/utils/merge-mcp.sh" ".mcp.json" "$SCRIPT_DIR/.mcp.json"
                else
                    echo "⚠️  MCP merge utility not found, using fallback method"
                    
                    # Fallback: check if framework MCPs already exist
                    if grep -q "context7\|playwright\|github" ".mcp.json"; then
                        echo "✅ .mcp.json already contains framework MCPs - skipping"
                    else
                        echo "📋 Manual merge required for .mcp.json"
                        echo "📋 Framework MCPs available in $SCRIPT_DIR/.mcp.json"
                        cp ".mcp.json" ".mcp.json.backup.$(date +%Y%m%d_%H%M%S)"
                        echo "📋 Your existing .mcp.json backed up as .mcp.json.backup.*"
                    fi
                fi
            else
                cp "$SCRIPT_DIR/.mcp.json" ".mcp.json"
                echo "✅ Installed MCP server configuration"
            fi
        fi
        
        # Copy essential commands (with backup of existing)
        COMMANDS=(
            "do/do-issue.md"
            "do/commit.md" 
            "do/create-pr.md"
            "plan/feature.md"
            "plan/tasks.md"
        )
        
        for cmd in "${COMMANDS[@]}"; do
            cmd_name=$(basename "$cmd")
            if [ -f ".claude/commands/$cmd_name" ]; then
                # Backup existing command if different
                if ! diff -q "$SCRIPT_DIR/.claude/commands/$cmd" ".claude/commands/$cmd_name" >/dev/null 2>&1; then
                    cp ".claude/commands/$cmd_name" ".claude/commands/$cmd_name.backup.$(date +%Y%m%d_%H%M%S)"
                    cp "$SCRIPT_DIR/.claude/commands/$cmd" ".claude/commands/$cmd_name"
                    echo "📝 Updated $cmd_name (backup saved)"
                fi
            else
                # Create directory structure if needed
                mkdir -p ".claude/commands/$(dirname "$cmd")" 2>/dev/null || mkdir -p ".claude/commands"
                cp "$SCRIPT_DIR/.claude/commands/$cmd" ".claude/commands/$cmd_name"
                echo "📝 Installed $cmd_name"
            fi
        done
        echo "✅ Core workflow commands ready"
        
    else
        echo "🌐 Downloading framework files from GitHub..."
        
        # Base URL for raw files
        BASE_URL="https://raw.githubusercontent.com/sbusso/claude-workflow/main"
        
        # Download template CLAUDE.md
        if command -v curl >/dev/null 2>&1; then
            echo "📄 Downloading CLAUDE.md template..."
            curl -sSL "$BASE_URL/.claude/templates/CLAUDE.md" -o "CLAUDE.md" 2>/dev/null || {
                echo "⚠️  Failed to download CLAUDE.md template"
            }
            
            echo "📄 Downloading .mcp.json configuration..."
            curl -sSL "$BASE_URL/.mcp.json" -o ".mcp.json" 2>/dev/null || {
                echo "⚠️  Failed to download .mcp.json"
            }
            
            echo "📋 Downloading code guidelines..."
            mkdir -p ".claude/code-guidelines"
            curl -sSL "$BASE_URL/.claude/code-guidelines/python.md" -o ".claude/code-guidelines/python.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/code-guidelines/typescript.md" -o ".claude/code-guidelines/typescript.md" 2>/dev/null  
            curl -sSL "$BASE_URL/.claude/code-guidelines/react.md" -o ".claude/code-guidelines/react.md" 2>/dev/null
            
            echo "🔧 Downloading workflow utilities..."
            curl -sSL "$BASE_URL/.claude/utils/setup-labels.sh" -o ".claude/utils/setup-labels.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/get-project-config.sh" -o ".claude/utils/get-project-config.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/move-item-status.sh" -o ".claude/utils/move-item-status.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/assign-iteration.sh" -o ".claude/utils/assign-iteration.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/smart-merge.sh" -o ".claude/utils/smart-merge.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/merge-mcp.sh" -o ".claude/utils/merge-mcp.sh" 2>/dev/null
            chmod +x .claude/utils/*.sh 2>/dev/null || true
            echo "✅ Downloaded workflow automation utilities"
            
            echo "🔧 Downloading core commands..."
            curl -sSL "$BASE_URL/.claude/commands/do/do-issue.md" -o ".claude/commands/do-issue.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/do/commit.md" -o ".claude/commands/commit.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/do/create-pr.md" -o ".claude/commands/create-pr.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/plan/feature.md" -o ".claude/commands/feature.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/plan/tasks.md" -o ".claude/commands/tasks.md" 2>/dev/null
            
            echo "✅ Downloaded framework files from GitHub"
        else
            echo "⚠️  curl not available - creating basic structure"
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
        fi
    fi
    
        # Make utilities executable
        chmod +x .claude/utils/*.sh 2>/dev/null || true
        
        # Save project framework version
        echo "$FRAMEWORK_VERSION" > "$PROJECT_VERSION_FILE"
        echo "💾 Project framework version $FRAMEWORK_VERSION installed"
    else
        if [ "$MISSING_FILES" = true ]; then
            echo "✅ Installed missing project files"
        else
            echo "ℹ️  All project files already present and up to date"
        fi
    fi
    
else
    echo ""
    echo "⚠️  No git repository detected in current directory"
    echo ""
    echo "The shell integration has been installed, but project framework files"
    echo "require a git repository. To get the complete installation:"
    echo ""
    echo "1. Navigate to your project directory:"
    echo "   cd /path/to/your/project"
    echo ""
    echo "2. Initialize git if needed:"
    echo "   git init"
    echo ""
    echo "3. Run the installer again:"
    echo "   curl -sSL https://raw.githubusercontent.com/sbusso/claude-workflow/main/install.sh | bash"
    echo ""
    echo "Or run in an existing git repository to get:"
    echo "  • .claude/commands/ - Workflow commands"
    echo "  • .claude/utils/ - Automation utilities"
    echo "  • .claude/code-guidelines/ - Development standards"
    echo "  • CLAUDE.md - Project documentation"
    echo "  • .mcp.json - MCP server configuration"
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
echo "## What was installed:"
if [ -d ".git" ]; then
    echo "✅ Shell integration (global commands and aliases)"
    echo "✅ Project framework (commands, utilities, guidelines)"
else
    echo "✅ Shell integration (global commands and aliases)"  
    echo "⚠️  Project framework skipped (no git repository detected)"
fi
echo ""
echo "## Quick Start"
echo "1. Run: source ~/.zshrc"
echo "2. Try: cchelp"
echo ""
if [ -d ".git" ] && [ -d ".claude/utils" ]; then
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
    echo "Claude Code REPL:"
    echo "  /project:feature \"description\" - Create feature with GitHub Projects"
    echo "  /project:tasks \"feature\" - Break down into implementable tasks"
    echo "  /project:do-issue 123 - Smart test-first development workflow"
    echo "  /project:commit \"message\" - Semantic commits"
    echo "  /project:create-pr - Standardized pull requests"
    echo ""
    echo "Shell Aliases:"
    echo "  ccf \"description\" - Create feature"
    echo "  cct \"feature\" - Create tasks"
    echo "  cci 123 - Implement issue"
    echo "  ccc \"message\" - Create commit"
    echo "  ccpr - Create pull request"
    echo ""
    echo "## Workflow Utilities"
    echo "  .claude/utils/setup-labels.sh - Create required GitHub labels"
    echo "  .claude/utils/get-project-config.sh - Auto-discover project config"
    echo "  .claude/utils/move-item-status.sh - Manage GitHub Projects status"
    echo "  .claude/utils/assign-iteration.sh - Assign items to iterations"
fi
echo ""
if command -v claude >/dev/null 2>&1 && [ -d ".git" ]; then
    echo "## Available MCPs"
    echo "  • Context7: Add 'use context7' to any prompt for up-to-date docs"
    echo "  • Playwright: Browser automation and testing capabilities"
    echo "  • GitHub: Enhanced repository and API integration"
fi
echo ""
echo "📖 See CLAUDE.md for complete workflow documentation"

# Version already saved in shell integration section