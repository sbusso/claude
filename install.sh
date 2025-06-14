#!/bin/zsh
# Claude Code Workspace Installer
# Installs and synchronizes .claude workspace across projects

set -e

SHELL_RC="$HOME/.zshrc"
DOTCLAUDE_REPO="https://github.com/sbusso/dotclaude.git"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check for force flag
FORCE_INSTALL=false
if [[ "$1" == "--force" ]]; then
    FORCE_INSTALL=true
    log_info "Force installation enabled"
fi

# Function to install shell integration
install_shell_integration() {
    log_info "Installing shell integration..."
    
    # Backup existing RC file
    if [ -f "$SHELL_RC" ]; then
        cp "$SHELL_RC" "$SHELL_RC.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null
        log_info "Backed up existing shell configuration"
    fi

    # Remove existing section if present
    if grep -q "# Claude Command Shortcuts" "$SHELL_RC" 2>/dev/null; then
        sed '/# Claude Command Shortcuts - START/,/# Claude Command Shortcuts - END/d' "$SHELL_RC" > "$SHELL_RC.tmp"
        mv "$SHELL_RC.tmp" "$SHELL_RC"
        log_info "Removed existing Claude shortcuts"
    fi

    # Add new shell integration
cat >> "$SHELL_RC" << 'EOF'

# Claude Command Shortcuts - START
# Generic Claude command runner
ccmd() {
    if [ $# -lt 1 ]; then
        echo "Usage: ccmd <command-name> <arguments>"
        echo "Example: ccmd feature \"add dark mode support\""
        echo "Example: ccmd breakdown 123"
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

# Workspace sync commands
ccsync() {
    if [ -d ".claude/.git" ]; then
        log_info "Syncing Claude workspace..."
        (cd .claude && git pull origin main)
        log_success "Workspace synced"
    else
        log_error "No Claude workspace found. Run installer first."
    fi
}

ccpush() {
    if [ -d ".claude/.git" ]; then
        log_info "Pushing Claude workspace changes..."
        (cd .claude && git add . && git commit -m "update: workspace improvements" && git push origin main)
        log_success "Workspace changes pushed"
    else
        log_error "No Claude workspace found. Run installer first."
    fi
}

# Help function to list all commands
cchelp() {
    echo "Claude Command Shortcuts:"
    echo "  ccmd <command> <args>  - Run any project command"
    echo ""
    echo "Planning Commands:"
    echo "  ccf \"description\"    - Create feature with GitHub Projects"
    echo "  ccbd 123              - Break feature into tasks"
    echo "  ccim \"tech task\"     - Direct technical implementation planning"
    echo "  ccb \"topic\"          - Brainstorm with extended thinking"
    echo ""
    echo "Implementation Commands:"
    echo "  cci 123               - Implement issue with TDD workflow"
    echo "  ccfi 123              - Fix specific issue"
    echo "  ccc \"message\"        - Create semantic commit"
    echo "  ccpr                  - Create pull request"
    echo "  ccw                   - Create git worktrees"
    echo ""
    echo "Workspace Management:"
    echo "  ccsync                - Pull latest workspace updates"
    echo "  ccpush                - Push workspace improvements"
    echo ""
    echo "Run 'ccmd' without arguments for usage"
}
# Claude Command Shortcuts - END

EOF

    log_success "Shell integration installed"
}

# Function to setup or sync .claude workspace
setup_claude_workspace() {
    log_info "Setting up Claude workspace..."

    # Check if we're in the claude-workflow installer repository
    if [ -f "install.sh" ] && [ -f "bootstrap.sh" ] && [ -f ".claude/templates/CLAUDE.md" ]; then
        log_info "Detected claude-workflow installer repository - skipping .claude setup"
        log_info "In installer environment, .claude should be managed manually"
        return 0
    fi

    if [ -d ".claude" ]; then
        if [ -d ".claude/.git" ]; then
            log_info "Found existing Claude workspace, syncing..."
            (cd .claude && git pull origin main)
            log_success "Workspace synced"
        else
            if [ "$FORCE_INSTALL" = true ]; then
                log_warning "Removing existing .claude folder for fresh install"
                rm -rf .claude
                setup_fresh_workspace
            else
                log_error "Existing .claude folder found without git. Use --force to reinstall."
                exit 1
            fi
        fi
    else
        setup_fresh_workspace
    fi
}

# Function to setup fresh workspace
setup_fresh_workspace() {
    log_info "Cloning Claude workspace from $DOTCLAUDE_REPO"
    git clone "$DOTCLAUDE_REPO" .claude
    log_success "Claude workspace cloned"
}

# Function to setup project configuration
setup_project_config() {
    log_info "Setting up project configuration..."

    # Setup CLAUDE.md (project memory) if it doesn't exist
    if [ ! -f "CLAUDE.md" ]; then
        log_info "Creating project CLAUDE.md with workflow import..."
        
cat > "CLAUDE.md" << 'EOF'
# Project Context

This project uses the Claude Code workflow framework.

@.claude/memory/workflow.md

## Project-Specific Context

Add project-specific instructions here.
EOF
        log_success "Project CLAUDE.md created with workflow import"
    else
        log_info "Project CLAUDE.md already exists"
    fi

    # Setup .gitignore entries
    setup_gitignore
}

# Function to setup gitignore
setup_gitignore() {
    local gitignore_entries="
# Claude Code project-specific files
*.local.*
.claude/settings.local.json
.claude/project-config.json
.claude/.framework_version
"

    if [ -f ".gitignore" ]; then
        if ! grep -q "*.local.*" .gitignore; then
            log_info "Adding Claude Code entries to .gitignore"
            echo "$gitignore_entries" >> .gitignore
        fi
    else
        log_info "Creating .gitignore with Claude Code entries"
        echo "$gitignore_entries" > .gitignore
    fi
}

# Function to setup GitHub Projects integration
setup_github_projects() {
    if [ -d ".git" ] && command -v gh >/dev/null 2>&1; then
        log_info "Setting up GitHub Projects integration..."
        
        # Make utilities executable
        chmod +x .claude/utils/*.sh 2>/dev/null || true
        
        # Run project config setup if needed
        if [ ! -f ".claude/project-config.json" ] || ! jq -e '.project.number' ".claude/project-config.json" >/dev/null 2>&1; then
            log_info "Configuring GitHub Projects integration..."
            bash ".claude/utils/get-project-config.sh" < /dev/tty || log_warning "GitHub Projects setup skipped"
        fi
        
        log_success "GitHub Projects integration ready"
    else
        log_warning "GitHub CLI not found or not a git repository - skipping GitHub Projects setup"
    fi
}

# Main installation flow
main() {
    log_info "Claude Code Workspace Installer"
    log_info "==============================="
    
    # Install shell integration first (works globally)
    install_shell_integration
    
    # Only setup workspace if we're in a project directory
    if [ -d ".git" ]; then
        log_info "Detected git repository, setting up project workspace..."
        setup_claude_workspace
        setup_project_config
        setup_github_projects
        
        log_success "Installation complete!"
        echo ""
        log_info "Available Commands:"
        echo "  Planning: ccf, ccbd, ccim, ccb"
        echo "  Implementation: cci, ccfi, ccc, ccpr"
        echo "  Workspace: ccsync, ccpush"
        echo "  Help: cchelp"
        echo ""
        log_info "Run: source ~/.zshrc (or restart terminal)"
        echo ""
        log_info "Claude Code REPL commands:"
        echo "  /project:feature \"description\""
        echo "  /project:breakdown 123"
        echo "  /project:implement \"tech task\""
        echo "  /project:do-issue 123"
        
    else
        log_success "Shell integration installed!"
        echo ""
        log_info "To setup a project workspace:"
        echo "  1. Navigate to a git repository"
        echo "  2. Run the installer again"
        echo ""
        log_info "Run: source ~/.zshrc (or restart terminal)"
    fi
}

# Check for required tools
check_requirements() {
    if ! command -v git >/dev/null 2>&1; then
        log_error "Git is required but not installed"
        exit 1
    fi
    
    if ! command -v jq >/dev/null 2>&1; then
        log_warning "jq not found - some features may not work properly"
    fi
}

# Run the installer
check_requirements
main