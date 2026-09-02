---
name: making-of
description: Create or update a first-person, blog-style "making-of" journal (MAKING-OF.md) recording how a project is built with AI assistance — decisions, LLM discussions, dead ends, and proof that generated code works. Use when the user says "update the making-of", "create a making-of", or wants a development journal/log of AI-assisted sessions.
---

# Maintain a making-of journal

Maintain a making-of journal for the current repository: a first-person, blog-style account of how the project is being built, written in the author's voice.

**Write as the author with another developer sitting beside them.** Every entry is that conversation: here is the feature I built, here is why it needed building, here is the code I wrote and why it reads the way it does, and here is the proof it does what I set out to do. The rules below all follow from that one, so when they seem to conflict, ask what you would actually say to somebody looking at the screen with you. Showing beats describing. A snippet beats a summary of a snippet. A claim with no output under it is not finished. A section that would embarrass you if read aloud to that person is wrong, however well written.

## If `MAKING-OF.md` does not exist (bootstrap)

Create it at the repository root from [templates/MAKING-OF.md](templates/MAKING-OF.md): a three-part header (title "Building X: ..., one prompt at a time"; italic intro stating what the document is, its journal style, audience, and update policy; a `*Last updated: YYYY-MM-DD.*` line), then a "Why this exists" section. Draft initial entries from git history and the current conversation; ask the author about anything you cannot reconstruct instead of inventing it. Write in the language the author uses with you.

## If it exists (end-of-session update)

Read the whole file, match its voice and language, and append new `##` sections covering four beats, in this order:

1. **The goal, with a concrete example** — open with what this session set out to accomplish, shown concretely (the user story, the input the user writes, the command they run, the output they should get) *before* any how. A reader must know what success looks like before reading how it was reached.
2. **What was done** — changes, decisions, outcomes.
3. **The discussions with the LLM** — what was proposed, what the author pushed back on or corrected, how it resolved. A wrong first diagnosis is content, not noise.
4. **Proof that generated code works** — the generated test snippet (trimmed to the relevant assertion), one or two sentences on why passing it proves the fix (what failed before), and the real test-runner output. Include the red pre-fix run when available. Prefer **oracle-based proofs**: when a reference implementation exists (real git, the real compiler, the actual API), test against its answer rather than a hardcoded expected value — and record that choice in the entry. For untestable changes, show the command run and its real output.

**Pair beats 1 and 4 on the same test.** The goal's concrete example and the proof's test-runner output should be two runs of the *same* test — red at the top, green at the bottom. A goal described only in prose, with no failing run to back it, is half the argument; a proof with nothing to point back at is the other half missing.

**When an entry covers several distinct points** — a milestone with more than one sub-feature, several unrelated fixes in one session — don't compress them into one global goal → what-was-done → proof. That forces the reader to hold every change in their head before the first proof ever shows up. Repeat the shape once per point instead, each one self-contained: its own concrete goal (paired with its own red run when TDD produced one), its own explanation of what changed, its own proof. A `##`/`###` per point is the natural boundary. Beat 3 and the tour-of-the-machinery below still apply across the whole entry, not per point — repeating those per point fragments the story for no reason.

**A test that passed before the fix isn't proof of anything.** Sometimes a point's test happens to already read correctly even before the real implementation exists — a coincidence of that specific fixture, not evidence the feature works. Say so plainly (what made it pass anyway, what would need to differ to actually tell old from new) rather than quoting the accidental green run as if it were the point's proof.

When the session generated interesting code, also **walk through it**: quote the load-bearing snippets (trimmed) and explain why they are written that way — the tricky rule they encode, the edge they guard. The journal is where a reader should understand the code's ideas, not just its existence.

**Write every code and command block as a shoulder-to-shoulder explanation** — as if you had invited another developer to look at your screen. This is the register for both:

- *Showing code*: name the file worth opening, then take a path through it. "Start with `push`, which is shorter than you'd expect." "Now the other direction, and the interesting part is what it *doesn't* have." "Look at that last line." Never a declarative label followed by a fence.
- *Showing commands*: say what you are about to run and what to watch for, so the reader knows which question the output answers before they see it. "So watch what it prints." "Then the two commands that matter, run against that freshly produced executable."
- Every fenced block earns the sentence above it: that sentence says *why the block is there*, not merely that it exists. A lead-in ending in a bare colon after a flat clause ("…torn down at the end of the run:") is the tell.
- When context is long, put the short pointer *before* the block and the explanation *after* it — the reader should reach the code within a line or two, then be told what they just read.
- Opening on inventory (dependency coordinates, a list of new files) reads as a changelog. Open on what the reader should do or notice; details follow.

When the session created several files, give the **tour of the machinery**: every new file's role and who calls what, told as a story — follow one command or request through the layers from entry point to effect — never as a bare inventory, and with enough trimmed snippets that the reader never has to leave the journal for the code. Cover what a curious reader, maintainer, or new contributor needs to open the hood: entry points, the core engine, the boundaries to the outside world, and how the tests mirror the layout. Don't let one clever piece eclipse the feature around it.

**When the session drove a UI, show the screen.** A step that happened on a screen — a form filled, a button that gates a paid action, a confirmation dialog — earns an annotated screenshot the way code earns a snippet: showing beats describing. Capture with the browser automation at hand (Playwright for web) and annotate *before* capturing: a red box or arrow on the exact spot the reader must look, a short label saying what they are looking at, labels numbered when the prose describes a sequence of gestures. Framing is part of the proof: scroll the annotated element to the center of the viewport, check that element **and** label sit fully inside it, and re-read the saved image **before the next action** — ephemeral states (a one-shot ceremony, a modal, a dying spinner) cannot be recaptured once the flow moves on. Commit the images to the repo (e.g. `demo-captures/NN-slug.png`) and embed each inline (`![what to notice](path)`) at the point of the story where the reader needs it, never as a bare link. A screenshot re-staged later, after the state moved on, says so in the entry; the superseded original stays in git history.

Update the `*Last updated:*` date. Never rewrite or delete past sections — a reversed conclusion gets a new section saying so.

## Style rules

Blog style: narrative prose meant to be read, section titles as hooks not labels, never a changelog or commit list. First person, past tense, honest, no marketing tone. Concrete: link real PRs/issues, quote measured numbers.

**No meta-narration**: the journal never talks about the writing or updating of the journal itself — no "I updated this making-of", no describing the journal's own structure or the skill that produced it. Sole exception: a repository whose subject *is* the making-of practice (e.g. the skill's own repo).

When the file no longer reads in one sitting and a milestone boundary exists, split into `doc/making-of/NN-slug.md` posts ([templates/making-of-post.md](templates/making-of-post.md)) and turn the root file into an index.

Full instructions: [prompt.md](prompt.md). Worked example with the proof pattern: [examples/example-usage.md](examples/example-usage.md).
