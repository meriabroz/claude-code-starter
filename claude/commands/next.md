Work the next queue item. Arguments: $ARGUMENTS (a project name, or empty for the highest-priority
item across all projects).

Rules: `~/.claude/rules/work-queue.md`.

1. **Pick the item.** Consider only files in `open/` whose **Not before** date, if any, has passed.
   - With a project name, take the first such file in `~/.claude/work-queue/<project>/open/`, sorted
     by name.
   - Without one, look across every project's `open/` folder: P1 items with a **Due** date first,
     soonest first; then the rest by file name (priority, then date added).
   - Before picking, move any item in a `doing/` folder whose Claimed time is more than a day old
     back to `open/`; its session ended.
   - If nothing is open, say so and stop.
2. **Claim it:** `mv` it from `open/` to `doing/`, and add a `- **Claimed:** <date and time>` line
   under the title. If the `mv` fails, another session took it; pick again.
3. **Do it completely.** Read the item, then the project's `CLAUDE.md` and the code involved.
   - If the item has no **Checklist**, write one first: each discipline it touches, with 2–5
     concrete pass/fail points the best professional in that field would hold it to.
   - Build it and work through the checklist as you go.
   - Ship it the way the project ships: commit, push, and deploy where the project deploys.
   - Run the one check `definition-of-done.md` gives for this kind of change.
   - **No review passes:** no self-review agents, and no second-model review unless the user asks.
   - **Something else you notice** goes into `open/` as a new item; don't do it now.
   - **If it's blocked** on the user or on something outside that's broken, add a **Blocked on**
     line, move it to `blocked/`, and go back to step 1 once.
4. **Close it.** Add a `## Result` section: what shipped, the commit or deploy ID, the checklist
   status (all met, or which points weren't and why), and anything not checked. Move it to `done/`.
5. **Report in a few lines,** then stop:
   - what shipped;
   - how it was checked;
   - the next open item, so the user knows what the next `/next` will do.
