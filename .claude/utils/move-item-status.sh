#!/bin/bash
# move-item-status.sh - Move project items between statuses

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

# Function to move item status
move_status() {
    local issue_number="$1"
    local status="$2"
    
    load_config
    
    local project_id=$(jq -r '.project.id' "$CONFIG_FILE")
    local status_field_id=$(jq -r '.fields.status.id' "$CONFIG_FILE")
    local status_option_id=$(jq -r ".fields.status.options.$status" "$CONFIG_FILE")
    
    if [[ "$status_option_id" == "null" ]]; then
        echo "❌ Invalid status: $status"
        echo "Available statuses: $(jq -r '.fields.status.options | keys | join(", ")' "$CONFIG_FILE")"
        exit 1
    fi
    
    local item_id=$(get_item_id "$issue_number")
    if [[ -z "$item_id" ]]; then
        echo "❌ Issue #$issue_number not found in project"
        exit 1
    fi
    
    echo "📋 Moving issue #$issue_number to status: $status"
    
    gh project item-edit \
        --id "$item_id" \
        --project-id "$project_id" \
        --field-id "$status_field_id" \
        --single-select-option-id "$status_option_id"
    
    if [[ $? -eq 0 ]]; then
        echo "✅ Issue #$issue_number moved to $status"
    else
        echo "❌ Failed to move issue #$issue_number"
        exit 1
    fi
}

# Main function
main() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: $0 <issue_number> <status>"
        echo "Example: $0 123 todo"
        echo "Example: $0 123 in_progress"
        exit 1
    fi
    
    move_status "$1" "$2"
}

# Run if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi