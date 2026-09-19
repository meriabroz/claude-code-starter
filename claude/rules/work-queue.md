# Work queue: plan once, then one item per session

The flow is a plan first, then a list of items worked through one at a time. Each session takes one
item and finishes it: built, deployed, done. The queue carries the work from session to session, so
no handoff document is needed.

## Where the queue lives

One file per item, in a folder per project, with a subfolder per status:

```
~/.claude/work-queue/<project>/
  open/      P1-2026-09-18-fix-the-login-redirect.md
  doing/
  blocked/
  done/
```

- **`<project>`** is the project's directory name. The queue lives with the global config, so every
  session can read it, whatever folder it started in.
- **The status is the folder.** An item changes state only by being moved. A move is atomic, so two
  sessions can't both claim one item, and no session rewrites a file another session is writing, so
  items can't be lost to overwrites.
- **The file name sets the order:** `P<priority>-<date added>-<slug>.md`, so a plain `ls open/`
  lists the work in the order it should be done.

## Which mode a session is in

- **Planning** (`/plan-work`, or any ask that's bigger than one session's work): turn the ask into
  queue items and stop. The deliverable is the queue: ordered, with each item self-contained. Don't
  start executing.
- **Execution** (`/next`, or "work the queue"): take the first open item, claim it, finish it,
  close it, and stop. Work on that one item only.
- **Direct asks** that fit in one session (a question, a quick fix, a lookup) don't need the queue:
  just do them.

## Item format

```markdown
# Short imperative title

- **Project:** <project> (`~/path/to/repo`)
- **Priority:** P1 · **Due:** 2026-10-02 · **Not before:** 2026-09-25
- **Added:** 2026-09-18
- **Why:** the outcome for users or the business
- **Do:** what to change, with file paths and the approach
- **Done when:** shipped the way the project ships, plus the one check from definition-of-done.md
- **Checklist:**
  - *Discipline:* concrete pass/fail points
- **Notes:** constraints, gotchas, decisions already made
```

- **Priority:** P1 means broken now or has a deadline; P2 means valuable; P3 means worth doing
  eventually.
- **Due** only when there is a real deadline. **Not before** only when the work can't start
  earlier, such as a measurement that needs a full day of data or a filing window. Leave both out
  otherwise.
- **Independence:** an item must be finishable by a fresh session with no chat history, so put the
  facts in the item. Refer to another item by its title.
- **Size:** if an item won't fit in one session, split it into items that each ship something.

**The checklist replaces review.**

- **What it covers:** name every discipline the work touches (backend engineering, payments,
  UI/visual design, copy, SEO, accessibility, legal/compliance, and so on). Under each, write 2–5
  concrete pass/fail points the best professional in that field would hold this work to.
- **Be specific:** "Loads in under 1 s on mobile", not "fast"; "every price matches the pricing
  source", not "accurate".
- **Using it:** the executing session works through the checklist as it builds, not afterwards.
- **Reporting it:** the Result says which points are met, and names any that aren't with the reason.
- **No sign-off:** there is no separate sign-off, reviewer or audit pass.
- **Missing checklist:** if an item has none, the executing session writes one before building.
- **Keep it light:** only the disciplines the item actually touches, and a few points each.

## Moving an item

Run these from `~/.claude/work-queue/<project>/`.

- **Claim:** `mv open/<item> doing/`, then add a `- **Claimed:** <date and time>` line under the
  title. If the `mv` fails, another session took the item: pick again.
- **Close:** add a `## Result` section (what shipped, the commit or deploy ID, the checklist status,
  anything not checked), then `mv doing/<item> done/`.
- **Block:** add a `- **Blocked on:** <what or whom it waits for>` line under the title, then
  `mv` it to `blocked/`. When the blocker clears, whoever clears it moves the item back to `open/`.
- **Re-prioritize:** rename the file.
- **Stale claim:** an item in `doing/` whose Claimed time is more than a day old belongs to a session
  that ended. Move it back to `open/` and take it.
- **Add:** write a new file in `open/`, creating the project's folders with `mkdir -p` if needed.

If `~/.claude` is a git repo, commit a project's queue changes on their own, so the commit carries
nothing another session has staged:

```bash
git -C ~/.claude add work-queue/<project>
git -C ~/.claude commit -m "<project> queue: <what changed>" -- work-queue/<project>
```

## Rules for an execution session

1. **Claim before starting.** Skip items whose Not before date is in the future.
2. **Finish it completely.** Work through the item's checklist as you build, deploy the way the
   project deploys, and run the one check. Then close it with its Result.
3. **New work you notice** becomes a new item in `open/`. It isn't part of this one.
4. **Blocked:** if only the user can unblock it, or something outside is broken, block it with the
   reason and take the next open item.
5. **No review passes:** no self-review agents and no second-model review unless the user asks.
