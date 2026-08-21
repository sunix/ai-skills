---
name: making-of
description: Create or update a first-person, blog-style "making-of" journal (MAKING-OF.md) recording how a project is built with AI assistance — decisions, LLM discussions, dead ends, and proof that generated code works. Use when the user says "update the making-of", "create a making-of", or wants a development journal/log of AI-assisted sessions.
---

# Maintain a making-of journal

Maintain a making-of journal for the current repository: a first-person, blog-style account of how the project is being built, written in the author's voice.

## If `MAKING-OF.md` does not exist (bootstrap)

Create it at the repository root from [templates/MAKING-OF.md](templates/MAKING-OF.md): a three-part header (title "Building X: ..., one prompt at a time"; italic intro stating what the document is, its journal style, audience, and update policy; a `*Last updated: YYYY-MM-DD.*` line), then a "Why this exists" section. Draft initial entries from git history and the current conversation; ask the author about anything you cannot reconstruct instead of inventing it. Write in the language the author uses with you.

## If it exists (end-of-session update)

Read the whole file, match its voice and language, and append new `##` sections covering three beats:

1. **What was done** — changes, decisions, outcomes.
2. **The discussions with the LLM** — what was proposed, what the author pushed back on or corrected, how it resolved. A wrong first diagnosis is content, not noise.
3. **Proof that generated code works** — the generated test snippet (trimmed to the relevant assertion), one or two sentences on why passing it proves the fix (what failed before), and the real test-runner output. Include the red pre-fix run when available. For untestable changes, show the command run and its real output.

Update the `*Last updated:*` date. Never rewrite or delete past sections — a reversed conclusion gets a new section saying so.

## Style rules

Blog style: narrative prose meant to be read, section titles as hooks not labels, never a changelog or commit list. First person, past tense, honest, no marketing tone. Concrete: link real PRs/issues, quote measured numbers.

When the file no longer reads in one sitting and a milestone boundary exists, split into `doc/making-of/NN-slug.md` posts ([templates/making-of-post.md](templates/making-of-post.md)) and turn the root file into an index.

Full instructions: [prompt.md](prompt.md). Worked example with the proof pattern: [examples/example-usage.md](examples/example-usage.md).
