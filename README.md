# ai-skills

A reusable skills library for AI coding agents such as GitHub Copilot, Claude Code, and similar tools.

## What is a "skill"?

A skill is a self-contained, documented, and directly reusable implementation pattern. Each skill includes:

- A `README.md` explaining what it does and how to use it
- A `prompt.md` written for AI agents to consume directly
- One or more implementation files or templates
- Concrete examples that can be copied into another repository

## Purpose

This repository serves as a shared reference for AI agents and human developers. Instead of generating the same patterns from scratch each time, agents can discover, copy, and adapt skills from this library.

## How AI agents should use this repo

1. **Before generating a new pattern**, search `skills/index.md` for an existing skill.
2. **Copy the template** from the skill's `templates/` directory into the target repository.
3. **Follow the `prompt.md`** to understand required configuration and customization.
4. **Read `AGENT_GUIDE.md`** for the full protocol on adding or adapting skills.

## Available skills

### Documentation

| Skill | Description |
|-------|-------------|
| [`making-of`](skills/documentation/making-of/README.md) | Maintain a first-person making-of journal recording how a project is built — decisions, dead ends, and reversals — updated at the end of each AI-assisted session |

### GitHub Actions

| Skill | Description |
|-------|-------------|
| [`pr-preview-surge`](skills/github-actions/pr-preview-surge/README.md) | Deploy a static site PR preview to Surge when a `/preview` comment is posted on a pull request |
| [`push-to-surge`](skills/github-actions/push-to-surge/README.md) | Deploy a static site to Surge automatically on every push to the `main` branch |

### Webapp

| Skill | Description |
|-------|-------------|
| [`github-star-button`](skills/webapp/github-star-button/README.md) | Display the live GitHub star count for a repository and link to it directly from a web page |

For the full index, see [`skills/index.md`](skills/index.md).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add a new skill.
