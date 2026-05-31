#!/bin/bash
# Hook: session-git-status (SessionStart)
# Prints a short git snapshot at session start so Claude knows the repo state
# before touching anything. Stdout from a SessionStart hook is added to context.
# Stays silent (and harmless) when the working directory isn't a git repo.

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
echo "=== Git snapshot (session start) ==="
echo "Branch: ${branch:-unknown}"

# Ahead/behind the upstream, if one is set.
upstream=$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)
if [ -n "$upstream" ]; then
  counts=$(git rev-list --left-right --count "${upstream}...HEAD" 2>/dev/null || echo "")
  if [ -n "$counts" ]; then
    behind=$(echo "$counts" | awk '{print $1}')
    ahead=$(echo "$counts" | awk '{print $2}')
    echo "Upstream: $upstream (ahead $ahead, behind $behind)"
  fi
else
  echo "Upstream: none set"
fi

dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
if [ "$dirty" != "0" ]; then
  echo "Working tree: $dirty uncommitted change(s)"
  git status --short 2>/dev/null | head -15
  [ "$dirty" -gt 15 ] && echo "... (+$((dirty - 15)) more)"
else
  echo "Working tree: clean"
fi

echo "Recent commits:"
git log -3 --oneline 2>/dev/null
echo "=== End git snapshot ==="
exit 0
