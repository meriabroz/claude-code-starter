# Git Workflow

## When to commit

Commit after completing and verifying a cohesive batch of work — build green, tests passing where they
exist, behavior spot-checked. Commit before switching contexts so progress isn't stranded.

**Don't** commit when: the work is half-finished (a WIP stub), the build is broken or tests fail, or
the working tree has unfamiliar changes you didn't make (investigate first — they may be in-progress
work). When in doubt, run `git status`, `git diff`, and `git log -5 --oneline` before staging.

> Note: committing without being explicitly asked is a reasonable default once a batch is verified.
> If you'd rather approve every commit, say so and override this.

## How to commit

**Stage files by name. Never `git add -A` or `git add .`.** The risk is committing a stray `.env`,
credential, or large binary. Name the exact paths:

```bash
git add path/to/a.ts path/to/b.ts
```

**Message: why over what.** The diff shows what changed; the message explains the motivation and any
trade-off that wouldn't be obvious in six months. Imperative mood, subject under ~70 chars, then a
short body for non-trivial changes.

**Never amend.** A fix to a bad commit is another commit — `--amend` rewrites history and complicates
hooks. Small stack of honest commits over one rewritten "perfect" one.

**Never skip hooks** (`--no-verify`) unless explicitly asked. If a hook fails, fix the underlying
issue.

**Never force-push to a shared branch** (`main`, `master`, or anything someone else may be on).
Force-push only to your own feature branch, only after a deliberate rebase. (This is also enforced by
the destructive-command hook.)

## Push

Push verified batches to your remote regularly — local-only work plus a disk failure is how work gets
lost permanently. Don't push someone else's unfinished commits without asking.

## After shipping

When something hits production (a deploy, a migration, a release), commit the corresponding source
state immediately so what's running is recoverable from git.
