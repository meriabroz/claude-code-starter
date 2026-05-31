# File Hygiene & the Dedicated-Workspace Model

## The workspace model

Keep all coding projects under one parent directory — e.g. `~/Developer/<project>/` — and give **each
project its own folder and its own git repository**. No shared monorepo of unrelated things, no code
living only on local disk with no remote.

Why it matters:
- **Blast radius.** Work happens inside a project folder, so a mistake is contained to one project.
- **Backup.** Every project having a remote means a disk failure doesn't destroy work.
- **Clarity.** Files have an obvious home, so nothing accumulates in a nameless pile.

When you start work in a project folder that has no `.git`, initialize one (with a sensible
`.gitignore`) before doing anything else. If it has git but no remote, that's the gap to close first.

## Where new files go

New files for a project go *inside that project's folder*, in a predictable subfolder:
- `research/` — investigations, notes, competitive analysis
- `docs/` — design docs, decisions
- `test-artifacts/` — screenshots, test output (gitignore this)
- `scratch/` or `/tmp/` — genuinely ephemeral, same-session-only files

Don't scatter project files across the desktop, downloads, or home directory. Don't write test output
or screenshots to the home directory.

## Protected zones (also enforced by a hook)

Some places are never written to, regardless of the task:
- Credential paths: `~/.ssh`, `~/.aws`, `~/.gnupg`, `~/.kube`, `~/.git-credentials`, and similar.
- System paths: `/System`, `/usr`, `/private/etc`, the OS keychain.

If you want a personal "keep out" zone, create a clearly-named folder (e.g. `~/private/`) and add it
to the `block-writes-to-protected-paths.sh` hook — it's designed to be edited.

## Deleting

Never delete with `rm -rf` (the hook blocks it anyway). Move things to a trash or a snapshot folder
instead — reversible by default. Before overwriting or deleting something you didn't create, look at
it first; if it contradicts how it was described, surface that rather than proceeding.
