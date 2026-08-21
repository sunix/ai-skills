# making-of

Maintain a first-person "making-of" journal in a repository — a blog-ish account of how the project is being built, updated at the end of each AI-assisted work session.

## Purpose

Formal docs explain **what** the project is. A making-of records **how it came together**: the reasoning, the measurements, the false starts, and the reversals — especially the reversals. It is written for new contributors, for future-you, and for anyone curious about building software with AI agents, and it may later turn into an actual blog post.

## What it does

1. Creates a `MAKING-OF.md` at the repository root (or adds a new entry to an existing one).
2. Writes in the **author's first-person voice** — the human's journal, drafted by the agent.
3. At the end of a work session, appends a new section covering what happened since the last update: decisions, dead ends, links to PRs/issues, measured numbers.
4. Updates the **Last updated** date on every edit.
5. When the file grows too large, splits into one post per milestone under `doc/making-of/`, with the root file becoming an index.

## The two layouts

| Layout | When to use | Structure |
|--------|-------------|-----------|
| **Single living document** | One continuous investigation or a small/medium project | One `MAKING-OF.md`, sections added over time |
| **Post series** | A project shipped milestone by milestone | Root `MAKING-OF.md` is an index; each milestone gets `doc/making-of/NN-slug.md` |

Start with the single document. Split only when a section boundary is natural (a milestone shipped) **and** the file no longer reads in one sitting.

## Content rules

- **First person, past tense, honest.** "I tried X, it fell apart because Y" — never marketing tone, never "we are pleased to".
- **Record the dead ends.** A reversal ("first instinct was forks; landed on worktrees") is the most valuable content, not something to edit out.
- **Be concrete.** Link the actual PRs and issues, quote the actual numbers, use tables for measured data. A claim that was verified says where it was verified.
- **Distinguish who did what.** What the agent proposed, what the human corrected, what was checked against the code.
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
