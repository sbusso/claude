#!/bin/bash
# get-project-config.sh - Simple project configuration

CONFIG_FILE=".claude/project-config.json"

# Check if config exists
if [[ -f "$CONFIG_FILE" ]] && jq -e '.project.number' "$CONFIG_FILE" >/dev/null 2>&1; then
    echo "✅ Project already configured:"
    jq -r '"Project: \(.project.name // "Unknown") (#\(.project.number))"' "$CONFIG_FILE"
    exit 0
fi

# Get repo info
REPO_URL=$(git remote get-url origin 2>/dev/null)
if [[ -z "$REPO_URL" ]]; then
    echo "❌ No GitHub remote found"
    exit 1
fi

OWNER=$(echo "$REPO_URL" | sed 's/.*github\.com[:/]\([^/]*\).*/\1/')
REPO=$(echo "$REPO_URL" | sed 's/.*github\.com[:/][^/]*\/\([^.]*\).*/\1/')

echo "📁 Repository: $OWNER/$REPO"

# Show projects
echo ""
echo "📋 Available projects:"
gh project list --owner "$OWNER" || exit 1

echo ""
if [ -t 0 ]; then
    # Interactive terminal
    read -p "Enter project number: " PROJECT_NUMBER
else
    # Non-interactive - skip setup
    echo "⚠️  Non-interactive mode detected. Run manually later:"
    echo "   .claude/utils/get-project-config.sh"
    exit 0
fi

if [[ ! "$PROJECT_NUMBER" =~ ^[0-9]+$ ]]; then
    echo "❌ Invalid number"
    exit 1
fi

# Get project name
PROJECT_NAME=$(gh project view "$PROJECT_NUMBER" --owner "$OWNER" --format json | jq -r '.title')

# Create config
cat > "$CONFIG_FILE" << EOF
{
  "repository": "$OWNER/$REPO",
  "owner": "$OWNER",
  "project": {
    "number": $PROJECT_NUMBER,
    "name": "$PROJECT_NAME"
  }
}
EOF

echo "✅ Project configured: $PROJECT_NAME (#$PROJECT_NUMBER)"