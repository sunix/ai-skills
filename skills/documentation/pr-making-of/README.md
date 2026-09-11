# pr-making-of

Write a pull-request description in the making-of voice — goal first, reversals kept in, proof shown, parked work named — so that a reviewer understands *why* before they read *how*.

## Install it with diderot

[diderot](https://github.com/sunix/diderot) is a package manager for agent skills: it resolves a version constraint, pins what it resolved to by content digest in `diderot.lock`, and installs the same bytes anywhere. From the registry:

```bash
diderot add oci://ghcr.io/sunix/skills/pr-making-of --version latest
diderot install
```

Or from this repository, to follow git rather than releases:

```bash
diderot add git+https://github.com/sunix/ai-skills#skills/documentation/pr-making-of --version main
diderot install
```

## Purpose

The default output when you ask an agent to "write the PR description" is a bullet list of files touched. The diff already says that. This skill produces something a reviewer actually reads: an opening that names the user-visible problem, the reversal or false start that explains why the solution looks the way it does, and the real evidence that it works — sized to the diff, not padded to fill a template.

It uses the same voice as the `making-of` skill. If `making-of` is installed, `pr-making-of` defers to it for style; if not, the rules are reproduced in [`prompt.md`](prompt.md).

## What it does

1. **Drafts or revises** a PR body from the diff and the conversation history.
2. **Sizes the shape to the diff**: a three-line fix gets a short paragraph; a multi-file refactor gets a lead paragraph and labelled sections.
3. **Asks the author** for anything it cannot recover: what was tried first, what is deliberately left undone, and what real output exists.
4. **Handles revisions**: when a body already exists, marks the update as a revision ("Rewritten after review:") rather than silently replacing it.

## Content rules

- **Goal first.** The opening sentence names the user-visible problem or the need a reviewer should feel, not a list of changed files.
- **Keep the reversals.** Wrong first approaches, reverted renames, corrected diagnoses — these are the highest-value lines in a PR body. Surface them explicitly.
- **Show proof.** The test that was red and is now green; the command run and what it printed. Not "tested locally".
- **Name what it does not do.** Parked work, known defects, follow-up issues — with links. A reviewer who knows the scope cannot ask "why didn't you also fix X?"
- **First person, past tense, honest, no marketing tone.** "I tried X, it fell apart because Y" — never "this PR improves" or "we are pleased to".
- **No inventory openings.** "Added `foo.ts`, updated `bar.ts`" is a diff summary. Open on what a reviewer should understand first.
- **Lead paragraph stands alone.** A reviewer who reads only the first paragraph should know what the PR does and why it exists.

## Usage

Say "write a PR description", "draft the PR body", or "update the PR description" — the skill reads the diff and the current conversation, asks for missing context, and produces a body ready to paste.

See [`prompt.md`](prompt.md) for the full agent-ready instructions.

## Relationship to making-of

`pr-making-of` and `making-of` share the same voice. They differ in one rule that the journal does not need: **size discipline** — a PR body is read once, in a review tab, so the shape must scale to the diff. A journal entry can afford to be long; a PR description for a three-line fix cannot.

Until skill dependencies are implemented ([diderot#23](https://github.com/sunix/diderot/issues/23)), if `making-of` is installed alongside this skill the style rules live in one place (the `making-of` skill) and this skill's prompt says "follow the making-of skill's style rules". If it is not installed, the style rules are reproduced verbatim in [`prompt.md`](prompt.md).
