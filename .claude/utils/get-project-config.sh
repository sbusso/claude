#!/bin/bash

CONFIG_FILE=".claude/project-config.json"

# Skip if already configured
if [ -f "$CONFIG_FILE" ] && grep -q '"number"' "$CONFIG_FILE" 2>/dev/null; then
    exit 0
fi

# Get repo info from git remote
REPO_URL=$(git remote get-url origin 2>/dev/null)
OWNER=$(echo "$REPO_URL" | sed 's/.*github\.com[:/]\([^/]*\).*/\1/')
REPO=$(echo "$REPO_URL" | sed 's/.*github\.com[:/][^/]*\/\([^.]*\).*/\1/')

if [ -z "$OWNER" ] || [ -z "$REPO" ]; then
    echo "No valid GitHub remote found"
    exit 1
fi

echo "Repository: $OWNER/$REPO"


# Show projects
echo "Available projects:"
gh project list --owner "$OWNER" || exit 1

echo
read -p "Project number: " NUM

if [[ ! "$NUM" =~ ^[0-9]+$ ]]; then
    echo "Invalid number"
    exit 1
fi

# Get project name
NAME=$(gh project view "$NUM" --owner "$OWNER" --format json | jq -r '.title')

# Get current branch and additional repo info
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")

# Save comprehensive config
cat > "$CONFIG_FILE" << EOF
{
  "repository": {
    "owner": "$OWNER",
    "name": "$REPO",
    "full_name": "$OWNER/$REPO",
    "url": "$REPO_URL",
    "default_branch": "$DEFAULT_BRANCH",
    "current_branch": "$CURRENT_BRANCH"
  },
  "project": {
    "number": $NUM,
    "name": "$NAME",
    "owner": "$OWNER"
  },
  "workflow": {
    "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "framework_version": "latest"
  }
}
EOF

echo ""
echo "✅ Project configured: $NAME (#$NUM)"
echo "📁 Repository: $OWNER/$REPO"
echo "🌿 Branch: $CURRENT_BRANCH"