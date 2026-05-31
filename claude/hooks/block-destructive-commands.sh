#!/bin/bash
# Hook: block-destructive-commands (PreToolUse on Bash)
# Blocks dangerous commands that could destroy work or compromise security.
# Exit 2 = block the command + show stderr to Claude as feedback.

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name // empty' 2>/dev/null || echo "")
[ "$tool_name" != "Bash" ] && exit 0

command=$(echo "$input" | jq -r '.tool_input.command // empty' 2>/dev/null || echo "")
[ -z "$command" ] && exit 0

# rm -rf / rm -fr — irreversible deletion
if echo "$command" | grep -qE 'rm\s+-(rf|fr)\b'; then
  echo "BLOCKED: 'rm -rf' is destructive and irreversible." >&2
  echo "Move the target to a trash/temp directory instead, or ask the user to delete it manually." >&2
  exit 2
fi

# git push --force — overwrites remote history
if echo "$command" | grep -qE 'git\s+push\s.*(--force|-f)\b'; then
  echo "BLOCKED: force push can overwrite remote history others depend on." >&2
  echo "Use 'git push' without --force. If truly needed on your own branch, ask the user to run it." >&2
  exit 2
fi

# git reset --hard — destroys uncommitted work
if echo "$command" | grep -qE 'git\s+reset\s+--hard'; then
  echo "BLOCKED: 'git reset --hard' destroys uncommitted changes." >&2
  echo "Use 'git stash' to save work first, or ask the user for confirmation." >&2
  exit 2
fi

# sudo — privilege escalation
if echo "$command" | grep -qE '(^|\s)sudo\s'; then
  echo "BLOCKED: sudo requires explicit user action." >&2
  echo "Describe what's needed and ask the user to run it manually." >&2
  exit 2
fi

# pipe-to-shell — running unreviewed remote code
if echo "$command" | grep -qE '(curl|wget)\s.*\|\s*(bash|sh|zsh)\b'; then
  echo "BLOCKED: piping a download straight into a shell runs unreviewed code." >&2
  echo "Download the script first, review it, then execute it." >&2
  exit 2
fi

# disk-level operations
if echo "$command" | grep -qE '(^|\s)(mkfs|dd|fdisk|diskutil\s+eraseDisk)\b'; then
  echo "BLOCKED: disk-level operations are extremely destructive." >&2
  echo "Ask the user to run this manually after review." >&2
  exit 2
fi

exit 0
