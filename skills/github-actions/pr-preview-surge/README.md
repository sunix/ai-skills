# pr-preview-surge

Deploy a static site PR preview to [Surge](https://surge.sh) when a `/preview` comment is posted on a pull request.

## Purpose

Give reviewers a live preview URL for every pull request with a single comment. The workflow builds the site from the PR branch and publishes it to a deterministic Surge URL.

## What it does

1. Listens for `issue_comment` events on pull requests.
2. Ignores comments that are not exactly `/preview`.
3. Validates that `SURGE_TOKEN` is configured; fails with a clear message if it is not.
4. Resolves the PR number and checks out the PR HEAD commit.
5. Installs Ruby 3.1, Node.js 20, and Graphviz.
6. Builds a Jekyll site (`bundle exec jekyll build`).
7. Deploys `_site/` to `https://pr-{number}-sciam-preview.surge.sh`.
8. Posts a success comment with the deployed URL.
9. Posts a failure comment if any step fails.

## Trigger

```
/preview
```

Post this as a comment on any open pull request. The workflow ignores comments that do not match exactly.

## Required secret

| Secret | Description |
|--------|-------------|
| `SURGE_TOKEN` | Authentication token for the Surge account used for deployments |

The workflow fails immediately with a diagnostic message if this secret is missing or empty.

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
| Surge subdomain prefix | Replace `sciam-preview` in the `SURGE_DOMAIN` env var |
| Build command | Replace `bundle exec jekyll build` in the **Build** step |
| Publish directory | Replace `_site` in the **Deploy** step and `SURGE_DOMAIN` env var |
| Trigger phrase | Replace `/preview` in the `if:` condition on the job |

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

- The workflow uses `pull_request_target`-equivalent permissions carefully: it only reads repository contents and posts comments. It does not expose secrets to untrusted code from the PR branch.
- `SURGE_TOKEN` is passed via `env:` and never echoed in logs.
- Concurrency is scoped per-PR to prevent overlapping deployments.

## Example usage

See [`examples/example-usage.md`](examples/example-usage.md).
