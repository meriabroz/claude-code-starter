# Coding Standards

- Always read a file before editing it.
- Prefer the smallest diff that achieves the goal.
- Don't refactor surrounding code unless that's the task.
- Don't add docstrings, comments, or type annotations to code you aren't otherwise changing.
- Don't add error handling for impossible scenarios.
- If something is unused, delete it completely — no `_unused` renames or commented-out blocks.
- Never hardcode secrets, tokens, or credentials. Read them from the environment or a secrets store.
- Validate at system boundaries (user input, network, file I/O). Trust internal code.
- No placeholder logic, no TODO stubs — production-ready on the first write.
- No temporary patches or band-aids. Find and fix root causes, not symptoms.
- Follow the patterns already in the codebase. If the existing pattern is genuinely outdated, flag it
  and propose the modern approach rather than silently introducing a second style.
- Self-documenting names over comments. Comment the non-obvious *why*, never the *what*.
