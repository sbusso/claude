#!/bin/bash
# get-project-config.sh - Auto-discover and cache project configuration

CONFIG_FILE=".claude/project-config.json"

# Function to get repository info
get_repo_info() {
    local repo_url=$(git remote get-url origin 2>/dev/null)
    if [[ -z "$repo_url" ]]; then
        echo "❌ Not in a git repository with GitHub remote"
        exit 1
    fi
    
    local repo_path=$(echo "$repo_url" | sed 's/.*github\.com[:/]\([^.]*\)\.git.*/\1/')
    local owner=$(echo "$repo_path" | cut -d'/' -f1)
    
    echo "$repo_path|$owner"
}

# Function to discover project
discover_project() {
    local owner="$1"
    local project_name="${2:-Test}"
    
    # Get project list and find matching project
    local project_info=$(gh project list --owner "$owner" --format json | \
        jq -r --arg name "$project_name" '.projects[] | select(.title == $name) | "\(.number)|\(.id)|\(.title)"')
    
    if [[ -z "$project_info" ]]; then
        echo "❌ Project '$project_name' not found"
        echo "Available projects:"
        gh project list --owner "$owner" | grep -v "^ID"
        exit 1
    fi
    
    echo "$project_info"
}

# Function to get project fields
get_project_fields() {
    local owner="$1"
    local project_number="$2"
    
    gh api graphql -f query='query($owner: String!, $number: Int!) {
        user(login: $owner) {
            projectV2(number: $number) {
                id
                fields(first: 20) {
                    nodes {
                        ... on ProjectV2Field {
                            id
                            name
                            dataType
                        }
                        ... on ProjectV2SingleSelectField {
                            id
                            name
                            dataType
                            options {
                                id
                                name
                            }
                        }
                        ... on ProjectV2IterationField {
                            id
                            name
                            dataType
                            configuration {
                                iterations {
                                    id
                                    title
                                    startDate
                                    duration
                                }
                            }
                        }
                    }
                }
            }
        }
    }' -f owner="$owner" -F number="$project_number" | \
    jq '.data.user.projectV2'
}

# Main function
main() {
    echo "🔍 Discovering project configuration..."
    
    # Get repository info
    IFS='|' read -r repo_path owner <<< "$(get_repo_info)"
    echo "📁 Repository: $repo_path"
    echo "👤 Owner: $owner"
    
    # Use argument or default project name
    local project_name="${1:-Test}"
    echo "🎯 Target project: $project_name"
    
    # Discover project
    IFS='|' read -r project_number project_id project_title <<< "$(discover_project "$owner" "$project_name")"
    echo "📊 Project: $project_title (#$project_number)"
    
    # Get project fields
    echo "🔍 Discovering project fields..."
    local fields_data=$(get_project_fields "$owner" "$project_number")
    
    # Create configuration file
    cat > "$CONFIG_FILE" << EOF
{
  "repository": "$repo_path",
  "owner": "$owner",
  "project": {
    "id": "$project_id",
    "number": $project_number,
    "name": "$project_title"
  },
  "fields": {
EOF

    # Process Status field
    local status_field=$(echo "$fields_data" | jq '.fields.nodes[] | select(.name == "Status")')
    if [[ -n "$status_field" && "$status_field" != "null" ]]; then
        local status_id=$(echo "$status_field" | jq -r '.id')
        cat >> "$CONFIG_FILE" << EOF
    "status": {
      "id": "$status_id",
      "options": {
EOF
        echo "$status_field" | jq -r '.options[]? | "        \"\(.name | ascii_downcase | gsub(" "; "_"))\": \"\(.id)\","' | sed '$ s/,$//' >> "$CONFIG_FILE"
        cat >> "$CONFIG_FILE" << EOF
      }
    },
EOF
    fi

    # Process Iteration field
    local iteration_field=$(echo "$fields_data" | jq '.fields.nodes[] | select(.name == "Iteration")')
    if [[ -n "$iteration_field" && "$iteration_field" != "null" ]]; then
        local iteration_id=$(echo "$iteration_field" | jq -r '.id')
        local current_iteration=$(echo "$iteration_field" | jq -r '.configuration.iterations[0].id // empty')
        cat >> "$CONFIG_FILE" << EOF
    "iteration": {
      "id": "$iteration_id",
      "current": "$current_iteration",
      "iterations": {
EOF
        echo "$iteration_field" | jq -r '.configuration.iterations[]? | "        \"" + .id + "\": {\"title\": \"" + .title + "\", \"startDate\": \"" + (.startDate // "") + "\"},"' | sed '$ s/,$//' >> "$CONFIG_FILE"
        cat >> "$CONFIG_FILE" << EOF
      }
    },
EOF
    fi

    # Process Priority field
    local priority_field=$(echo "$fields_data" | jq '.fields.nodes[] | select(.name == "Priority")')
    if [[ -n "$priority_field" && "$priority_field" != "null" ]]; then
        local priority_id=$(echo "$priority_field" | jq -r '.id')
        cat >> "$CONFIG_FILE" << EOF
    "priority": {
      "id": "$priority_id",
      "options": {
EOF
        echo "$priority_field" | jq -r '.options[]? | "        \"\(.name | ascii_downcase)\": \"\(.id)\","' | sed '$ s/,$//' >> "$CONFIG_FILE"
        cat >> "$CONFIG_FILE" << EOF
      }
    },
EOF
    fi

    # Process Size field
    local size_field=$(echo "$fields_data" | jq '.fields.nodes[] | select(.name == "Size")')
    if [[ -n "$size_field" && "$size_field" != "null" ]]; then
        local size_id=$(echo "$size_field" | jq -r '.id')
        cat >> "$CONFIG_FILE" << EOF
    "size": {
      "id": "$size_id",
      "options": {
EOF
        echo "$size_field" | jq -r '.options[]? | "        \"\(.name | ascii_downcase)\": \"\(.id)\","' | sed '$ s/,$//' >> "$CONFIG_FILE"
        cat >> "$CONFIG_FILE" << EOF
      }
    }
EOF
    fi

    # Close the configuration file
    cat >> "$CONFIG_FILE" << EOF
  },
  "last_updated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

    echo "✅ Configuration saved to $CONFIG_FILE"
    echo ""
    echo "📋 Summary:"
    jq -r '"Repository: " + .repository, "Project: " + .project.name + " (#" + (.project.number | tostring) + ")", "Status options: " + ((.fields.status.options | keys | join(", ")) // "none"), "Current iteration: " + (.fields.iteration.current // "none")' "$CONFIG_FILE"
}

# Run if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi