#!/bin/bash
# bootstrap.sh - Always fetch and run the latest install.sh
# This ensures no caching issues with the one-liner installation

set -e

echo "🚀 Claude Workflow Framework Bootstrap"
echo "📥 Fetching latest installer..."

# Generate timestamp for cache busting
TIMESTAMP=$(date +%s)

# Download latest install.sh with cache busting
TEMP_INSTALLER=$(mktemp)
curl -sSL \
  -H "Cache-Control: no-cache" \
  -H "Pragma: no-cache" \
  "https://raw.githubusercontent.com/sbusso/claude-workflow/main/install.sh?t=$TIMESTAMP" \
  -o "$TEMP_INSTALLER"

# Verify we got a valid script
if ! head -1 "$TEMP_INSTALLER" | grep -q "#!/"; then
    echo "❌ Failed to download valid installer"
    rm -f "$TEMP_INSTALLER"
    exit 1
fi

echo "✅ Latest installer downloaded"
echo "🔧 Running installation..."
echo ""

# Make executable and run with all arguments
chmod +x "$TEMP_INSTALLER"
"$TEMP_INSTALLER" "$@"

# Clean up
rm -f "$TEMP_INSTALLER"