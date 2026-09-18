Plan the work for: $ARGUMENTS

Turn this ask into work-queue items per `~/.claude/rules/work-queue.md`, then stop. Don't start
executing any item in this session.

1. **Understand the ask** in the context of the product. Read what you need to make the items
   concrete and correct: the project's `CLAUDE.md`, the relevant code, its current state, and live
   data where it matters. The research that sizes and orders the work belongs here, so execution
   sessions don't have to redo it.
2. **Write the items** into `~/.claude/work-queue/<project>.md`, creating the file from the template
   below if it doesn't exist. For work spanning several projects, give each project its own items.
   Each item:
   - ships something on its own and fits in one session;
   - carries every fact a fresh session needs: file paths, target values, and the deploy command,
     or where it lives;
   - says what "done" means for it;
   - has a **Checklist**: name each discipline the item touches (backend engineering, payments,
     UI/visual design, copy, SEO, accessibility, legal/compliance, and so on). Under each, write 2–5
     concrete pass/fail points the best professional in that field would hold this work to. This is
     the item's bar; there's no review afterwards.

   Order by priority: P1 is broken now or has a deadline, P2 valuable, P3 eventually.
3. **Report in a few lines:** the items in order, with one line each, and which one `/next` will take
   first. Name any item that needs the user's decision before it can run, and what the decision is.

Template for a new queue file:

```markdown
# Work queue — <project>

Take the first open item with `/next <project>`. Rules: `~/.claude/rules/work-queue.md`.

## Open

## In progress

## Done

## Blocked
```
