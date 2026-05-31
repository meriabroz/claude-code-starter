#!/bin/bash
# Hook: save-context-before-compact (PreCompact)
# Before context is compressed, inject project state so it survives compaction.
# Stdout from a PreCompact hook is added back into Claude's context.

for state_file in \
  "./CONTEXT_STATE.md" \
  "./context_state.md" \
  "./.claude/CONTEXT_STATE.md" \
  "./CLAUDE.md"; do
  if [ -f "$state_file" ]; then
    echo "=== Project state (preserved from $state_file across compaction) ==="
    cat "$state_file"
    echo "=== End project state ==="
    exit 0
  fi
done

exit 0
