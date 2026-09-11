---
name: pr-making-of
description: Write or revise a pull-request body in the making-of voice — goal first, reversals kept in, proof shown, parked work named. Use when the user says "write a PR description", "draft the PR body", or "update the PR description".
---

# Write a pull-request description in the making-of voice

Write (or revise) the body of a pull request so that a reviewer understands *why* before they read *how* — same voice as the making-of journal, shaped for the single sitting a PR review gets.

If the `making-of` skill is installed, follow its style rules. The rules below are the same ones applied here; when they conflict with each other, ask what you would say to a developer sitting beside you looking at the diff.

## Shape the body to the diff

A three-line fix gets a short paragraph. A multi-file refactor gets a lead paragraph and labelled sections beneath it. The lead paragraph must stand alone: a reviewer who reads only that should know what the PR does and why it exists.

Sections to include only when the diff warrants them:
- **Reversals** — what was tried first and abandoned, or an objection from review that turned out to be right.
- **Proof** — the test that was red and is now green, the command run and what it printed. Not "tested locally".
- **What this does not do** — deliberately parked work, known-open defects, follow-up issues with links.

## Rules (same register as making-of)

**Open on the goal, not the inventory.** The first sentence names the user-visible problem or the need a reviewer should feel before reading the diff. "Add X, update Y, change Z" is a diff summary, not a goal.

**Keep the reversals.** A wrong first approach, a renamed thing that had to be reverted, a diagnosis that was corrected — these are the highest-value lines in a PR body, because they are the only place that reasoning is written down. Surface them; do not smooth them away.

**Show proof, not claims.** "Tested locally" proves nothing. Quote the test that was failing and is now green; show the command and what it printed; link the CI run.

**Name what it does not do.** Explicitly list parked work, known defects, or follow-up issues — with links where they exist. A reviewer who knows the scope cannot ask "why didn't you also fix X?"

**First person, past tense, honest, no marketing tone.** "I tried X, it fell apart because Y" — never "this PR improves" or "we are pleased to". Do not overstate the author's role: "contributed to", not "wrote", when the work was collaborative.

**No inventory openings.** "Added `foo.ts`, updated `bar.ts`, removed `baz.ts`" reads as a diff. Open on what a reviewer should understand; the file list is already in the diff.

## Revising an existing body

When revising a body that already exists, the revision should read as a revision — not as if the earlier version never existed. Prefix with a one-line note ("Rewritten after review:", "Amended:") and keep any context from the original that a reviewer who already read it would miss.

## What to ask the author

Before drafting, ask for anything you cannot recover from the diff and the conversation history:
- What did you try first that did not work?
- What does this deliberately leave undone?
- Is there real output — a test run, a command and its response — you can share?

Full style guide: [prompt.md](prompt.md).
