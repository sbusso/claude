#!/bin/zsh
# install-claude-commands.sh

SHELL_RC="$HOME/.zshrc"

# Check for force flag
FORCE_INSTALL=false
if [[ "$1" == "--force" ]]; then
    FORCE_INSTALL=true
fi

# Set framework version - simplified approach
if [ -f "install.sh" ] && [ -f ".claude/templates/CLAUDE.md" ]; then
    # We're in the claude-workflow repository
    FRAMEWORK_VERSION=$(git rev-parse --short HEAD 2>/dev/null || echo "dev")
else
    # Always use "latest" for user installations to avoid API failures
    FRAMEWORK_VERSION="latest"
fi

VERSION_FILE="$HOME/.claude/.framework_version"

# Check shell integration version
SHELL_NEEDS_UPDATE=true
if [ -f "$VERSION_FILE" ] && [ "$FORCE_INSTALL" = false ]; then
    INSTALLED_VERSION=$(cat "$VERSION_FILE")
    if [ "$INSTALLED_VERSION" = "$FRAMEWORK_VERSION" ]; then
        SHELL_NEEDS_UPDATE=false
    fi
fi

# Update shell integration if needed
if [ "$SHELL_NEEDS_UPDATE" = true ] || [ "$FORCE_INSTALL" = true ]; then
    # Backup existing RC file
    cp "$SHELL_RC" "$SHELL_RC.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null

    # Check if our section already exists
    if grep -q "# Claude Command Shortcuts" "$SHELL_RC"; then
        # Remove existing section
        sed '/# Claude Command Shortcuts - START/,/# Claude Command Shortcuts - END/d' "$SHELL_RC" > "$SHELL_RC.tmp"
        mv "$SHELL_RC.tmp" "$SHELL_RC"
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
alias ccbd='ccmd breakdown'        # Break features into tasks
alias ccim='ccmd implement'        # Direct technical implementation planning
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
    echo "  ccbd 123              - Break feature into tasks"
    echo "  ccim \"tech task\"     - Direct technical implementation planning"
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

    # Save shell integration version  
    mkdir -p "$(dirname "$VERSION_FILE")"
    echo "$FRAMEWORK_VERSION" > "$VERSION_FILE"
fi

# Create commands directory if it doesn't exist
mkdir -p "$HOME/.claude/commands" 2>/dev/null

# Install project template files
if [ -d ".git" ]; then
    # Create .claude directory structure
    mkdir -p ".claude/utils" ".claude/commands" ".claude/code-guidelines" ".claude/memory"
    
    # Check what's missing
    MISSING_FILES=false
    if [ ! -f "CLAUDE.md" ] || [ ! -f ".mcp.json" ] || [ ! -f ".claude/commands/do-issue.md" ] || [ ! -f ".claude/utils/setup-labels.sh" ]; then
        MISSING_FILES=true
    fi
    
    if [ "$MISSING_FILES" = true ]; then
        # Get the script directory (where install.sh is located)
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        
        # Check if we're running from the template repository
        if [ -f "$SCRIPT_DIR/.claude/templates/CLAUDE.md" ]; then
        
            # Download latest utilities
        BASE_URL="https://raw.githubusercontent.com/sbusso/claude-workflow/main"
        curl -sSL "$BASE_URL/.claude/utils/setup-labels.sh" -o ".claude/utils/setup-labels.sh" 2>/dev/null
        curl -sSL "$BASE_URL/.claude/utils/get-project-config.sh" -o ".claude/utils/get-project-config.sh" 2>/dev/null
        curl -sSL "$BASE_URL/.claude/utils/move-item-status.sh" -o ".claude/utils/move-item-status.sh" 2>/dev/null
        curl -sSL "$BASE_URL/.claude/utils/assign-iteration.sh" -o ".claude/utils/assign-iteration.sh" 2>/dev/null
        curl -sSL "$BASE_URL/.claude/utils/smart-merge.sh" -o ".claude/utils/smart-merge.sh" 2>/dev/null
        curl -sSL "$BASE_URL/.claude/utils/merge-mcp.sh" -o ".claude/utils/merge-mcp.sh" 2>/dev/null
        chmod +x .claude/utils/*.sh 2>/dev/null || true
        
        # Handle CLAUDE.md
        if [ -f "CLAUDE.md" ]; then
            if ! grep -q "## Development Workflow" "CLAUDE.md"; then
                cp "CLAUDE.md" "CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null
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
            cp "$SCRIPT_DIR/.claude/templates/CLAUDE.md" "CLAUDE.md"
        fi
        
        # Copy code guidelines  
        cp -r "$SCRIPT_DIR/.claude/code-guidelines/"* ".claude/code-guidelines/" 2>/dev/null
        
        # Copy memory folder (project setup guidelines)
        if [ "$FORCE_INSTALL" = true ] || [ ! -f ".claude/memory/project-setup.md" ]; then
            cp -r "$SCRIPT_DIR/.claude/memory/"* ".claude/memory/" 2>/dev/null || true
        fi
        
        # Handle MCP configuration - NO BACKUP SPAM
        if [ -f "$SCRIPT_DIR/.mcp.json" ]; then
            if [ ! -f ".mcp.json" ]; then
                cp "$SCRIPT_DIR/.mcp.json" ".mcp.json"
            fi
        fi
        
        # Copy essential commands with proper directory structure
        COMMANDS=("do/do-issue.md" "do/commit.md" "do/create-pr.md" "plan/feature.md" "plan/breakdown.md" "plan/brainstorm.md" "plan/implement.md" "job/analyst.md")
        
        for cmd in "${COMMANDS[@]}"; do
            target_path=".claude/commands/$cmd"
            if [ ! -f "$target_path" ] || ! diff -q "$SCRIPT_DIR/.claude/commands/$cmd" "$target_path" >/dev/null 2>&1; then
                # Backup existing file if different
                if [ -f "$target_path" ]; then
                    cp "$target_path" "$target_path.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
                fi
                # Create directory structure and copy
                mkdir -p ".claude/commands/$(dirname "$cmd")" 2>/dev/null
                cp "$SCRIPT_DIR/.claude/commands/$cmd" "$target_path"
            fi
        done
        
        fi
        
    else
        # Base URL for raw files
        BASE_URL="https://raw.githubusercontent.com/sbusso/claude-workflow/main"
        
        # Download files
        if command -v curl >/dev/null 2>&1; then
            curl -sSL "$BASE_URL/.claude/templates/CLAUDE.md" -o "CLAUDE.md" 2>/dev/null
            
            # Download to temp file first for potential merging
            TEMP_MCP=$(mktemp)
            curl -sSL "$BASE_URL/.mcp.json" -o "$TEMP_MCP" 2>/dev/null || {
                rm -f "$TEMP_MCP"
            }
            
            mkdir -p ".claude/code-guidelines"
            curl -sSL "$BASE_URL/.claude/code-guidelines/python.md" -o ".claude/code-guidelines/python.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/code-guidelines/typescript.md" -o ".claude/code-guidelines/typescript.md" 2>/dev/null  
            curl -sSL "$BASE_URL/.claude/code-guidelines/react.md" -o ".claude/code-guidelines/react.md" 2>/dev/null
            
            # Download memory folder (project setup guidelines)
            if [ "$FORCE_INSTALL" = true ] || [ ! -f ".claude/memory/project-setup.md" ]; then
                curl -sSL "$BASE_URL/.claude/memory/project-setup.md" -o ".claude/memory/project-setup.md" 2>/dev/null
            fi
            
            curl -sSL "$BASE_URL/.claude/utils/setup-labels.sh" -o ".claude/utils/setup-labels.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/get-project-config.sh" -o ".claude/utils/get-project-config.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/move-item-status.sh" -o ".claude/utils/move-item-status.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/assign-iteration.sh" -o ".claude/utils/assign-iteration.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/smart-merge.sh" -o ".claude/utils/smart-merge.sh" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/utils/merge-mcp.sh" -o ".claude/utils/merge-mcp.sh" 2>/dev/null
            chmod +x .claude/utils/*.sh 2>/dev/null || true
            
            # Handle MCP configuration - NO BACKUP SPAM
            if [ -f "$TEMP_MCP" ]; then
                if [ ! -f ".mcp.json" ]; then
                    cp "$TEMP_MCP" ".mcp.json"
                fi
                rm -f "$TEMP_MCP"
            fi
            
            # Download commands with proper directory structure
            mkdir -p ".claude/commands/do" ".claude/commands/plan" ".claude/commands/job"
            curl -sSL "$BASE_URL/.claude/commands/do/do-issue.md" -o ".claude/commands/do/do-issue.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/do/commit.md" -o ".claude/commands/do/commit.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/do/create-pr.md" -o ".claude/commands/do/create-pr.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/plan/feature.md" -o ".claude/commands/plan/feature.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/plan/breakdown.md" -o ".claude/commands/plan/breakdown.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/plan/brainstorm.md" -o ".claude/commands/plan/brainstorm.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/plan/implement.md" -o ".claude/commands/plan/implement.md" 2>/dev/null
            curl -sSL "$BASE_URL/.claude/commands/job/analyst.md" -o ".claude/commands/job/analyst.md" 2>/dev/null
        else
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
        fi
    fi
    
    # Make utilities executable
    chmod +x .claude/utils/*.sh 2>/dev/null || true
    
    # Save project framework version
    echo "$FRAMEWORK_VERSION" > ".claude/.framework_version" 2>/dev/null
    
fi


# Setup project configuration during installation
if [ -d ".git" ] && [ -f ".claude/utils/get-project-config.sh" ]; then
    if [ ! -f ".claude/project-config.json" ] || ! jq -e '.project.number' ".claude/project-config.json" >/dev/null 2>&1; then
        # Run project config with stdin redirected from terminal
        bash ".claude/utils/get-project-config.sh" < /dev/tty
    fi
fi

echo "Installation complete!"
echo ""

echo "## Available Commands"
echo "Shell aliases:"
echo "  ccf \"description\"  - Create feature with GitHub Projects"
echo "  ccbd 123           - Break feature into tasks"
echo "  ccim \"tech task\"   - Direct technical implementation planning"
echo "  cci 123            - Implement issue with TDD workflow"
echo "  ccc \"message\"      - Create semantic commit"
echo "  ccpr               - Create pull request"
echo "  cchelp             - Show command help"

if [ -d ".git" ]; then
    echo ""
    echo "Claude Code REPL:"
    echo "  /project:feature \"description\""
    echo "  /project:breakdown 123"
    echo "  /project:implement \"tech task\""
    echo "  /project:do-issue 123"
    echo "  /project:commit \"message\""
    echo "  /project:create-pr"
fi

if command -v claude >/dev/null 2>&1 && [ -f ".mcp.json" ]; then
    echo ""
    echo "## Available MCPs"
    echo "Context7, Playwright, GitHub (auto-loaded in Claude Code)"
fi

echo ""
echo "Run: source ~/.zshrc"
