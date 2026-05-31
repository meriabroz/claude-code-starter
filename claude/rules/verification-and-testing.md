# Verification & Testing

**Nothing is "done" until it has been exercised the way it will actually be used.**

Code audits, type checks, lint, and "it builds" verify *code* — not *usage*. The bug is almost always
in the gap between "the code matches the spec" and "the feature works when a real person uses it."

## The rule

For every user-facing or behavioral change:

1. **Exercise the real path** — run the command, click the button, hit the endpoint, load the page.
   Against a real build where possible, not just a mental trace.
2. **Start from a clean state** — fresh session, no pre-injected state, no skipped steps. Hit it the
   way a new user would.
3. **Fail on the modes a user would actually see** — blank screen, button does nothing, form submits
   nothing, redirect loop, stale state, missing text, wrong number.
4. **Only then is it ready.**

## Banned shortcuts (they produce false confidence)

- Reading the code, deciding "looks right," and calling it done.
- Injecting state directly, then claiming the flow is tested.
- Checking only the happy path.
- Trusting a sub-agent's "PASS" report without verifying it yourself.
- Asserting on a substring of output when you should be checking real behavior.

## A minimum walkthrough

When practical, walk these from a clean start: first run / empty state · the happy path · invalid or
missing input · interrupt-and-return (start, leave, come back) · refresh or restart mid-flow. If a
path isn't covered, the change is a draft, not done.

## Adversarial framing

Review your own work as an attacker, not a fan. Ask **"find 5 ways this breaks in production; assume
it's broken and prove it isn't"** — never "confirm this works." Confirmation framing reinforces the
bias of whoever wrote it.

## Trace the mental model before changing code

Write down, in plain words: the user does X → which function fires → what state changes → what
re-renders → what the user sees. Then verify each step is real. This 30-second exercise catches
"dead code" changes — edits to a path that never actually runs.

## Honest language (required)

Banned unless backed by real evidence from exercising the path: "100% working", "fully verified",
"production-ready", "no issues", "complete", "tested thoroughly".

Use instead:
- "Happy path verified by running X. Known edges I didn't hit: A, B."
- "Shipped; watching for failure mode Z."
- "Builds and the core flow works for case X; I did not test A, B, C."

Time pressure is not a reason to skip this. Shipping broken faster spends tomorrow's time. The right
response to "hurry" is "I'll ship it the moment I've walked the real path — that's a few minutes."
