# Example Usage: release-please

## When to use this skill

Use this skill when you want versioning and GitHub Releases to be fully automated. It is ideal for any project where commits to `main` follow [Conventional Commits](https://www.conventionalcommits.org/) and you want a changelog, version bump, and GitHub Release generated without manual steps.

## Setup

1. Copy `.github/workflows/release-please.yml` from the template into your repository.

2. Ensure commits merged to `main` follow Conventional Commits:
   - `feat: add login page` → bumps minor version
   - `fix: correct redirect URL` → bumps patch version
   - `feat!: redesign API` or commit with `BREAKING CHANGE:` footer → bumps major version

3. *(Optional)* Create a `RELEASE_PLEASE_TOKEN` secret if you have downstream workflows that must react to the published release:
   - Go to **Repository Settings → Secrets and variables → Actions → New repository secret**
   - Name: `RELEASE_PLEASE_TOKEN`
   - Value: a PAT with `Contents: Read and write` and `Pull requests: Read and write` on the repository

4. Push a `feat:` or `fix:` commit to `main`. Release Please opens a Release PR automatically.

5. Merge the Release PR. Release Please publishes a GitHub Release, creates a git tag, and updates `CHANGELOG.md`.

---

## Sample Release PR title

```
chore(main): release 1.1.0
```

The PR body contains the full changelog for the new version.

---

## Sample successful run output

```
Please wait while I check if a release is needed...
Created or updated release PR: https://github.com/my-org/my-repo/pull/42
```

After merging the Release PR:

```
Creating release for tag v1.1.0...
Release created: https://github.com/my-org/my-repo/releases/tag/v1.1.0
```

---

## Without RELEASE_PLEASE_TOKEN

The workflow works fine without the secret — release-please opens PRs and publishes releases normally. The only limitation is that the published release will not trigger other workflows that listen on `on: release: published`, because GitHub's default `GITHUB_TOKEN` cannot fire cross-workflow events.

If you need a build, Docker push, or deployment workflow to run after a release is published, set `RELEASE_PLEASE_TOKEN`.
