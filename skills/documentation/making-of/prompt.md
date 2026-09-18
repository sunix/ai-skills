# Prompt: Maintain a Making-Of Journal

Use this prompt to instruct an AI agent to create or update a first-person making-of journal in a repository.

---

Maintain a making-of journal for this repository: a first-person, blog-ish account of how the project is being built, written in the author's voice, for new contributors and anyone curious how it came together.

**Write as the author with another developer sitting beside them.** Every entry is that conversation: here is the feature I built, here is why it needed building, here is the code I wrote and why it reads the way it does, and here is the proof it does what I set out to do. The rules below all follow from that one, so when they seem to conflict, ask what you would actually say to somebody looking at the screen with you. Showing beats describing. A snippet beats a summary of a snippet. A claim with no output under it is not finished. A section that would embarrass you if read aloud to that person is wrong, however well written.

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
- Each update must cover four things, in this order:
  1. **The goal, with a concrete example** — open with what the session set out to accomplish, shown concretely (the user story, the input the user writes, the command they run, the result they should get) *before* any how. The reader must know what success looks like before reading how it was reached.
  2. **What was done** — the changes, decisions, and outcomes of the session.
  3. **The discussions with the LLM** — what the agent proposed, what the author pushed back on or corrected, and how the disagreement resolved. A correction the author made to the agent's first answer is prime content.
  4. **Proof that generated code works** — see "Show proof, not claims" below. If code was written this session, the update is not complete without its evidence.
- **Pair beats 1 and 4 on the same test.** The goal's concrete example and the proof's test-runner output should be two runs of the *same* test — red at the top, green at the bottom. A goal described only in prose, with no failing run to back it, is half the argument; a proof with nothing to point back at is the other half missing.
- **A test-runner line with no code above it proves nothing to the reader.** `expected: <1> but was: <0>` only means something once the reader has seen the class or annotation the goal is about and the test method that produced that line — show both, trimmed to the relevant lines, before the command output, every time, in beat 1 and beat 4 alike. The same applies to beat 2: a snippet of the actual fix beats a sentence describing it. Command output on its own is for beats with no code at all (docs, config, an infra step).
- **When an entry covers several distinct points** — a milestone with more than one sub-feature, several unrelated fixes in one session — don't compress them into one global goal → what-was-done → proof. That forces the reader to hold every change in their head before the first proof ever shows up. Repeat the shape once per point instead, each one self-contained: its own concrete goal (paired with its own red run when TDD produced one), its own explanation of what changed, its own proof. A `##`/`###` per point is the natural boundary. Beat 3 and the tour-of-the-machinery below still apply across the whole entry, not per point — repeating those per point fragments the story for no reason.
- **Shape the branch like the entry: one commit per point, titled like its section.** When the work ships as a branch alongside the entry, make each point its own commit so `git log --oneline` reads as the entry's table of contents and a commit's diff can sit next to the section that explains it. Build the commits incrementally and keep every intermediate state green for the tests it contains — the diffs have to be small enough to read in one sitting, not a cosmetic split of the final diff. Where two points genuinely must land together (a recursion and its cycle guard), or a point has no commit at all (a design discussion, a test-only check), the section's opening line says so rather than forcing a split or a fake commit. Every section then **opens with the files worth having open**: an italic line naming the commit and linking the two to five files to look at, with relative links from the entry's location — and the prose points at the method or the lines ("open `Validator.java` at `walk`, the first three lines"), not just the file. The reader has the code on the other half of the screen; say where to look.
- **A test that passed before the fix isn't proof of anything.** Sometimes a point's test happens to already read correctly even before the real implementation exists — a coincidence of that specific fixture, not evidence the feature works. Say so plainly (what made it pass anyway, what would need to differ to actually tell old from new) rather than quoting the accidental green run as if it were the point's proof.
- When the session generated interesting code, also **walk through it**: quote the load-bearing snippets (trimmed) and explain why they are written that way — the tricky rule they encode, the edge case they guard. The journal is where a reader should understand the code's ideas, not just learn that it exists.
- **Write every code and command block as a shoulder-to-shoulder explanation**, as if the author had invited another developer to look at their screen. Applies to both kinds of block:
  - *Code*: name the file worth opening, then take a path through it — "start with `push`, which is shorter than you'd expect", "now the other direction, and the interesting part is what it *doesn't* have", "look at that last line". Never a declarative label followed by a fence.
  - *Commands and output*: say what is about to be run and what to watch for, so the reader knows which question the output answers before seeing it — "so watch what it prints", "then the two commands that matter, run against that freshly produced executable".
  - Every fenced block earns the sentence above it: that sentence says *why the block is there*, not merely that it exists. A lead-in ending in a bare colon after a flat clause ("…torn down at the end of the run:") is the tell that it doesn't.
  - When the context is long, put the short pointer *before* the block and the explanation *after* it — the reader should reach the code within a line or two, then be told what they just read.
  - Never open a walkthrough on inventory (dependency coordinates, a list of new files): that reads as a changelog. Open on what the reader should do or notice, and let the details follow.
- When the session drove a UI — a web app, a site, any flow with a screen — show the screen with annotated screenshots (see "Show the screen" below).
- When the session created several files, give the **tour of the machinery**: every new file's role and who calls what, told as a story — follow one command or request through the layers, from entry point to effect — never as a bare inventory, and with enough trimmed snippets that the reader never has to leave the journal for the code. Cover what a maintainer or new contributor needs to open the hood: entry points, the core engine, the boundaries to the outside world (subprocesses, network, filesystem), and how the tests mirror the layout. Guard against tunnel vision: don't let the one clever piece of the session eclipse the feature around it.
- Update the `*Last updated:*` date. Change nothing else in the header block.
- Never rewrite or delete past sections. If a past conclusion turned out wrong, say so in the new section — the reversal is the content.

## Show proof, not claims

When a session produced generated code (a fix, a feature), never just state that it works. Include the evidence, as a reader would need it to believe you:

- **A snippet of the test** that exercises the change — the generated test itself, trimmed to the relevant assertion, in a fenced code block.
- **Why this test proves it** — one or two sentences connecting the assertion to the bug or requirement: what would have failed before the change, and why passing now means the behavior is correct (not just that the code runs).
- **The actual output of running it** — the real test-runner output (trimmed), in a fenced code block. A green run that was actually executed, not a description of one. If the test was also run against the pre-fix code to show it failing, include that red output too — it is the strongest proof.

Prefer **oracle-based proofs** over hardcoded expectations: when a reference implementation exists (the real git, the real compiler, the live API), the test should compare against the oracle's answer instead of a fixed expected value — a hardcoded value only asserts that the code does what the code does. Record that choice in the journal entry; the reasoning is content.

If the change cannot be proven by a test (docs, config), show the equivalent evidence: the command run and its real output.

## Show the screen (annotated screenshots)

When a session drove a UI — a web app, a site, any flow with a screen — the entry shows the screen the way code entries show snippets. A described click ("then I pressed the seal button") is a claim; the annotated screenshot is its evidence, and often the only record of a state that will never come back.

- **Capture at the moment of the gesture.** Screenshot the screen as the reader would see it right before (or right after) the action the prose describes. Use the browser automation at hand — Playwright for web UIs. For a sequence of gestures, one capture with numbered labels beats three captures.
- **Annotate before capturing.** A red box or arrow on the exact spot the reader must look, plus a short label saying what they are looking at ("1 · retype the word SEAL — a stray space is a clean refusal"). Inject the annotations as a floating overlay and remove it afterwards; never alter the app's own state to decorate it.
- **Verify the framing, then verify the file.** Scroll the annotated element to the center of the viewport; before capturing, check that the element **and** its label sit fully inside the viewport (measure with `getBoundingClientRect`, place the label above the element when it sits low). After capturing, re-read the saved image **before taking the next action**. This order matters: ceremonies, modals, wizards and error toasts are ephemeral — once the flow moves on, a truncated capture of that state cannot be retaken.
- **Embed inline, never link.** Images live in the repo (e.g. `demo-captures/NN-slug.png`, numbered in story order) and appear inline where the story needs them: `![caption saying what to notice](demo-captures/04-seal-ceremony.png)`. A bare link ("see the annotated capture") sends the reader away mid-sentence; the picture belongs in the flow of the prose.
- **Re-staging is content, not a secret.** If a capture must be replayed later (the state moved on, the original shipped truncated), the entry says so — what differs on screen, why the replay is faithful to the original gesture — and the superseded image stays in git history. A replay on a throwaway fixture is fine when the real state is unrecoverable, as long as the journal names it.

## Content rules (both modes)

- **Blog style, not changelog style.** Full sentences and narrative flow, written to be read — the kind of text that could be published as a blog post as-is. Section titles are statements or hooks ("Turns out the install script needed fixes first"), not labels ("Fixes"). No bare bullet lists of commits.
- **First person, past tense, honest.** The human author's journal, drafted by you. No marketing tone, no "we are excited to".
- **Record reasoning, not just outcomes.** What was tried first, why it fell apart, what was landed on instead. Dead ends get their own paragraphs.
- **Record the conversation.** The back-and-forth with the LLM is part of the story: what was asked, what the agent got wrong, what the author corrected. Quote the pivotal exchange when it explains a decision.
- **Show proof, not claims.** Generated code is only "done" in the journal when the evidence is shown (see the section above).
- **Be concrete.** Link actual PRs, issues, and files; quote measured numbers; use tables for data. When a claim was verified, say against what.
- **No meta-narration.** The journal never talks about the writing or updating of the journal itself — no "I updated this making-of", no describing the journal's structure, its update ritual, or the skill that produced it. Sole exception: a repository whose subject *is* the making-of practice (e.g. the repo hosting this skill).
- **Keep it readable in one sitting.** Sections short, one idea each.

## Review annotations (how the author marks up a draft)

A draft comes back marked up. The author writes remarks into the file itself, as blockquotes
beginning with `@claude`, placed immediately next to what they are about:

```markdown
The caret reads "anything compatible with 1.0.0".

> @claude is that npm's notation? say where it comes from, a reader will not know
```

They may sit anywhere in any file, span several lines as long as each line is quoted, and there may
be a dozen of them in one pass.

For each one:

1. **Answer it in the prose.** The remark is a question or an objection about the text. Rewrite the
   passage so the question no longer arises — do not append a parenthesis, a footnote, or a note
   saying "as asked". A reader who was not in the conversation should not be able to tell an
   annotation was ever there.
2. **Delete the annotation.** It is a working note, not content.
3. **Say what you changed**, remark by remark, in your reply — that is where the author checks you
   understood, not in the file.
4. **When the answer is a fact you do not have**, go and get it: read the source, run the command,
   quote what came back. "I could not find it" written plainly beats a paragraph that talks around
   the hole.

Two failure modes worth naming, because both look like work:

- **Answering beside the text instead of in it** — adding "(this is npm's notation)" where the
  passage needed rewriting.
- **Answering the words rather than the objection** — the remark "this asserts X without saying
  where it comes from" is not asking for the sentence to be softened, it is asking for the source.

Nothing carrying the marker may be merged: to everyone who was not in the conversation, a forgotten
remark reads as content. Copy `templates/check-review-markers.sh` into the repository (the usual home
is `scripts/`) and run it from CI:

```yaml
review-annotations:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - run: ./scripts/check-review-markers.sh
```

A marker inside a fenced code block is an example, not a remark, so it is ignored — which is what
lets the file that documents the convention pass its own check. Pass a path to skip a file that
shows one outside a fence.

Document the convention where the repository's agent instructions live (`AGENTS.md`, `CLAUDE.md`,
`CONTRIBUTING.md`), so a human reviewer knows the syntax is available and an agent knows what to do
with it.

## Splitting into a post series

When the single file no longer reads in one sitting **and** a natural boundary exists (a milestone shipped):

- Move the body into `doc/making-of/NN-<slug>.md` posts (copy the post skeleton from `skills/documentation/making-of/templates/making-of-post.md`).
- Turn the root `MAKING-OF.md` into an index: keep the header block, replace the body with a numbered "Posts" list, one line per post with a link and a one-sentence summary of what it covers.
- New milestones get new posts; the index gets one new line.
