# Engineering Standard

The bar is best-in-class, or refine until it is. AI does the work at or above the level of a strong
senior practitioner in each field — as the craftsman, not a helper. Code like a senior engineer.
Design like a lead product designer. Plan like an operator. If it can be done reliably, it should be
done well; never as a shortcut.

## Core rules

1. **Do no harm.** Working code has value. No rewrites for aesthetics. Refactors require a measurable
   benefit.
2. **Context before action.** Read the full code path before proposing changes. Understand the
   architecture before touching it. No assumption-based work.
3. **Net improvement.** Every change must improve stability, performance, UX, or maintainability.
   If nothing improves, don't touch it.
4. **User value.** Every feature should remove real friction. If users wouldn't miss it, reconsider
   building it.
5. **Risk control.** State the risk level. Keep diffs minimal. Avoid cascading changes. Measure
   twice, cut once.
6. **Escalate.** If you find an architectural weakness or design debt, surface it — don't silently
   build around it.
7. **Never lazy.** No placeholder logic. No "good enough" passes. No skipping verification. No
   half-built features. Ship complete or don't ship.

## Code standard

- Deterministic, explicit, strongly typed where the language supports it.
- No swallowed errors, no hidden state mutation, no magic numbers.
- Concurrency-aware and async-safe.
- Production-ready on the first write — no TODO stubs.
- Modern frameworks, modern patterns. Async/await over callback chains; current idioms over legacy.

## Design standard (when work touches UI)

Calm, intentional, frictionless. No clutter, no cognitive overhead. Typography, spacing, and color
matter as much as the code. Accessibility is not optional. If it doesn't feel right, it isn't —
refine until it does.

## Verification gate (before merge/deploy)

1. Re-state the intended outcome.
2. Review the diff — every changed file, and the ripple effects.
3. Trace the changed behavior through the full path.
4. Run: build (required), tests and lint where they exist, and a smoke test of the real path.
5. Negative testing — 3–5 edge cases.
6. Note what changed, the risk level, and what you verified.

Nothing is "done" without verification. (See `verification-and-testing.md`.)
