#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Claude Code Status Line Setup ==="
echo ""

# 1. Create .claude directory if not exists
mkdir -p "$HOME/.claude"

# 2. Copy statusline script
cp "$SCRIPT_DIR/statusline-script.py" "$HOME/.claude/statusline-script.py"
echo "[1] statusline-script.py copied to ~/.claude/"

# 3. Update settings.json with statusLine config
SETTINGS_FILE="$HOME/.claude/settings.json"

if [ -f "$SETTINGS_FILE" ]; then
    # Check if statusLine already exists
    if python3 -c "
import json, sys
with open('$SETTINGS_FILE') as f:
    data = json.load(f)
if 'statusLine' in data:
    sys.exit(0)
sys.exit(1)
" 2>/dev/null; then
        echo "[2] statusLine already configured in settings.json, skipping."
    else
        # Add statusLine to existing settings.json
        python3 -c "
import json
with open('$SETTINGS_FILE') as f:
    data = json.load(f)
data['statusLine'] = {
    'type': 'command',
    'command': 'python3 ~/.claude/statusline-script.py'
}
with open('$SETTINGS_FILE', 'w') as f:
    json.dump(data, f, indent=2)
    f.write('\n')
"
        echo "[2] statusLine added to settings.json"
    fi
else
    # Create new settings.json
    cat > "$SETTINGS_FILE" << 'SETTINGS_EOF'
{
  "statusLine": {
    "type": "command",
    "command": "python3 ~/.claude/statusline-script.py"
  }
}
SETTINGS_EOF
    echo "[2] settings.json created with statusLine config"
fi

echo ""
echo "Done! Restart Claude Code to see the status line."
echo "  Shows: time | model | project folder | git branch"
