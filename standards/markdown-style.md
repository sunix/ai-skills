# Markdown Style Guide

Keep Markdown simple, readable, and AI-friendly.

## General rules

- Write in **English**.
- Keep sections **short** and focused on one idea.
- Prefer **bullet points** over long paragraphs.
- Use **code blocks** for commands, file paths, YAML, and example output.
- Use **tables** for structured lists (e.g., file requirements, options).
- Use **bold** for key terms introduced for the first time.
- Avoid italic text except for genuine emphasis.

## Headings

- Use `#` for the page title (one per file).
- Use `##` for top-level sections.
- Use `###` for sub-sections.
- Do not skip heading levels.

## Code blocks

Always specify the language for syntax highlighting:

````markdown
```yaml
key: value
```

```bash
npm install -g surge
```
````

## Links

- Use relative paths for links within the repository.
- Use descriptive link text — not "click here" or raw URLs.

## Lists

- Use `-` for unordered lists.
- Use numbered lists only when order matters (steps, sequences).
- Keep list items concise (one sentence or less when possible).

## Avoid

- Long narrative paragraphs
- Redundant preamble ("In this document, we will explain…")
- Repeated information across sections
- Clever formatting that breaks plain-text readability
