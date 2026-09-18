# Context Management

Long sessions degrade: context fills, detail gets summarized, and quality drops. Manage it actively.

## Keep sessions lean

- Run `/compact` proactively on deep sessions before context gets heavy — don't wait for automatic
  compaction.
- Use `/clear` (or a new session) when switching to an unrelated task.
- Check usage with `/context` before it becomes a problem.

## Don't flood context

- Never read a large file in full when you need one section — read the relevant line range.
- Check size before reading (`wc -l`, `wc -c`); for big logs, read targeted ranges with offset/limit.
- Use search (Glob/Grep) to find the specific files you need rather than reading whole directories.
- For analysis of something large, delegate to a sub-agent rather than loading it all into the main
  context.

## Preserve state across compaction

If a project keeps a running scratchpad (e.g. `CONTEXT_STATE.md` at its root), the included
`restore-context-after-compact.sh` hook (SessionStart, matcher `compact`) re-injects its last lines
after compaction, so the next turn picks up where the work was. Keep that file updated with what
changed and what's next on longer efforts.

## Signals to start fresh

- A new, unrelated task (use `/clear` or a new session). Don't stop a task partway because the
  session is long.

- Context is past ~70% full.
- You've hit the same failing approach 2+ times (a fix loop) — step back, re-read, change tack.
- You're about to load large files or images into a session that's already heavy.
