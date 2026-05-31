# Verify Agent Output Before Acting

Sub-agents hallucinate. An agent told to "find 5 issues" will often return 5 whether or not 5 exist.
Before acting on agent findings in a way that's costly to undo, fact-check them against a primary
source.

## The rule

**When an agent reports findings that would trigger a consequential action, fact-check at least two of
them against a trusted primary source before acting on any of them.**

Consequential actions: rewriting code, rebuilding/redeploying, changing config, deleting things,
sending anything outward, editing live metadata. Pure research summaries are lower-stakes —
spot-check if a conclusion feels off, but you don't need the full loop.

## The fact-check pattern

For each claim you'd act on:
1. **State the claim in one sentence.** "The app calls API X and is missing config key Y."
2. **Pick a primary source that proves or disproves it.** The actual file, a grep, an API response,
   `ls`.
3. **Run the check.** `grep`, `cat`, `curl`, `ls` — not another agent.
4. **Report reality.** If the claim is false, discard it — and re-verify the agent's *other* claims
   too, because hallucinations tend to cluster.

## The two-minimum rule

Before acting on a multi-finding report: pick the two most consequential findings, verify both via
primary source. If both hold, trust the rest within reason but flag anything you didn't personally
check. If either fails, treat the whole report as suspect.

## Anti-patterns

- Trusting the first agent that answered.
- Using a second agent to fact-check the first — that's two hallucination vectors stacked. Fact-checks
  go to files, command output, and API responses.
- "Looks plausible" as verification. Plausibility is exactly the signature of a hallucination that
  survives.

## Why it's worth it

A fact-check costs 30–120 seconds. Acting on a hallucinated finding — a needless rebuild, a wrong
"fix," a wasted debugging hour — costs far more. The ratio favors checking, every time.
