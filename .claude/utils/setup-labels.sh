#!/bin/bash
# setup-labels.sh - Create required labels for Claude Code workflow

# Function to get repository path
get_repo_path() {
    local repo_url=$(git remote get-url origin 2>/dev/null)
    if [[ -z "$repo_url" ]]; then
        echo "❌ Not in a git repository with GitHub remote"
        exit 1
    fi
    echo "$repo_url" | sed 's/.*github\.com[:/]\([^.]*\)\.git.*/\1/'
}

# Function to setup labels
setup_labels() {
    local repo_path=$(get_repo_path)
    echo "🏷️  Setting up labels for $repo_path..."
    
    # Required labels for the workflow
    local labels="feature:0052cc:New feature or enhancement
backlog:fbca04:Item in project backlog
task:1d76db:Implementation task
planned:0e8a16:Item planned for implementation
in-progress:fbca04:Currently being worked on
ready-for-review:0e8a16:Ready for code review
research:5319e7:Research or investigation task
design:f9d0c4:Design or UX task"
    
    echo "$labels" | while IFS=':' read -r label_name color description; do
        if ! gh label list --repo "$repo_path" | grep -q "^$label_name"; then
            if gh label create "$label_name" --color "$color" --description "$description" --repo "$repo_path" 2>/dev/null; then
                echo "  ✅ Created label: $label_name"
            else
                echo "  ⚠️  Failed to create label: $label_name"
            fi
        else
            echo "  ✓ Label exists: $label_name"
        fi
    done
    
    echo "✅ Label setup complete"
}

# Main function
main() {
    setup_labels
}

# Run if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi