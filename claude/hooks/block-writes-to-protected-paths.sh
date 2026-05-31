#!/bin/bash
# Hook: block-writes-to-protected-paths (PreToolUse on Write/Edit/MultiEdit/NotebookEdit/Bash)
# Blocks writes to credential and system paths, regardless of the task.
# Exit 2 = block + show stderr to Claude as feedback.
#
# To add your own "keep out" zone (e.g. a personal folder), append its absolute
# path to PROTECTED below. Use $HOME so it stays portable.
#
# Escape hatch: append "# allow-protected-write" to a Bash command to bypass the
# Bash check for one intentional, reviewed write.

set -u

# Paths that are never written to. One per line, absolute (with $HOME expanded).
PROTECTED=(
  "$HOME/.ssh"
  "$HOME/.aws"
  "$HOME/.gnupg"
  "$HOME/.kube"
  "$HOME/.git-credentials"
  "$HOME/.gem/credentials"
  "$HOME/.npmrc"
  "$HOME/.pypirc"
  "$HOME/.keys"
  "$HOME/Library/Keychains"
  "/System"
  "/usr"
  "/private/etc"
  # Add your own protected folders here, e.g.:
  # "$HOME/private"
)

input=$(cat)
tool_name=$(printf '%s' "$input" | jq -r '.tool_name // empty' 2>/dev/null || echo "")
[ -z "$tool_name" ] && exit 0

is_protected() {
  # returns 0 (match) if $1 is inside any protected path
  local p="$1" prot
  case "$p" in /*) ;; *) return 1 ;; esac   # only judge absolute paths
  for prot in "${PROTECTED[@]}"; do
    if [ "$p" = "$prot" ] || [ "${p#"$prot"/}" != "$p" ]; then
      return 0
    fi
  done
  return 1
}

case "$tool_name" in
  Write|Edit|MultiEdit)
    path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null || echo "")
    if [ -n "$path" ] && is_protected "$path"; then
      echo "BLOCKED: writing to a protected path is forbidden. Target: $path" >&2
      exit 2
    fi
    ;;
  NotebookEdit)
    path=$(printf '%s' "$input" | jq -r '.tool_input.notebook_path // empty' 2>/dev/null || echo "")
    if [ -n "$path" ] && is_protected "$path"; then
      echo "BLOCKED: writing to a protected path is forbidden. Target: $path" >&2
      exit 2
    fi
    ;;
  Bash)
    cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' 2>/dev/null || echo "")
    printf '%s' "$cmd" | grep -q "# allow-protected-write" && exit 0
    # Match write-ish operations targeting a protected path.
    for prot in "${PROTECTED[@]}"; do
      # escape regex metacharacters in the path
      esc=$(printf '%s' "$prot" | sed 's/[.[\*^$/]/\\&/g')
      if printf '%s' "$cmd" | grep -qE "(>|>>|\btee\b|\bmv\b|\bcp\b|\brsync\b|\btouch\b|\bmkdir\b)[^|&;]*${esc}(/|\b)"; then
        echo "BLOCKED: this command writes to a protected path ($prot)." >&2
        echo "If this is an intentional, reviewed write, append '# allow-protected-write' to the command." >&2
        exit 2
      fi
    done
    ;;
esac

exit 0
