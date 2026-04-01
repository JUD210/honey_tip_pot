#!/usr/bin/env python3
import json
import sys
import os
import subprocess
from datetime import datetime

# ANSI Color codes for vibrant terminal display
class Colors:
    RESET = '\033[0m'
    BOLD = '\033[1m'

    # Bright colors
    BRIGHT_CYAN = '\033[96m'
    BRIGHT_MAGENTA = '\033[95m'
    BRIGHT_YELLOW = '\033[93m'
    BRIGHT_GREEN = '\033[92m'
    BRIGHT_BLUE = '\033[94m'
    BRIGHT_RED = '\033[91m'

    # Background colors
    BG_BLUE = '\033[44m'
    BG_GREEN = '\033[42m'
    BG_YELLOW = '\033[43m'
    BG_MAGENTA = '\033[45m'

def colorize(text, color):
    """Apply color to text"""
    return f"{color}{text}{Colors.RESET}"

def get_git_branch():
    """Get current git branch with fallback"""
    try:
        result = subprocess.run(
            ['git', 'branch', '--show-current'],
            capture_output=True,
            text=True,
            cwd=os.getcwd(),
            timeout=2
        )
        if result.returncode == 0 and result.stdout.strip():
            return result.stdout.strip()
    except:
        pass
    return "no-git"

def main():
    try:
        # Read JSON input from stdin
        input_data = json.loads(sys.stdin.read())

        # Get current time with colorful emoji and styling
        current_time = datetime.now().strftime("%H:%M:%S")
        time_display = colorize(f"🕒 {current_time}", Colors.BRIGHT_CYAN + Colors.BOLD)

        # Get model info with colorful styling
        model_name = input_data.get('model', {}).get('display_name', 'Unknown Model')
        model_display = colorize(f"🤖 {model_name}", Colors.BRIGHT_MAGENTA + Colors.BOLD)

        # Get project info with colorful styling
        current_dir = input_data.get('workspace', {}).get('current_dir', os.getcwd())
        project_name = os.path.basename(current_dir) if current_dir else "unknown"
        project_display = colorize(f"📁 {project_name}", Colors.BRIGHT_YELLOW + Colors.BOLD)

        # Get git branch with colorful styling
        git_branch = get_git_branch()
        if git_branch != "no-git":
            branch_display = colorize(f"🌿 {git_branch}", Colors.BRIGHT_GREEN + Colors.BOLD)
        else:
            branch_display = colorize(f"🚫 {git_branch}", Colors.BRIGHT_RED)

        # Create colorful separator
        separator = colorize(" | ", Colors.BRIGHT_BLUE + Colors.BOLD)

        # Combine with colorful separators
        status_parts = [
            time_display,
            model_display,
            project_display,
            branch_display
        ]

        # Use colorful | as separator
        status_line = separator.join(status_parts)

        print(status_line)

    except Exception as e:
        # Colorful fallback display if anything goes wrong
        fallback_time = datetime.now().strftime("%H:%M:%S")
        fallback_project = os.path.basename(os.getcwd())
        fallback_branch = get_git_branch()

        separator = colorize(" | ", Colors.BRIGHT_BLUE + Colors.BOLD)
        fallback_parts = [
            colorize(f"🕒 {fallback_time}", Colors.BRIGHT_CYAN + Colors.BOLD),
            colorize("🤖 Claude", Colors.BRIGHT_MAGENTA + Colors.BOLD),
            colorize(f"📁 {fallback_project}", Colors.BRIGHT_YELLOW + Colors.BOLD),
            colorize(f"🌿 {fallback_branch}", Colors.BRIGHT_GREEN + Colors.BOLD)
        ]
        print(separator.join(fallback_parts))

if __name__ == "__main__":
    main()
