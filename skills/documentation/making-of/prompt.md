# Prompt: Maintain a Making-Of Journal

Use this prompt to instruct an AI agent to create or update a first-person making-of journal in a repository.

---

Maintain a making-of journal for this repository: a first-person, blog-ish account of how the project is being built, written in the author's voice, for new contributors and anyone curious how it came together.

## If the file does not exist yet (bootstrap)

- Create `MAKING-OF.md` at the repository root. Copy the skeleton from `skills/documentation/making-of/templates/MAKING-OF.md`.
- Open with the three-part header block:
  1. A title stating the project and the angle (pattern: "Building <project>: <what it is>, one prompt at a time").
  2. An italic intro paragraph: what this document is, its style ("a first-person log / journal, not formal docs — kept for the reasoning, including the dead ends and reversals"), who it is for, and its update policy ("updated on request as the work progresses").
  3. A `*Last updated: YYYY-MM-DD.*` line.
- Write the first section as "Why this exists": the motivation or the triggering event, in the author's voice.
- Draft the initial entries from the git history, existing issues/PRs, and the current conversation. Ask the author about anything you cannot reconstruct (motivations, off-repo events) instead of inventing it.
- Write in the language the author uses when talking to you.

## If the file exists (end-of-session update)

- Read the whole file first and match its voice, language, and formatting exactly.
- Append one or more new `##` sections covering what happened since the last update. Do not pad: if the session produced one decision, write one short section.
- Update the `*Last updated:*` date. Change nothing else in the header block.
- Never rewrite or delete past sections. If a past conclusion turned out wrong, say so in the new section — the reversal is the content.

## Content rules (both modes)

- **First person, past tense, honest.** The human author's journal, drafted by you. No marketing tone, no "we are excited to".
- **Record reasoning, not just outcomes.** What was tried first, why it fell apart, what was landed on instead. Dead ends get their own paragraphs.
- **Be concrete.** Link actual PRs, issues, and files; quote measured numbers; use tables for data. When a claim was verified, say against what.
- **Distinguish roles.** What the agent proposed, what the human corrected or decided, what was checked against the code.
- **Keep it readable in one sitting.** Sections short, one idea each.

## Splitting into a post series

When the single file no longer reads in one sitting **and** a natural boundary exists (a milestone shipped):

- Move the body into `doc/making-of/NN-<slug>.md` posts (copy the post skeleton from `skills/documentation/making-of/templates/making-of-post.md`).
- Turn the root `MAKING-OF.md` into an index: keep the header block, replace the body with a numbered "Posts" list, one line per post with a link and a one-sentence summary of what it covers.
- New milestones get new posts; the index gets one new line.
