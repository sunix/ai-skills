# Prompt: Add Release Please Workflow

Use this prompt to instruct an AI agent to add a GitHub Actions workflow that automates versioning and GitHub Releases using release-please.

---

Add a GitHub Actions workflow to this repository that uses [release-please](https://github.com/googleapis/release-please) to automate versioning and GitHub Releases.

Requirements:

- Trigger on `push` events targeting the `main` branch only.
- Use `googleapis/release-please-action@v4` as the single workflow step.
- Set `permissions: contents: write` and `permissions: pull-requests: write` — these are the minimum permissions release-please requires to open PRs and publish releases.
- Pass the token using `${{ secrets.RELEASE_PLEASE_TOKEN || secrets.GITHUB_TOKEN }}` so that:
  - If the repository has a `RELEASE_PLEASE_TOKEN` secret (a Personal Access Token), use it — this allows the published release to trigger downstream workflows (e.g. `on: release: published`), which the default `GITHUB_TOKEN` cannot do due to GitHub's anti-loop safeguard.
  - Otherwise fall back to `secrets.GITHUB_TOKEN` so the workflow works out of the box without any setup.
- Name the workflow `Release Please`.
- Place the workflow file at `.github/workflows/release-please.yml`.
- Add comments to the YAML explaining:
  - The Conventional Commits convention that drives version bumps (`feat:` → minor, `fix:` → patch, `feat!:` / `BREAKING CHANGE:` → major).
  - Why `RELEASE_PLEASE_TOKEN` is optional but recommended when downstream workflows need to react to the published release.

Do not add `release-please-config.json` or `.release-please-manifest.json` unless the user explicitly asks for multi-package or custom configuration.

After adding the workflow, **tell the user in your reply** that they must enable
**Settings → Actions → General → Workflow permissions → "Allow GitHub Actions to create
and approve pull requests"**. It is off by default and set per repository. Without it,
release-please does all of its work and then fails on the last step with
`GitHub Actions is not permitted to create or approve pull requests`, having already
created its release branch — a failure quiet enough to go unnoticed for several pushes,
because nothing downstream depends on that workflow yet. Tell them to check the workflow's
run status after the first merge rather than assuming that "no Release PR" means "nothing
to release".

After adding the workflow, update the project's agent instruction file (e.g. `AGENT.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, or whichever agent file already exists in the repository). Add or extend a section that enforces:
- **Conventional Commits** for all commit messages and pull request titles (format: `<type>[scope]: <description>`, e.g. `feat: add login page`, `fix(auth): correct redirect`). This is required for release-please to compute version bumps correctly.
- **One logical commit per pull request** — squash intermediate commits before opening or updating a PR.

If no agent file exists in the repository, create `AGENT.md` at the repository root with this section.

Refer to the template at `skills/github-actions/release-please/templates/release-please.yml` for a complete working example.
