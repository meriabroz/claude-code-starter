# Definition of Done

A task is done when the thing the user asked for works for the person who will use it, it's shipped
the way the project ships, and your report says in a few lines what you checked.

You check your own work anyway. This file says how much checking is enough, so that it stays
proportionate to the change. Extra checks, repeated reviews and audit agents cost time without
making the result better.

## How much checking is enough

| The change | Enough |
|---|---|
| Copy, text, a config value | After deploy, the new text is served (curl or grep) |
| A contained logic fix | Its test passes, and fails without the fix; or one real run of the path |
| Something a user touches: a screen, a flow, checkout, sign-in | One run of that flow on the real build, looking at the result, plus the one edge most likely to break it |
| Money, credits, deleting data, migrations, store submissions, anything irreversible | The full flow end to end, and the edge cases that can lose money or data |

- Run the full test suite only when shared code changed.
- After a deploy, make one real request and read the response.

## No review passes; a checklist instead

The session that does the work checks it as part of doing it: it runs the flow and looks at the
result. The professional bar comes from the item's checklist, written before the work starts
(`work-queue.md`), which the session works through as it builds.

There are no separate review passes by default:
- no self-review agents;
- no second-model review;
- no audit of your own finished work.

Run an outside review only when the user asks for one, and then only once. Don't send the repaired
version back for another round: a reviewer handed a new diff always finds something, so rounds
never converge.

## Reporting and measuring

- Say what you checked and what you did not. Never call something verified that you did not run.
- A number you report says how many samples it rests on.
- A zero that contradicts what you know means the instrument is broken, not that the result is clean.
- When a repo note or rule looks stale, check the one fact your change depends on; don't audit the
  whole repo.

## "Thorough" means finished

When the user says "be thorough", "don't be lazy" or "work carefully", they mean finish the job so
it actually works:
- do the work instead of writing a report about it;
- don't stop at "should work";
- don't leave part of the ask undone.

They don't mean running more checks, reviews or audits.

## Older guidance

Older rules, memories, handoff prompts and project notes often ask for more checking than this:
- mandatory multi-step walkthroughs;
- review rounds;
- adversarial agents on routine work;
- "never stop until everything you find is fixed".

Where they conflict with this file, this file wins. Their facts and project-specific know-how still
stand.

## Unchanged

- **Irreversible actions need the user's go:** store submissions, messages to customers, destructive
  git, deleting production data, pricing changes. Deploys follow each project's own rule.
- **Facts about a named third party** are checked against a current primary source before anything
  public ships.
