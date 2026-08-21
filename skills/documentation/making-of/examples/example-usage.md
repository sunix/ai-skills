# Example Usage: making-of

## When to use this skill

Use this skill on any project built with AI-assisted sessions where the reasoning is worth keeping: why decisions were made, what was tried and abandoned, what was measured. It replaces "the git log knows what changed" with "the journal knows why".

## Bootstrap

At the start (or any point) of a project, tell the agent:

```text
Create a making-of for this project. Follow skills/documentation/making-of/prompt.md.
Start from the git history and what we did in this session.
```

The agent creates `MAKING-OF.md` from the template, drafts "Why this exists" and the first sections, and asks about anything it cannot reconstruct from the repository.

## End-of-session update

At the end of a work session:

```text
Update the making-of.
```

The agent appends new sections covering the session and refreshes the date. A typical appended section:

```markdown
## Turns out the install script itself needed fixes first

Before a single data point existed, just getting `00-install.sh` to pass
green surfaced two real issues in the tool itself:

- **[#17](https://github.com/example/tool/issues/17)** — the README's
  install command 404s, because release assets are version-prefixed but the
  documented command hardcodes an unversioned filename. **Fixed and merged**
  in [PR #21](https://github.com/example/tool/pull/21).
- **[#19](https://github.com/example/tool/issues/19)** — a request sent
  before the init notification is silently dropped. Traced it into the
  upstream SDK, which has a `TODO` acknowledging the exact gap. A dead end
  worth recording: not our bug, reported upstream.
```

Note the pattern: first person, concrete links, a dead end recorded as content.

## Sample header block (what the top of the file looks like)

```markdown
# Building Erasmus: a Jakarta Bean Validation implementation, one prompt at a time

*A first-person account of how this project came together — the tooling, the
false starts, and the implementation work — kept here for new contributors,
or anyone curious how it came together. Written in a blog-ish style rather
than as formal docs; may still turn into an actual blog post at some point.
Updated on request as the work progresses.*

*Last updated: 2026-08-19.*
```

## Splitting into a post series

When the file gets long and a milestone ships, tell the agent:

```text
The making-of is getting long. Split it into per-milestone posts under
doc/making-of/ and turn MAKING-OF.md into an index.
```

The resulting index body:

```markdown
## Posts

1. [Kicking off Erasmus: from an empty reactor to a working validator](doc/making-of/01-kicking-off-erasmus.md) —
   the tooling detour, cloning the workspace, the first two prompts, and
   milestones M0 (scaffolding) + M1 (the first 6 built-in constraints).
2. [M2: the full built-in constraint set and message interpolation](doc/making-of/02-full-constraint-set.md) —
   the remaining 15 constraints, locale-aware bundles, and a homegrown
   EL-subset evaluator.
```

## Variations

- **Per-author journal**: in a shared repo, name the file `making-of-<author>.md` so each contributor keeps their own voice.
- **Untracked journal**: if the journal is personal, keep it out of version control and say so in the intro block ("Not versioned in the repository for now.").
- **Language**: the journal is written in whatever language the author works in with the agent (e.g. French), even if project docs are in English.
