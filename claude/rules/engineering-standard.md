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
7. **Finish it.** No placeholder logic, no half-built features. Ship complete or don't ship —
   "thorough" means finished, not more checks.

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

## Checking

How much checking a change needs is in `definition-of-done.md`: one check that fits the change,
the full end-to-end treatment only for money, data and anything irreversible, and no review passes
unless the user asks.
