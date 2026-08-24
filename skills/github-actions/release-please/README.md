# release-please

Automate versioning and GitHub Releases using [release-please](https://github.com/googleapis/release-please).

## Purpose

Keep a continuously updated "Release PR" that accumulates [Conventional Commits](https://www.conventionalcommits.org/) changes. Merging that PR automatically bumps the version, publishes a GitHub Release, creates a tag, and updates `CHANGELOG.md` — with no manual steps.

## What it does

1. Triggers on every push to the `main` branch.
2. Inspects new commits for Conventional Commits prefixes to compute the next version:
   - `feat:` → minor bump
   - `fix:` → patch bump
   - `feat!:` or a `BREAKING CHANGE:` footer → major bump
   - `chore:`, `docs:`, `ci:`, etc. → no version bump (still recorded in changelog)
3. Opens (or updates) a "Release PR" that contains the version bump and an updated `CHANGELOG.md`.
4. When the Release PR is merged, publishes a GitHub Release and creates a git tag.

## Trigger

Every push to `main` causes release-please to evaluate new commits and keep the Release PR up to date.

## Required repository setting

**Settings → Actions → General → Workflow permissions → "Allow GitHub Actions to create
and approve pull requests"** must be enabled. It is off by default, and set per
repository.

Without it, release-please parses your commits, computes the versions, writes the
changelog, pushes its own `release-please--branches--main` branch — and then fails on the
last call:

```text
release-please failed: GitHub Actions is not permitted to create or approve pull requests.
```

No Release PR appears, and because nothing else depends on this workflow, the red run is
easy to miss. Check the workflow's status after your first merge instead of concluding
that there was nothing to release.

## Required secrets

No secrets are strictly required. The workflow uses the built-in `GITHUB_TOKEN` by default.

### Optional secret

| Secret | Description |
|--------|-------------|
| `RELEASE_PLEASE_TOKEN` | A Personal Access Token (PAT) with `repo` scope. Set this when you need the published GitHub Release to trigger other workflows (e.g. `on: release: published`), because GitHub's default `GITHUB_TOKEN` cannot trigger downstream workflow runs. |

If `RELEASE_PLEASE_TOKEN` is not set, the workflow falls back to `GITHUB_TOKEN` — release-please itself will work, but releases published by it will not re-trigger other workflows.

## How to generate RELEASE_PLEASE_TOKEN (optional)

1. Go to **GitHub → Settings → Developer settings → Personal access tokens → Fine-grained tokens** (or classic tokens with `repo` scope).
2. Create a token with **Contents: Read and write** and **Pull requests: Read and write** permissions on the target repository.
3. Add the token as a repository secret:
   - Go to **Repository Settings → Secrets and variables → Actions → New repository secret**
   - Name: `RELEASE_PLEASE_TOKEN`
   - Value: the token you just generated

## Agent file update

When applying this skill, also update the project's agent instruction file (`AGENT.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, or whichever agent file already exists). Add a section that enforces:

- **Conventional Commits** for all commit messages and pull request titles — required so release-please can compute version bumps.
- **One logical commit per pull request** — squash intermediate commits before opening or updating a PR.

If no agent file exists, create `AGENT.md` at the repository root with this section.

## Commit message convention

Commits merged to `main` must follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Common types and their effect on versioning:

| Commit prefix | Version bump |
|---------------|-------------|
| `feat:` | Minor (`1.2.0` → `1.3.0`) |
| `fix:` | Patch (`1.2.0` → `1.2.1`) |
| `feat!:` or `BREAKING CHANGE:` footer | Major (`1.2.0` → `2.0.0`) |
| `chore:`, `docs:`, `ci:`, `refactor:`, `test:` | None (recorded in changelog) |

## Default workflow name

```
Release Please
```

## Customization

| What to change | Where to change it |
|----------------|--------------------|
| Source branch | Replace `main` in the `branches` list under `on.push` |
| Release type / config | Add a `release-please-config.json` to the repository root |
| Package manifest | Add a `.release-please-manifest.json` to track current versions |
| Downstream workflow triggering | Set the `RELEASE_PLEASE_TOKEN` repository secret |

## Security considerations

- The workflow uses minimal permissions: `contents: write` and `pull-requests: write` — exactly what release-please requires.
- `RELEASE_PLEASE_TOKEN`, when set, is resolved by GitHub Actions and never echoed in logs.

## Example usage

See [`examples/example-usage.md`](examples/example-usage.md).
