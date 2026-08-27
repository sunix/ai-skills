# pr-preview-surge

Deploy a static site PR preview to [Surge](https://surge.sh) when a `/preview` comment is posted on a pull request.

## Install it with diderot

[diderot](https://github.com/sunix/diderot) is a package manager for agent skills: it resolves a version constraint, pins what it resolved to by content digest in `diderot.lock`, and installs the same bytes anywhere. From the registry:

```bash
diderot add oci://ghcr.io/sunix/skills/pr-preview-surge --version "^1.0.0"
diderot install
```

Or from this repository, to follow git rather than releases:

```bash
diderot add git+https://github.com/sunix/ai-skills#skills/github-actions/pr-preview-surge --version main
diderot install
```

`diderot add` needs a build newer than v0.2.0 ([diderot#34](https://github.com/sunix/diderot/pull/34)). With v0.2.0, declare it in `diderot.yaml` yourself and run `diderot update && diderot install`:

```yaml
skills:
  - name: pr-preview-surge
    source: oci://ghcr.io/sunix/skills/pr-preview-surge
    version: "^1.0.0"      # newest 1.x — or an exact tag, or `latest`
targets: [claude]          # or [agents], for .agents/skills
```

## Purpose

Give reviewers a live preview URL for every pull request with a single comment. The workflow builds the site from the PR merge ref and publishes it to a deterministic Surge URL.

## What it does

1. Listens for `issue_comment` events on pull requests.
2. Runs when the comment body contains `/preview`.
3. Resolves the PR number and validates it is numeric.
4. Posts an "in progress" comment immediately so reviewers know a deployment has started.
5. Checks out the PR merge ref (`refs/pull/{number}/merge`).
6. Installs the dependencies required by the project's build toolchain (e.g. Ruby + Graphviz for Jekyll, Java + Maven for Quarkus Roq, Node.js for Vite/Next.js).
7. Builds the static site using the appropriate command for the stack.
8. Validates that `SURGE_TOKEN` is configured; fails with a clear message if it is not.
9. Deploys the build output to `https://pr-{number}-sciam-preview.surge.sh`.
10. Updates the "in progress" comment with the deployed URL on success, or with a link to the failed run on failure.

## Trigger

```
/preview
```

Post this as a comment on any open pull request. The workflow runs whenever the comment body contains `/preview`.

## Required secret

| Secret | Description |
|--------|-------------|
| `SURGE_TOKEN` | Authentication token for the Surge account used for deployments |

The workflow fails with a diagnostic message if this secret is missing or empty.

## How to generate SURGE_TOKEN

1. Install Surge:
   ```bash
   npm install -g surge
   ```
2. Log in (creates an account if you don't have one):
   ```bash
   surge login
   ```
3. Generate a token:
   ```bash
   surge token
   ```
4. Add the token to the repository:
   - Go to **Repository Settings → Secrets and variables → Actions → New repository secret**
   - Name: `SURGE_TOKEN`
   - Value: the token output from `surge token`

## Preview URL format

```
https://pr-{number}-sciam-preview.surge.sh
```

Example for PR #42:

```
https://pr-42-sciam-preview.surge.sh
```

## Customization

| What to change | Where to change it |
|----------------|--------------------|
| Surge subdomain prefix | Replace `sciam-preview` in the `DEPLOY_DOMAIN` variable inside the **Deploy to Surge** step |
| Build command | Replace `bundle exec jekyll build` in the **Build** step |
| Publish directory | Replace `_site` in the **Deploy** step with your build output directory |
| Trigger phrase | Replace `/preview` in the `contains(...)` condition on the job |

## Adapting for non-Jekyll sites

Replace the **Install dependencies** and **Build** steps with the commands for your stack. Examples:

```yaml
# Next.js
- run: npm ci
- run: npm run build
# Then set the publish directory to `out` or `.next`

# Hugo
- run: hugo
# Then set the publish directory to `public`

# Vite
- run: npm ci && npm run build
# Then set the publish directory to `dist`
```

## Security considerations

- The workflow uses the `issue_comment` trigger and checks out the PR merge ref, which represents the PR branch already merged with the base branch.
- `SURGE_TOKEN` is passed via `env:` and never echoed in logs.
- Concurrency is scoped per-PR to prevent overlapping deployments.

## Example usage

See [`examples/example-usage.md`](examples/example-usage.md).
