#!/bin/bash
# merge-mcp.sh - Smart JSON merge for .mcp.json files

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <existing-mcp.json> <template-mcp.json>"
    exit 1
fi

EXISTING_FILE="$1"
TEMPLATE_FILE="$2"

if [ ! -f "$EXISTING_FILE" ]; then
    echo "Error: Existing file '$EXISTING_FILE' not found"
    exit 1
fi

if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Template file '$TEMPLATE_FILE' not found"
    exit 1
fi

# Check if jq is available
if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq is required for JSON merging but not installed"
    exit 1
fi

# Validate JSON files
if ! jq empty "$EXISTING_FILE" 2>/dev/null; then
    echo "Error: '$EXISTING_FILE' is not valid JSON"
    exit 1
fi

if ! jq empty "$TEMPLATE_FILE" 2>/dev/null; then
    echo "Error: '$TEMPLATE_FILE' is not valid JSON"
    exit 1
fi

# Create backup
BACKUP_FILE="${EXISTING_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
cp "$EXISTING_FILE" "$BACKUP_FILE"
echo "📋 Created backup: $BACKUP_FILE"

# Extract framework MCPs from template
FRAMEWORK_MCPS=$(jq -r '.mcpServers | keys[]' "$TEMPLATE_FILE" 2>/dev/null || echo "")

if [ -z "$FRAMEWORK_MCPS" ]; then
    echo "⚠️  No MCPs found in template file"
    exit 0
fi

# Check which framework MCPs are already present
EXISTING_MCPS=$(jq -r '.mcpServers | keys[]' "$EXISTING_FILE" 2>/dev/null || echo "")
NEW_MCPS=""
UPDATED_MCPS=""

for mcp in $FRAMEWORK_MCPS; do
    if echo "$EXISTING_MCPS" | grep -q "^${mcp}$"; then
        # MCP exists - check if it needs updating
        EXISTING_CONFIG=$(jq ".mcpServers.\"$mcp\"" "$EXISTING_FILE")
        TEMPLATE_CONFIG=$(jq ".mcpServers.\"$mcp\"" "$TEMPLATE_FILE")
        
        if [ "$EXISTING_CONFIG" != "$TEMPLATE_CONFIG" ]; then
            UPDATED_MCPS="$UPDATED_MCPS $mcp"
        fi
    else
        # MCP is new
        NEW_MCPS="$NEW_MCPS $mcp"
    fi
done

# If no changes needed
if [ -z "$NEW_MCPS" ] && [ -z "$UPDATED_MCPS" ]; then
    echo "✅ All framework MCPs already present and up-to-date"
    rm "$BACKUP_FILE"  # Remove backup since no changes made
    exit 0
fi

# Perform the merge
TEMP_FILE=$(mktemp)

# Start with existing configuration and add/update framework MCPs
jq --slurpfile template <(jq '.mcpServers' "$TEMPLATE_FILE") '
    .mcpServers as $existing |
    $template[0] as $framework |
    .mcpServers = ($existing + $framework)
' "$EXISTING_FILE" > "$TEMP_FILE"

# Validate merged result
if jq empty "$TEMP_FILE" 2>/dev/null; then
    mv "$TEMP_FILE" "$EXISTING_FILE"
    
    # Report what was done
    if [ -n "$NEW_MCPS" ]; then
        echo "📦 Added new MCPs:$(echo $NEW_MCPS | sed 's/ /, /g')"
    fi
    
    if [ -n "$UPDATED_MCPS" ]; then
        echo "🔄 Updated existing MCPs:$(echo $UPDATED_MCPS | sed 's/ /, /g')"
    fi
    
    echo "✅ Successfully merged MCP configurations"
else
    echo "❌ Merge failed - JSON validation error"
    echo "📋 Original file restored from backup"
    rm "$TEMP_FILE"
    exit 1
fi