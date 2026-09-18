# Claude Config Architecture

A simple model for **what config lives where, and when it loads** — so your setup stays lean and
fast instead of growing into tens of thousands of tokens of boot context that load on every single
session whether they're relevant or not.

## The problem this solves

It's tempting to put everything in `~/.claude/rules/` because those files auto-load every session.
Do that for a few months and your *every-session* context balloons — slower starts, higher cost, and
rules that contradict each other because nobody can hold them all in view. The fix is to separate
content by **when it actually needs to load**, then enforce it with where you put the file.

## The 5 tiers

### Tier 0 — Boot rules
**Loads: every session, every project.** · **Location: `~/.claude/rules/`** · **Keep it small.**

Things that should shape behavior on *any* task in *any* project: your coding standards, your
definition of done, git workflow, communication style. Test: *"Would Claude behave wrong on a generic task in
any project if this didn't load?"* If yes → Tier 0. If no → push it down a tier.

Keep this folder lean (a rough cap of ~20K tokens / ~80KB is a good discipline). When it gets heavy,
demote the lowest-value rule rather than piling on.

### Tier 1 — Project rules
**Loads: when you're working in that project.** · **Location: each project's own `CLAUDE.md` at its repo root.**

Rules specific to one codebase — its conventions, its gotchas, its deploy steps. Test: *"Does this only
matter for one project?"* → put it in that project's `CLAUDE.md`, not the global rules.

### Tier 2 — Workflow playbooks
**Loads: only when you invoke it.** · **Location: `~/.claude/commands/` (slash commands) + a playbook file.**

Deep, multi-step procedures you run occasionally — a release checklist, an audit, a content pipeline.
These don't belong in boot context; they belong behind a slash command that loads them on demand.
Test: *"Is this a procedure I run for a specific task, not a rule for every task?"* → Tier 2.

### Tier 3 — Reference docs
**Loads: explicitly read when needed.** · **Location: `~/.claude/reference/`**

Lookup tables you grep through — not behavior rules. Tier 0 should contain a one-line pointer to each
("for X, read `~/.claude/reference/x.md`") so Claude knows it exists.

### Tier 4 — Memory
**Loads: an index auto-loads; detail is read on lookup.** · **Location: `~/.claude/projects/<scope>/memory/`**

Durable cross-session knowledge. Keep `MEMORY.md` as a strict one-line-per-entry index; put the detail
in topic files. Prune stale entries periodically.

## Test before adding anything

1. Apply the tier test above — which tier does this belong in?
2. If Tier 0: confirm the folder is still lean after adding. If not, demote something first.
3. If Tier 2: create the playbook *and* the slash command that loads it — don't dump it in `rules/`.
4. If Tier 3: add a pointer to it from a Tier 0 file.
5. If Tier 4: write the topic file, then add a one-line index entry.

This starter kit ships Tier 0 (`rules/`), the global `CLAUDE.md`, and two Tier 2 commands
(`/plan-work`, `/next`) with their work queue in `~/.claude/work-queue/`. Tiers 1, 3 and 4 are yours
to grow as you go.
