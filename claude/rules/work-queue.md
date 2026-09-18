# Work queue: plan once, then one item per session

The flow is a plan first, then a list of items worked through one at a time. Each session takes one
item and finishes it: built, deployed, done. The queue carries the work from session to session, so
no handoff document is needed.

## Where the queue lives

`~/.claude/work-queue/<project>.md`, one file per project directory name. It lives with the global
config so that every session can read it, whatever folder it started in.

## Which mode a session is in

- **Planning** (`/plan-work`, or any ask that's bigger than one session's work): turn the ask into
  queue items and stop. The deliverable is the queue: ordered, with each item self-contained. Don't
  start executing.
- **Execution** (`/next`, or "work the queue"): take the first open item, claim it, finish it,
  mark it done, and stop. Work on that one item only.
- **Direct asks** that fit in one session (a question, a quick fix, a lookup) don't need the queue:
  just do them.

## Item format

```markdown
### Q12 · P1 · Short imperative title
- **Why:** the outcome for users or the business, and any deadline
- **Do:** what to change, with file paths and the approach
- **Done when:** shipped the way the project ships, plus the one check from definition-of-done.md
- **Checklist:** the professional bar, written at planning time (see below)
- **Notes:** constraints, gotchas, owner decisions that apply
```

- **Priority:** P1 means broken now or has a deadline; P2 means valuable; P3 means worth doing
  eventually.
- **Numbering:** numbers only increase.
- **Independence:** an item must be finishable by a fresh session with no chat history, so put the
  facts in the item.
- **Size:** if an item won't fit in one session, split it into items that each ship something.

**The checklist replaces review.**

- **What it covers:** name every discipline the work touches (backend engineering, payments,
  UI/visual design, copy, SEO, accessibility, legal/compliance, and so on). Under each, write 2–5
  concrete pass/fail points the best professional in that field would hold this work to.
- **Be specific:** "Loads in under 1 s on mobile", not "fast"; "every price matches the pricing
  source", not "accurate".
- **Using it:** the executing session works through the checklist as it builds, not afterwards.
- **Reporting it:** the Done line says which points are met, and names any that aren't with the
  reason.
- **No sign-off:** there is no separate sign-off, reviewer or audit pass.
- **Missing checklist:** if an item has none, the executing session writes one before building.
- **Keep it light:** only the disciplines the item actually touches, and a few points each.

## Rules for an execution session

1. **Claim before starting.** Move the item to "In progress" with the date. If it's already claimed
   today, take the next one.
2. **Finish it completely.** Work through the item's checklist as you build, deploy the way the
   project deploys, and run the one check. Then move it to "Done" with a result line: what shipped,
   the commit, the checklist status, and anything unchecked.
3. **New work you notice** becomes a new queue item. It isn't part of this one.
4. **Blocked:** if only the user can unblock it, or something outside is broken, move the item to
   "Blocked" with the reason and take the next open item.
5. **No review passes:** no self-review agents and no second-model review unless the user asks.
