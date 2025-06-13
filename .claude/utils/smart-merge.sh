#!/bin/bash
# Smart merge utility using Claude Code

USAGE="Usage: $0 <file-type> <existing-file> <framework-file> [output-file]
Examples:
  $0 claude-md CLAUDE.md .claude/templates/CLAUDE.md
  $0 mcp-json .mcp.json framework/.mcp.json merged.mcp.json
  $0 command existing-command.md new-command.md"

if [ $# -lt 3 ]; then
    echo "$USAGE"
    exit 1
fi

FILE_TYPE="$1"
EXISTING_FILE="$2" 
FRAMEWORK_FILE="$3"
OUTPUT_FILE="${4:-$EXISTING_FILE}"

# Check if Claude Code is available
if ! command -v claude >/dev/null 2>&1; then
    echo "❌ Claude Code not found. Please install Claude Code first."
    exit 1
fi

# Check if input files exist
if [ ! -f "$EXISTING_FILE" ]; then
    echo "❌ Existing file not found: $EXISTING_FILE"
    exit 1
fi

if [ ! -f "$FRAMEWORK_FILE" ]; then
    echo "❌ Framework file not found: $FRAMEWORK_FILE"
    exit 1
fi

echo "🤖 Using Claude for intelligent merge..."
echo "📁 Existing: $EXISTING_FILE"
echo "📁 Framework: $FRAMEWORK_FILE"
echo "📁 Output: $OUTPUT_FILE"

# Create backup if overwriting existing file
if [ "$OUTPUT_FILE" = "$EXISTING_FILE" ]; then
    BACKUP_FILE="${EXISTING_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$EXISTING_FILE" "$BACKUP_FILE"
    echo "💾 Backup created: $BACKUP_FILE"
fi

# Perform merge based on file type
case "$FILE_TYPE" in
    "claude-md"|"CLAUDE.md")
        claude "$(cat << EOF
Intelligently merge these two CLAUDE.md files, preserving project-specific content while adding framework capabilities:

**Existing CLAUDE.md:**
$(cat "$EXISTING_FILE")

**Framework template:**
$(cat "$FRAMEWORK_FILE")

Requirements:
- Preserve all existing project-specific content and workflows
- Add framework sections (Development Workflow, Smart Testing Philosophy, Available Tools & MCPs, etc.)
- Merge overlapping sections intelligently rather than duplicating
- Maintain logical document structure and readability
- Keep any team-specific conventions and standards
- Output the complete merged CLAUDE.md file

Create a well-structured merged file that combines both effectively.
EOF
)" > "$OUTPUT_FILE.tmp" && mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
        ;;
    
    "mcp-json"|".mcp.json")
        claude "$(cat << EOF
Merge these two MCP JSON configurations intelligently:

**Existing .mcp.json:**
$(cat "$EXISTING_FILE")

**Framework .mcp.json:**
$(cat "$FRAMEWORK_FILE")

Requirements:
- Preserve all existing custom MCP server configurations
- Add framework MCPs (context7, playwright, github) if not already present
- Avoid duplicate server definitions
- Maintain valid JSON structure
- Keep any custom server arguments or configurations

Output the complete merged JSON configuration.
EOF
)" > "$OUTPUT_FILE.tmp" && mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
        ;;
    
    "command"|"*.md")
        claude "$(cat << EOF
Compare and merge these command files intelligently:

**Existing command:**
$(cat "$EXISTING_FILE")

**Framework command:**
$(cat "$FRAMEWORK_FILE")

Requirements:
- Preserve any user customizations to workflow steps
- Update to latest framework features and improvements
- Maintain \$ARGUMENTS compatibility and command structure
- Keep any project-specific adaptations
- Ensure command follows framework patterns

Create an updated command that incorporates framework improvements while preserving customizations.
EOF
)" > "$OUTPUT_FILE.tmp" && mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
        ;;
    
    *)
        echo "❌ Unknown file type: $FILE_TYPE"
        echo "Supported types: claude-md, mcp-json, command"
        exit 1
        ;;
esac

if [ $? -eq 0 ] && [ -f "$OUTPUT_FILE" ]; then
    echo "✅ Smart merge completed successfully"
    echo "📄 Output written to: $OUTPUT_FILE"
    
    # Validate output based on file type
    case "$FILE_TYPE" in
        "mcp-json"|".mcp.json")
            if ! python3 -m json.tool "$OUTPUT_FILE" >/dev/null 2>&1 && ! jq empty "$OUTPUT_FILE" >/dev/null 2>&1; then
                echo "⚠️  Warning: Output JSON may not be valid. Please review."
            else
                echo "✅ JSON validation passed"
            fi
            ;;
    esac
else
    echo "❌ Smart merge failed"
    if [ -f "$BACKUP_FILE" ]; then
        echo "🔄 Restoring from backup..."
        cp "$BACKUP_FILE" "$OUTPUT_FILE"
    fi
    exit 1
fi