---
name: making-of
description: Create or update a first-person, blog-style "making-of" journal (MAKING-OF.md) recording how a project is built with AI assistance — decisions, LLM discussions, dead ends, and proof that generated code works. Use when the user says "update the making-of", "create a making-of", or wants a development journal/log of AI-assisted sessions.
---

# Maintain a making-of journal

Maintain a making-of journal for the current repository: a first-person, blog-style account of how the project is being built, written in the author's voice.

## If `MAKING-OF.md` does not exist (bootstrap)

Create it at the repository root from [templates/MAKING-OF.md](templates/MAKING-OF.md): a three-part header (title "Building X: ..., one prompt at a time"; italic intro stating what the document is, its journal style, audience, and update policy; a `*Last updated: YYYY-MM-DD.*` line), then a "Why this exists" section. Draft initial entries from git history and the current conversation; ask the author about anything you cannot reconstruct instead of inventing it. Write in the language the author uses with you.

## If it exists (end-of-session update)

Read the whole file, match its voice and language, and append new `##` sections covering four beats, in this order:

1. **The goal, with a concrete example** — open with what this session set out to accomplish, shown concretely (the user story, the input the user writes, the command they run, the output they should get) *before* any how. A reader must know what success looks like before reading how it was reached.
2. **What was done** — changes, decisions, outcomes.
3. **The discussions with the LLM** — what was proposed, what the author pushed back on or corrected, how it resolved. A wrong first diagnosis is content, not noise.
4. **Proof that generated code works** — the generated test snippet (trimmed to the relevant assertion), one or two sentences on why passing it proves the fix (what failed before), and the real test-runner output. Include the red pre-fix run when available. Prefer **oracle-based proofs**: when a reference implementation exists (real git, the real compiler, the actual API), test against its answer rather than a hardcoded expected value — and record that choice in the entry. For untestable changes, show the command run and its real output.

When the session generated interesting code, also **walk through it**: quote the load-bearing snippets (trimmed) and explain why they are written that way — the tricky rule they encode, the edge they guard. The journal is where a reader should understand the code's ideas, not just its existence.

Update the `*Last updated:*` date. Never rewrite or delete past sections — a reversed conclusion gets a new section saying so.

## Style rules

Blog style: narrative prose meant to be read, section titles as hooks not labels, never a changelog or commit list. First person, past tense, honest, no marketing tone. Concrete: link real PRs/issues, quote measured numbers.

**No meta-narration**: the journal never talks about the writing or updating of the journal itself — no "I updated this making-of", no describing the journal's own structure or the skill that produced it. Sole exception: a repository whose subject *is* the making-of practice (e.g. the skill's own repo).

When the file no longer reads in one sitting and a milestone boundary exists, split into `doc/making-of/NN-slug.md` posts ([templates/making-of-post.md](templates/making-of-post.md)) and turn the root file into an index.

Full instructions: [prompt.md](prompt.md). Worked example with the proof pattern: [examples/example-usage.md](examples/example-usage.md).
