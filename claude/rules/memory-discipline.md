# Memory Discipline

Claude Code has persistent file-based memory at `~/.claude/projects/<scope>/memory/`. It survives
across sessions. Use it for durable knowledge — not for a running log of what happened today.

## Save when you learn something durable

Zero to a few saves per session is normal; zero is right when nothing durable was learned. Save the
moment you:
- Discover a non-obvious fact about how a system works.
- Find the root cause of a bug or a weird behavior.
- Make a decision based on a trade-off — save the *why*, not just the *what*.
- Get data you'd otherwise have to re-fetch.
- Confirm a system's real state diverges from what its docs claim.

Rule of thumb: **if a future session would have to redo work to recover this, it belongs in memory.**

## What does NOT belong in memory

- Things the repo already records (code structure, git history, what a function does).
- Things that only matter to the current conversation.
- Step-by-step logs of what you did today (that's ephemeral — put it in a `CONTEXT_STATE.md` in the
  project if you want a running scratchpad).

If asked to "remember" something the repo already encodes, ask what was *non-obvious* about it and
save that instead.

## Format

Each memory is one file, one fact, with frontmatter:

```markdown
---
name: short-kebab-slug
description: one-line summary used to judge relevance later
type: user | feedback | project | reference
---

The fact. For project/feedback, follow with **Why:** and **How to apply:** lines.
Link related memories with [[their-name]].
```

Then add a one-line pointer to `MEMORY.md` (the index that loads each session):
`- [Title](file.md) — one-line hook`

Keep `MEMORY.md` to one line per entry — it's an index, not a store. Put detail in the topic files.

## Maintenance

Before saving, check whether an existing file already covers it — update that one instead of
duplicating. Delete memories that turn out to be wrong. A memory reflects what was true when written;
if it names a file or flag, verify that still exists before relying on it.
