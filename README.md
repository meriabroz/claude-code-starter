# Claude Code Starter Kit

A clean, opinionated starting configuration for [Claude Code](https://claude.com/claude-code) — the
global rules, safety hooks, permissions, and a dedicated-workspace model that turn a fresh install
into a production-minded coding partner that finishes what it starts, from the first session.

It installs into your **user-level** `~/.claude/` directory, so it applies to every project on your
machine. Nothing here is project-specific — it's the baseline behavior layer.

> Built by distilling a heavily-used personal setup down to the parts that are universal. No secrets,
> no business data — just the structure and the good habits. Treat it as a template: read it, keep
> what fits, change what doesn't.

---

## What you get

| Piece | What it does |
|---|---|
| **`CLAUDE.md`** | Global instructions loaded every session: how to communicate, the quality bar, working principles, and pointers to the rule files. |
| **`rules/`** | Nine focused "boot rules" that shape behavior every turn — execution-first delivery, a proportionate definition of done, the work queue, coding standards, git workflow, memory habits, file hygiene, and context management. |
| **`commands/`** | `/plan-work` plans a big ask into a queue of items; `/next` takes one item and finishes it — built, deployed, done. |
| **`hooks/`** | Four shell hooks: block destructive commands, protect credential/system paths from writes, show git state at session start, and restore project state after context compaction. |
| **`settings.json`** | Permissions (a sensible allow-list), a deny-list that keeps Claude out of credentials and binary files, and the wiring that connects the hooks. |
| **`ARCHITECTURE.md`** | The 5-tier model for *what config lives where and when it loads* — so your setup stays lean instead of ballooning into 100K tokens of boot context. |
| **`docs/`** | The dedicated-workspace model: why every project gets its own folder + git repo, and how that keeps Claude's blast radius contained. |

---

## Prerequisites

1. **Claude Code installed.** If you don't have it yet:
   ```bash
   npm install -g @anthropic-ai/claude-code
   # or follow https://docs.claude.com/en/docs/claude-code/setup
   ```
   Run `claude` once so it creates `~/.claude/`, then exit.
2. **`jq`** and **`python3`** on your PATH (the hooks use them).
   - macOS: `brew install jq` (python3 ships with the Xcode command-line tools, or `brew install python`).
   - Linux: `sudo apt install jq python3` (or your distro's equivalent).

---

## Quick start

```bash
git clone https://github.com/meriabroz/claude-code-starter.git
cd claude-code-starter
./install.sh
```

The installer:
- **Backs up** anything it would overwrite to `~/.claude/backup-<timestamp>/` — it never destroys your existing config.
- Copies `CLAUDE.md`, `ARCHITECTURE.md`, `rules/`, and `hooks/` into `~/.claude/`.
- Renders `settings.json` with the **absolute paths for your machine** (hooks need absolute paths) and merges it carefully — if you already have a `settings.json`, it writes the new one as `settings.json.from-starter` and tells you, rather than clobbering it.
- Makes the hook scripts executable.

Then start a new Claude Code session — the config loads automatically.

### Letting Claude install it for you

If you'd rather hand it to Claude: open Claude Code in the cloned folder and say

> Read `README.md` and `install.sh`, then install this starter kit into my `~/.claude/`.

It'll walk the same steps and explain what it's doing.

---

## What it changes about Claude's behavior

- **Reads before editing**, keeps diffs minimal, no placeholder/TODO stubs.
- **Finishes the job** — delivers what you asked at the scope you meant, checks it the way it could realistically break (a ceiling as much as a floor), ships it, and says plainly what it did and didn't check. No review loops or self-audit agents unless you ask.
- **Plans once, then executes one item per session** — `/plan-work` turns a big ask into queue items with a professional checklist each; `/next` takes one and finishes it. The queue replaces handoff documents.
- **Delegates sparingly** — subagents only for big parallel work, never to double-check itself; it checks an agent's key claims before acting on them.
- **Commits sanely** — stages files by name (never `git add -A`), writes "why" in the message, never force-pushes to main.
- **Stays out of dangerous territory** — `rm -rf`, `sudo`, pipe-to-shell, disk ops, and writes to credential/system paths are blocked at the hook layer.
- **Uses persistent memory** for durable cross-session knowledge.

---

## Why it works this way

Current Claude models check their own work without being told to. Anthropic's guidance for Claude
Opus 5 says instructions telling it to verify "now cause over-verification" and that removing them
costs nothing ([migration guide](https://platform.claude.com/docs/en/about-claude/models/migration-guide)).
The rules here set a proportionate bar instead of piling on checks. The measurement behind this, a
stand-alone version you can hand to an existing setup, and a script to measure your own sessions are
in [claude-code-execution-first](https://github.com/MeriaApp/claude-code-execution-first).

---

## Customizing

Everything is plain Markdown and shell. To make it yours:

- Edit `~/.claude/CLAUDE.md` — add your name, your stack, your preferences.
- Add or remove files in `~/.claude/rules/`. Anything in that folder auto-loads every session, so keep it lean (see `ARCHITECTURE.md` for the size discipline).
- Tune `~/.claude/settings.json` permissions to taste.
- The hooks are short and commented — adapt the protected paths or destructive-command patterns to your environment.

---

## Uninstalling

The installer told you where your backup went (`~/.claude/backup-<timestamp>/`). To revert, copy those
files back over the installed ones, or just delete the files this kit added and restore your prior
`settings.json`.

---

## License

MIT — do whatever you want with it.
