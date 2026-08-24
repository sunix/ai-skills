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

## Versioning and publishing

Each skill is versioned **independently**. `release-please` treats every directory under
`skills/` as its own package, so the scope in your commit message decides what moves:

```
feat(making-of): require a machinery tour     ->  making-of 1.0.0 -> 1.1.0
fix(push-to-surge): correct the publish dir   ->  push-to-surge 1.0.0 -> 1.0.1
docs: tidy the index                          ->  nothing bumped
```

Use the skill's directory name as the scope. Merging the Release PR that release-please
maintains tags each released skill (`making-of-v1.1.0`), and then publishes it to
`ghcr.io/sunix/skills/<name>` under **two** tags: the semver one, `1.1.0`, and `latest`
moved forward.

One caveat worth knowing: a semver tag is stable in practice because the release flow
pushes it once, but it is not *technically* immutable. The ORAS SDK stamps each push with
a fresh `org.opencontainers.image.created` timestamp, so re-publishing the same skill at
the same version produces a different manifest digest — identical content, different
manifest. Consumers are unaffected (diderot verifies the content digest, which does not
change), but avoid re-dispatching a publish for a version that already exists.

There is deliberately no floating `v1`: a consumer wanting "the newest 1.x" expresses
that as a range (`^1.0.0`) against the published semver tags, and a major-only tag would
look like a pin while quietly moving. `latest` cannot be misread.

`version.txt` in each skill directory is release-please's bookkeeping — don't edit it by
hand. It ships inside the skill, so consumers can read it after installing.

The version is deliberately *not* duplicated into `SKILL.md`'s frontmatter, even though
the Agent Skills spec has a field for it: diderot resolves versions from the **OCI tag**,
never from the file, so a second copy would buy nothing and could drift from the first.

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
