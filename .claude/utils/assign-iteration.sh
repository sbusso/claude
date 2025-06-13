#!/bin/bash
# assign-iteration.sh - Assign project items to iterations

CONFIG_FILE=".claude/project-config.json"

# Function to load configuration
load_config() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "❌ Project configuration not found. Run: .claude/utils/get-project-config.sh"
        exit 1
    fi
}

# Function to get item ID from issue number
get_item_id() {
    local issue_number="$1"
    local repo=$(jq -r '.repository' "$CONFIG_FILE")
    local project_number=$(jq -r '.project.number' "$CONFIG_FILE")
    local owner=$(jq -r '.owner' "$CONFIG_FILE")
    
    gh project item-list "$project_number" --owner "$owner" --format json | \
    jq -r ".items[] | select(.content.number == $issue_number) | .id"
}

# Function to assign iteration
assign_iteration() {
    local issue_number="$1"
    local iteration="$2"
    
    load_config
    
    local project_id=$(jq -r '.project.id' "$CONFIG_FILE")
    local iteration_field_id=$(jq -r '.fields.iteration.id' "$CONFIG_FILE")
    
    # Handle special case for "current"
    local iteration_id
    if [[ "$iteration" == "current" ]]; then
        iteration_id=$(jq -r '.fields.iteration.current' "$CONFIG_FILE")
    else
        iteration_id=$(jq -r ".fields.iteration.iterations.$iteration.id // empty" "$CONFIG_FILE")
        if [[ -z "$iteration_id" ]]; then
            # Try to find by title
            iteration_id=$(jq -r ".fields.iteration.iterations | to_entries[] | select(.value.title == \"$iteration\") | .key" "$CONFIG_FILE")
        fi
    fi
    
    if [[ -z "$iteration_id" ]]; then
        echo "❌ Invalid iteration: $iteration"
        echo "Available iterations:"
        jq -r '.fields.iteration.iterations | to_entries[] | "  " + .value.title + " (id: " + .key + ")"' "$CONFIG_FILE"
        exit 1
    fi
    
    local item_id=$(get_item_id "$issue_number")
    if [[ -z "$item_id" ]]; then
        echo "❌ Issue #$issue_number not found in project"
        exit 1
    fi
    
    echo "📅 Assigning issue #$issue_number to iteration: $iteration"
    
    gh project item-edit \
        --id "$item_id" \
        --project-id "$project_id" \
        --field-id "$iteration_field_id" \
        --iteration-id "$iteration_id"
    
    if [[ $? -eq 0 ]]; then
        echo "✅ Issue #$issue_number assigned to iteration"
    else
        echo "❌ Failed to assign issue #$issue_number to iteration"
        exit 1
    fi
}

# Main function
main() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: $0 <issue_number> <iteration>"
        echo "Example: $0 123 current"
        echo "Example: $0 123 \"Iteration 2\""
        exit 1
    fi
    
    assign_iteration "$1" "$2"
}

# Run if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi