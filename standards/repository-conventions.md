# Repository Conventions

These conventions apply to all content in the ai-skills repository.

## Naming

- Use **kebab-case** for all directory and file names.
- Skill directory names must reflect the skill's purpose (e.g., `pr-preview-surge`).
- Category directory names must reflect the tool or platform (e.g., `github-actions`).

## Directory structure

Every skill must follow this layout:

```
skills/<category>/<skill-name>/
  README.md
  prompt.md
  templates/
    <template-file>
  examples/
    example-usage.md
```

## Required files

| File | Required | Description |
|------|----------|-------------|
| `README.md` | Yes | Human-readable documentation |
| `prompt.md` | Yes | AI-agent-ready prompt |
| `templates/` | Yes | One or more implementation templates |
| `examples/example-usage.md` | Yes | Concrete usage examples |

## Documentation expectations

- All documentation must be written in **English**.
- Every skill must have a clear **Purpose** section.
- Every skill must list **prerequisites** and **required secrets or environment variables**.
- Every skill must include a **Customization** section describing the most likely things a user would change.
- Examples must be concrete and directly usable.

## Template expectations

- Templates must be self-contained.
- Templates must include inline comments explaining key decisions.
- Templates must fail early with clear error messages when required configuration is missing.

## Index

Every skill must be listed in `skills/index.md` with a one-line description.
