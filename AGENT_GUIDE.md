# Agent Guide

This guide defines how an AI coding agent should use this repository.

## Core principles

- **Search before creating.** Check `skills/index.md` before generating a new pattern.
- **Reuse templates.** Copy from `templates/` directories rather than writing from scratch.
- **Preserve documented conventions.** Follow `standards/repository-conventions.md` and `standards/markdown-style.md`.
- **Favor explicit code over clever abstractions.** Inline build steps, name variables clearly, and avoid indirection that makes templates harder to adapt.

## How to use a skill in another repo

1. Find the relevant skill in [`skills/index.md`](skills/index.md).
2. Read the skill's `README.md` to understand prerequisites and required secrets.
3. Read the skill's `prompt.md` for the exact instruction to give an agent.
4. Copy the file(s) from `templates/` into the target repository at the appropriate path.
5. Apply any customizations described in the skill's README (e.g., subdomain prefix, build command).
6. Commit and push. The skill should work without further changes if prerequisites are met.

## How to add a new skill

1. Create a directory under `skills/<category>/<skill-name>/` using kebab-case.
2. Add the required files (see [CONTRIBUTING.md](CONTRIBUTING.md)):
   - `README.md`
   - `prompt.md`
   - `templates/<template-file>`
   - `examples/example-usage.md`
3. Add an entry to [`skills/index.md`](skills/index.md).
4. Follow the style rules in [`standards/markdown-style.md`](standards/markdown-style.md).
5. Open a pull request.

## What agents must not do

- Do not skip the skill index lookup before generating a new implementation.
- Do not modify a skill's template in a way that breaks the documented behavior.
- Do not introduce dependencies that are not listed in the skill's README.
- Do not use non-English documentation.
