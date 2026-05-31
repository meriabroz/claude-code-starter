# The Dedicated-Workspace Model

A short explanation of *why* the file-hygiene rule looks the way it does — the philosophy behind
giving Claude a clearly-bounded place to work.

## The idea

Pick one parent directory for all your coding — `~/Developer/` is a common choice — and treat it as
**the** workspace. Every project is a direct child of it, and every project is its own self-contained
git repository:

```
~/Developer/
├── project-a/        ← its own git repo, own remote
├── project-b/        ← its own git repo, own remote
└── project-c/        ← its own git repo, own remote
```

Then you tell Claude (via the global `CLAUDE.md` and `file-hygiene.md`): this is where work happens;
these few paths (credentials, system, anything you mark private) are off-limits; everything else is
fair game. The `block-writes-to-protected-paths.sh` hook enforces the off-limits part so it isn't
left to judgment.

## Why this beats the alternatives

**vs. one big monorepo of unrelated projects:** a careless `git checkout` or branch switch in a shared
repo can disturb work across everything. Separate repos keep each project's history and state
independent — a mistake in one can't touch another.

**vs. no convention at all:** when files land wherever the current directory happens to be, you end up
with session notes on the desktop, screenshots in your home folder, and half-finished scripts in
`/tmp`. A known home for each kind of file means nothing accumulates namelessly and nothing important
gets lost in the pile.

**vs. letting Claude roam the whole filesystem:** giving it a defined workspace with a small set of
hard-blocked zones contains the blast radius of any single mistake, without making it ask permission
for every routine file operation.

## The two habits that make it work

1. **Every project gets a git remote, early.** Local-only code plus one disk failure equals
   permanently lost work. A private remote is cheap insurance. If you start in a folder with no `.git`,
   initialize it before doing real work; if it has git but no remote, add one.

2. **New files go in a predictable subfolder of their project** — `research/`, `docs/`,
   `test-artifacts/`, etc. — never scattered around. Cleaning up legacy mess is fine; *creating* new
   scatter is the thing to avoid.

## Adapting it

The parent folder name doesn't matter — use `~/code`, `~/src`, `~/Developer`, whatever you like. The
two things that matter are: **one workspace root, one repo per project**, and **a small, explicit set
of protected zones** the assistant never writes to. Set those two and the rest is just tidiness.
