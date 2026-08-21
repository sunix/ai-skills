---
name: pr-preview-surge
description: Add a GitHub Actions workflow that deploys a pull request preview of a static site to Surge when someone comments /preview on the PR, and posts the preview URL back as a PR comment. Use when the user wants PR preview deployments or review apps for a static site on Surge.
---

# PR preview deployments to Surge

Add a GitHub Actions workflow to the current repository that deploys a pull request preview to Surge when a `/preview` comment is posted on the PR.

Copy [templates/preview-pr.yml](templates/preview-pr.yml) to `.github/workflows/preview-pr.yml` in the target repository, then adapt it:

- Trigger on `issue_comment` created events; run only when the comment contains `/preview` and is on a pull request. Validate the PR is mergeable before deploying (never deploy a stale merge ref).
- Post an "in progress" PR comment immediately (capture its ID), check out `refs/pull/{PR_NUMBER}/merge`, build, deploy to `pr-{PR_NUMBER}-<project>.surge.sh`, then **update** that same comment with the preview URL on success or the failed run link on failure.
- Detect the build toolchain (Jekyll, Hugo, Vite/Next.js, Quarkus Roq/Maven) and keep only the setup/build steps it needs — same detection table as the `push-to-surge` skill.
- Validate the `SURGE_TOKEN` secret exists, failing with instructions if missing.
- Concurrency control scoped to the PR number; minimal permissions (`contents: read`, `pull-requests: write`); build steps inline.

Full requirements list: [prompt.md](prompt.md). Human documentation: [README.md](README.md).
