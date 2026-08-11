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

Refer to the template at `skills/github-actions/release-please/templates/release-please.yml` for a complete working example.
