---
name: release-please
description: Add a GitHub Actions workflow that automates semantic versioning, changelogs, and GitHub Releases using release-please and Conventional Commits. Use when the user wants automated releases, version bumps, release PRs, or changelog generation on a GitHub repository.
---

# Automated releases with release-please

Add a GitHub Actions workflow to the current repository that uses [release-please](https://github.com/googleapis/release-please) to automate versioning and GitHub Releases.

Copy [templates/release-please.yml](templates/release-please.yml) to `.github/workflows/release-please.yml` in the target repository. Key points to preserve:

- Trigger on `push` to `main`; single step using `googleapis/release-please-action@v4`.
- Permissions: `contents: write` and `pull-requests: write` (the minimum release-please needs).
- Token: `${{ secrets.RELEASE_PLEASE_TOKEN || secrets.GITHUB_TOKEN }}` — a PAT lets the published release trigger downstream `on: release` workflows (the default `GITHUB_TOKEN` cannot, due to GitHub's anti-loop safeguard); the fallback keeps it zero-setup.
- Do not add `release-please-config.json` / `.release-please-manifest.json` unless the user explicitly asks for multi-package or custom configuration.

Then update the project's agent instruction file (`AGENT.md`, `CLAUDE.md`, `.github/copilot-instructions.md` — whichever exists, else create `AGENT.md`) to enforce **Conventional Commits** (`feat:` → minor, `fix:` → patch, `feat!:`/`BREAKING CHANGE:` → major) for commits and PR titles, and one logical commit per PR.

Full requirements list: [prompt.md](prompt.md). Human documentation: [README.md](README.md).
