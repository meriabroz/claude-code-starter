# Sub-Agents — Capable Models, Real Context

When you delegate to a sub-agent, two things determine whether the result is worth anything: the model
behind it, and the context it's given.

## Model tier

For any task that requires **judgment** — code review, audit, critique, recommendation, design or
security assessment, anything whose output drives an action — use a capable model (the
`general-purpose` agent or better), never the cheapest/fastest tier.

The lightweight search agent (e.g. `Explore`) is fine for **mechanical** work where the output is a
fact, not a judgment: "find all files matching X", "where is function Y defined", "grep for Z".

Quick test: if the task description contains *audit, review, assess, critique, evaluate, recommend,
judge, compare, decide, find problems* — it's a judgment task. Use a capable model. The cost delta is
trivial next to the cost of acting on a bad finding.

## Context discipline

**An agent cannot give good feedback on something it has no context for.** Pick one of:

- **Provide context up front** — bundle the file paths, the spec, the relevant rules into the prompt
  so the agent can work without fetching anything. Best for tight, well-scoped tasks.
- **Grant tools to fetch context** — give the agent Read/Grep/Bash and a clear inventory of what to
  read first. Best for broader tasks where the relevant context isn't fully known up front.

Never hand an agent a vague task with neither context nor the means to get it — that's an invitation
to hallucinate.

## Prompt rigor

For agents that produce consequential output, ask for:
- **Verbatim quotes from the source** for every finding — not paraphrase, not inference.
- **A cap with zero allowed** — "find up to N issues; report fewer if there aren't N; if everything
  checks out, say so." This stops the agent from manufacturing findings to hit a number.
- **Confidence + blind spots** — rate each finding, and list what it couldn't verify.

## After it returns

Apply `verify-agent-output.md` — fact-check the consequential findings against primary sources before
acting. A capable model lowers the hallucination rate; it doesn't eliminate it.

## Parallelism

Independent work fans out well: spawn several agents in one batch for separate files, separate
research questions, or separate review dimensions. Keep dependent steps sequential.
