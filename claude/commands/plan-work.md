Plan the work for: $ARGUMENTS

Turn this ask into work-queue items per `~/.claude/rules/work-queue.md`, then stop. Don't start
executing any item in this session.

1. **Understand the ask** in the context of the product. Read what you need to make the items
   concrete and correct: the project's `CLAUDE.md`, the relevant code, its current state, and live
   data where it matters. The research that sizes and orders the work belongs here, so execution
   sessions don't have to redo it.
2. **Write the items**, one file each, into `~/.claude/work-queue/<project>/open/`, named
   `P<priority>-<today's date>-<short-slug>.md`, in the item format from `work-queue.md`. Create
   the project's folders with `mkdir -p` if they don't exist. For work spanning several projects,
   give each project its own items. Each item:
   - ships something on its own and fits in one session;
   - carries every fact a fresh session needs: file paths, target values, and the deploy command,
     or where it lives;
   - says what "done" means for it;
   - has a **Checklist**: name each discipline the item touches (backend engineering, payments,
     UI/visual design, copy, SEO, accessibility, legal/compliance, and so on). Under each, write 2–5
     concrete pass/fail points the best professional in that field would hold this work to. This is
     the item's bar; there's no review afterwards.

   Priority: P1 is broken now or has a deadline, P2 valuable, P3 eventually. Add **Due** or **Not
   before** only when a real date applies. An item that needs the user's decision before anyone can
   start goes in `blocked/` with a **Blocked on** line naming the decision.
3. **Report in a few lines:** the items in order, with one line each, and which one `/next` will take
   first. Name any item that needs the user's decision before it can run, and what the decision is.
