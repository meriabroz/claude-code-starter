# Global Instructions

These instructions apply to every project on this machine. Project-specific rules live in each
project's own `CLAUDE.md` at its repo root. Detailed behavior rules live in `~/.claude/rules/`
(auto-loaded every session) — this file is the orientation layer that ties them together.

> Personalize this file. Add who you are, your primary stack, and the preferences that matter to you.

---

## Communication

- Be concise. Lead with the answer, then the reasoning.
- No emojis unless asked.
- When referencing code, include `file_path:line_number` — it's clickable.
- Show code, not prose descriptions of code.
- Ask inline when genuinely blocked; don't act on ambiguity, but don't over-ask either. Pick the
  obvious default, state it, and proceed.

## The quality bar

Production-ready on the first write. No TODO stubs, no placeholder logic, no "good enough" passes.
Strong typing where the language supports it. No swallowed errors or silent failures. No magic
numbers. Self-documenting names; comment only the non-obvious *why*. Latest stable frameworks and
idioms. Full standard in `~/.claude/rules/engineering-standard.md`.

## Working principles

- **Read before editing.** Never edit a file you haven't read. Read the full code path before
  proposing a change.
- **Keep diffs minimal.** Change only what the task needs. Don't refactor, rename, or "improve"
  surrounding code unless that's the task.
- **Prefer editing existing files** over creating new ones. Don't build abstractions for one-off work.
- **Fix root causes, not symptoms.** No band-aids, no temporary patches left in place.

## Delivering work — done means it works

Deliver what was asked, at the scope intended, and finish the whole task. Check it the way it could
realistically break, ship it the way the project ships, and report in a few lines what you checked
and what you didn't. How much checking each kind of change needs is in
`~/.claude/rules/definition-of-done.md`, which is a ceiling as much as a floor. There are no review
passes of your own work unless the user asks for one. Details: `~/.claude/rules/execution-first.md`.

## Sessions and the work queue

A big ask gets planned into queue items with `/plan-work`. Each later session takes one item with
`/next` and finishes it (`~/.claude/rules/work-queue.md`). A new task gets a fresh session or
`/clear`. Never stop a task partway because the session is long.

## The rule files (Tier 0 — auto-loaded every session)

| File | Covers |
|---|---|
| `execution-first.md` | Deliver the whole task at the intended scope; delegate rarely; lead with the outcome. |
| `definition-of-done.md` | How much checking is enough per kind of change; no review passes by default. |
| `work-queue.md` | Plan once, then one item per session, with a professional checklist instead of review. |
| `engineering-standard.md` | The overall quality bar — code, design, planning. |
| `coding-standards.md` | Concrete coding do's and don'ts. |
| `git-workflow.md` | When and how to commit; stage by name; never force-push main. |
| `memory-discipline.md` | What to save to persistent memory, and what not to. |
| `file-hygiene.md` | The dedicated-workspace model + protected zones. |
| `context-management.md` | Keeping sessions lean; compaction; when to start fresh. |

Commands: `/plan-work <ask>` plans a big ask into the queue; `/next [project]` works one item.

How config is organized (and how to keep it from bloating): `~/.claude/ARCHITECTURE.md`.

## Memory

Persistent file-based memory lives at `~/.claude/projects/<scope>/memory/`. Save durable cross-session
knowledge there — root causes, non-obvious facts, decisions-with-reasons. Don't save what the repo
already records or what only matters to the current conversation. See `memory-discipline.md`.

## Safety guardrails (enforced by hooks)

A few things are blocked at the hook layer, not left to judgment:
- `rm -rf`, `git push --force`, `git reset --hard`, `sudo`, pipe-to-shell, disk ops → blocked.
- Writes to credential paths (`~/.ssh`, `~/.aws`, etc.) and system paths → blocked.
A blocked command is a speed bump, not a dead end — find the safe alternative (move to a temp dir
instead of deleting, download-then-review instead of pipe-to-shell) and keep going.
