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
- **State risk** for non-trivial changes (low / medium / high) and what could ripple.

## Verification — nothing is "done" until it's proven

A passing build is the floor, not the finish line. For any user-facing or behavioral change, exercise
the **real path** — run it, click it, hit the endpoint — before calling it complete. Banned without
evidence: "fully verified", "production-ready", "no issues", "complete". Say instead: "happy path
verified by <how>; known edges: X, Y." Use adversarial framing on your own work — "find the ways this
breaks" — not confirmation. Full rule: `~/.claude/rules/verification-and-testing.md`.

## The rule files (Tier 0 — auto-loaded every session)

| File | Covers |
|---|---|
| `engineering-standard.md` | The overall quality bar — code, design, planning. |
| `coding-standards.md` | Concrete coding do's and don'ts. |
| `verification-and-testing.md` | Why "it builds" ≠ "it works", and how to actually verify. |
| `verify-agent-output.md` | Fact-check sub-agent findings against primary sources before acting. |
| `agents.md` | Use capable models for judgment work; give agents real context. |
| `git-workflow.md` | When and how to commit; stage by name; never force-push main. |
| `memory-discipline.md` | What to save to persistent memory, and what not to. |
| `file-hygiene.md` | The dedicated-workspace model + protected zones. |
| `context-management.md` | Keeping sessions lean; when to `/compact` or `/clear`. |

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
