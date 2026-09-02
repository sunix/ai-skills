# making-of

Maintain a first-person "making-of" journal in a repository — a blog-ish account of how the project is being built, updated at the end of each AI-assisted work session.

## Install it with diderot

[diderot](https://github.com/sunix/diderot) is a package manager for agent skills: it resolves a version constraint, pins what it resolved to by content digest in `diderot.lock`, and installs the same bytes anywhere. From the registry:

```bash
diderot add oci://ghcr.io/sunix/skills/making-of --version latest
diderot install
```

Or from this repository, to follow git rather than releases:

```bash
diderot add git+https://github.com/sunix/ai-skills#skills/documentation/making-of --version main
diderot install
```

`diderot add` needs a build newer than v0.2.0 ([diderot#34](https://github.com/sunix/diderot/pull/34)). With v0.2.0, declare it in `diderot.yaml` yourself and run `diderot update && diderot install`:

```yaml
skills:
  - name: making-of
    source: oci://ghcr.io/sunix/skills/making-of
    version: latest        # or an exact tag, or a range like "^1.0.0"
targets: [claude]          # or [agents], for .agents/skills
```

## Purpose

Formal docs explain **what** the project is. A making-of records **how it came together**: the reasoning, the measurements, the false starts, and the reversals — especially the reversals. It is written for new contributors, for future-you, and for anyone curious about building software with AI agents, and it may later turn into an actual blog post.

## What it does

1. Creates a `MAKING-OF.md` at the repository root (or adds a new entry to an existing one).
2. Writes in the **author's first-person voice**, in **blog style** — narrative prose meant to be read, not a changelog. The human's journal, drafted by the agent.
3. At the end of a work session, appends a new section covering what happened since the last update: what was done, the discussions with the LLM (proposals, pushback, corrections), decisions, dead ends, links to PRs/issues, measured numbers.
4. When code was generated, includes **proof that it works**: a snippet of the generated test, an explanation of why that test proves the fix, and the real output of running it.
5. Updates the **Last updated** date on every edit.
6. When the file grows too large, splits into one post per milestone under `doc/making-of/`, with the root file becoming an index.

## The two layouts

| Layout | When to use | Structure |
|--------|-------------|-----------|
| **Single living document** | One continuous investigation or a small/medium project | One `MAKING-OF.md`, sections added over time |
| **Post series** | A project shipped milestone by milestone | Root `MAKING-OF.md` is an index; each milestone gets `doc/making-of/NN-slug.md` |

Start with the single document. Split only when a section boundary is natural (a milestone shipped) **and** the file no longer reads in one sitting.

## Content rules

- **Blog style.** Narrative prose with full sentences and section titles that read like hooks, not labels — text that could be published as a blog post as-is. Never a changelog or a bullet list of commits.
- **First person, past tense, honest.** "I tried X, it fell apart because Y" — never marketing tone, never "we are pleased to".
- **Record the dead ends.** A reversal ("first instinct was forks; landed on worktrees") is the most valuable content, not something to edit out.
- **Goal first, with a concrete example.** Every session or milestone entry opens with what it set out to accomplish, shown concretely (the input the user writes, the command they run, the result they should get), before any how.
- **Pair the goal and the proof on the same test.** Red at the top, green at the bottom — the goal's failing run and the proof's passing run should be two executions of the *same* test, not a prose description on one end and unrelated output on the other.
- **Repeat the cycle per point, don't merge it.** An entry covering several distinct features or fixes gets one self-contained goal → what-was-built → proof per point, not one global pass that makes the reader hold every change in their head before the first proof shows up.
- **A coincidental pass isn't proof.** If a point's test already succeeds before the real implementation exists, say so rather than presenting the accidental green run as evidence.
- **Record the conversation.** The back-and-forth with the LLM is part of the story: what was proposed, what the author corrected, how the disagreement resolved.
- **Show proof, not claims.** When code was generated, the journal shows the evidence: the test snippet, why passing it proves the behavior is correct, and the real output of the test run — not just "it works now". Prefer oracle-based proofs (test against a reference tool's answer) over hardcoded expected values.
- **Walk through interesting code.** Quote the load-bearing snippets and explain why they are written that way — the reader should come away understanding the code's ideas, not just that it exists.
- **Show code and commands shoulder to shoulder.** Write every block as if you had invited another developer to look at your screen: name the file worth opening and take a path through it ("start with X", "notice what this *doesn't* have", "look at that last line"); for commands, say what you are running and what to watch for before showing the output. Every fenced block earns the sentence above it, and long context goes *after* the block, not before.
- **Tour the machinery.** When several files were created, tell each one's role and who calls what as a story (follow one command through the layers) with enough snippets that the reader never round-trips to the code, never as a bare inventory — what a maintainer or new contributor needs to open the hood. Don't let one clever piece eclipse the feature around it.
- **No meta-narration.** The journal never discusses its own writing or updating (exception: a repo whose subject is the making-of practice itself, like this skill's repo).
- **Be concrete.** Link the actual PRs and issues, quote the actual numbers, use tables for measured data. A claim that was verified says where it was verified.
- **Never rewrite history.** Past sections stay as written; if a past conclusion turned out wrong, add a new section saying so (that reversal is content).

## The header block

Every making-of opens with:

1. A title that states the project and the angle (e.g. "Building X: a Y, one prompt at a time").
2. An italic paragraph saying what the document is, its style ("journal, not docs"), who it is for, and its update policy ("updated on request as the work progresses").
3. A `*Last updated: YYYY-MM-DD.*` line, refreshed on every edit.

## Usage

- **Bootstrap**: ask the agent to "create a making-of for this project" — it reads the git history and any prior conversation context to draft the first entry.
- **Session updates**: at the end of a work session, say "update the making-of" — the agent appends what happened since the last update.

See [`prompt.md`](prompt.md) for the agent-ready instructions and [`templates/`](templates/) for the file skeletons.

## Customization

| What to change | How |
|----------------|-----|
| File name | Default `MAKING-OF.md`; use `making-of-<author>.md` when several people keep separate journals in one repo |
| Language | Match the language the author uses with the agent (the journal is personal, not project docs) |
| Location | Repository root by default; a subdirectory main file works too |
| Versioning | Usually committed; can be kept untracked if the journal is personal (note it in the intro block) |

## Example usage

See [`examples/example-usage.md`](examples/example-usage.md).
