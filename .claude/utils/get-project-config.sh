#!/bin/bash

CONFIG_FILE=".claude/project-config.json"

# Skip if already configured
if [ -f "$CONFIG_FILE" ] && grep -q '"number"' "$CONFIG_FILE" 2>/dev/null; then
    exit 0
fi

# Get owner from git remote
REPO_URL=$(git remote get-url origin 2>/dev/null)
OWNER=$(echo "$REPO_URL" | sed 's/.*github\.com[:/]\([^/]*\).*/\1/')

if [ -z "$OWNER" ]; then
    echo "No GitHub remote found"
    exit 1
fi


# Show projects
echo "Available projects:"
gh project list --owner "$OWNER" || exit 1

echo
# Force interactive input by reading from terminal directly
if [ -t 0 ]; then
    read -p "Project number: " NUM
else
    # When stdin is not a terminal (piped from curl), read from terminal directly
    exec < /dev/tty
    read -p "Project number: " NUM
fi

if [[ ! "$NUM" =~ ^[0-9]+$ ]]; then
    echo "Invalid number"
    exit 1
fi

# Get project name
NAME=$(gh project view "$NUM" --owner "$OWNER" --format json | jq -r '.title')

# Save config
cat > "$CONFIG_FILE" << EOF
{
  "owner": "$OWNER",
  "project": {
    "number": $NUM,
    "name": "$NAME"
  }
}
EOF

echo "Project configured: $NAME (#$NUM)"