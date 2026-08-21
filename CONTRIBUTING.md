# Contributing

Thank you for contributing to ai-skills. Follow these guidelines to keep the library consistent and agent-friendly.

## Adding a new skill

1. Create a directory under `skills/<category>/<skill-name>/` using kebab-case names.
2. Include all required files (see below).
3. Add an entry to `skills/index.md`.
4. Open a pull request with a clear description of what the skill does.

## Required files for every skill

| File | Purpose |
|------|---------|
| `SKILL.md` | [Agent Skills](https://agentskills.my/specification/) entry point: YAML frontmatter (`name`, `description`) + condensed agent instructions. This is what skill tooling (Claude Code plugins, `gh skill`, `npx skills`) discovers and loads |
| `README.md` | Human-readable explanation, prerequisites, usage, and customization notes |
| `prompt.md` | AI-agent-ready prompt that instructs an agent to apply the skill |
| `templates/<file>` | One or more copyable implementation files (YAML, scripts, configs, etc.) |
| `examples/example-usage.md` | Concrete examples showing the skill in action |

### SKILL.md requirements

- Frontmatter: `name` (kebab-case, matching the directory name) and `description` (one or two sentences stating what the skill does **and when to use it** — agents match on this text).
- Body: condensed instructions linking to `prompt.md`, `templates/`, and `README.md` by relative path.
- If you create a **new category** directory, also add it to the `skills` array in [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json) — skill discovery scans each listed category directory one level deep.
- Verify discovery before opening the PR:
  ```bash
  claude plugin validate .
  claude --plugin-dir . plugin details ai-skills   # your skill must appear in the inventory
  ```

## Documentation requirements

- All documentation must be written in **English**.
- Every example must be **runnable or directly copyable** into another repository.
- Keep language clear and concise. Avoid long narrative paragraphs.
- Follow [`standards/markdown-style.md`](standards/markdown-style.md) for formatting.

## Code and template requirements

- Templates must be **self-contained**. Do not rely on files outside the template.
- Inline build steps and configuration where possible — prefer clarity over abstraction.
- Validate required secrets or environment variables early and fail with clear error messages.
- Include inline comments in YAML and scripts to explain important decisions.

## Naming conventions

- Use **kebab-case** for all directory and file names.
- Use descriptive names that reflect the skill's purpose (e.g., `pr-preview-surge`, not `surge` or `preview`).

## Review criteria

A skill PR will be accepted when:

- [ ] All required files are present
- [ ] The template works as documented
- [ ] The example is concrete and realistic
- [ ] Documentation is in English and follows the style guide
- [ ] The skill index is updated
