Work the next queue item. Arguments: $ARGUMENTS (a project name, or empty for the highest-priority
item across all projects).

Rules: `~/.claude/rules/work-queue.md`.

1. **Pick the item.**
   - With a project name, take the first item under "Open" in
     `~/.claude/work-queue/<project>.md`.
   - Without one, scan every file in `~/.claude/work-queue/` and take the first P1 item (earliest
     deadline first), then P2, then P3, oldest first within a level.
   - If every queue is empty, say so and stop.
2. **Claim it.** Move it to "In progress" with today's date. If another session claimed it today,
   take the next one.
3. **Do it completely.** Read the item, then the project's `CLAUDE.md` and the code involved.
   - If the item has no **Checklist**, write one first: each discipline it touches, with 2–5
     concrete pass/fail points the best professional in that field would hold it to.
   - Build it and work through the checklist as you go.
   - Ship it the way the project ships: commit, push, and deploy where the project deploys.
   - Run the one check `definition-of-done.md` gives for this kind of change.
   - **No review passes:** no self-review agents, and no second-model review unless the user asks.
   - **Something else you notice** goes into the queue as a new item; don't do it now.
   - **If it's blocked** on the user or on something outside that's broken, move the item to
     "Blocked" with the reason and go back to step 1 once.
4. **Close it.** Move the item to "Done" with a result line: what shipped, the commit or deploy ID,
   the checklist status (all met, or which points weren't and why), and anything not checked.
5. **Report in a few lines,** then stop:
   - what shipped;
   - how it was checked;
   - the next open item, so the user knows what the next `/next` will do.
