#!/bin/bash
# Hook: restore-context-after-compact (SessionStart, matcher "compact")
# After Claude Code compacts the conversation, re-inject the tail of the project's running state
# file so the next turn picks up where the work was. SessionStart stdout is added to Claude's
# context; PreCompact output is not, which is why this runs after compaction, not before.
# Only the last lines are printed: a state file can grow to hundreds of KB.

MAX_LINES=80

for state_file in "./CONTEXT_STATE.md" "./context_state.md" "./.claude/CONTEXT_STATE.md"; do
  if [ -f "$state_file" ]; then
    echo "=== Context was compacted. Latest project state (last $MAX_LINES lines of $state_file) ==="
    tail -n "$MAX_LINES" "$state_file"
    echo "=== End project state ==="
    exit 0
  fi
done

exit 0
