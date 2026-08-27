# push-to-surge

Deploy a static site to [Surge](https://surge.sh) automatically when code is pushed to the `main` branch.

## Install it with diderot

[diderot](https://github.com/sunix/diderot) is a package manager for agent skills: it resolves a version constraint, pins what it resolved to by content digest in `diderot.lock`, and installs the same bytes anywhere. From the registry:

```bash
diderot add oci://ghcr.io/sunix/skills/push-to-surge --version latest
diderot install
```

Or from this repository, to follow git rather than releases:

```bash
diderot add git+https://github.com/sunix/ai-skills#skills/github-actions/push-to-surge --version main
diderot install
```

`diderot add` needs a build newer than v0.2.0 ([diderot#34](https://github.com/sunix/diderot/pull/34)). With v0.2.0, declare it in `diderot.yaml` yourself and run `diderot update && diderot install`:

```yaml
skills:
  - name: push-to-surge
    source: oci://ghcr.io/sunix/skills/push-to-surge
    version: latest        # or an exact tag, or a range like "^1.0.0"
targets: [claude]          # or [agents], for .agents/skills
```

## Purpose

Publish the latest version of your static site to Surge on every push to `main`, giving you a continuously updated live URL without any manual steps.

## What it does

1. Triggers on every push to the `main` branch.
2. Checks out the repository at the pushed commit.
3. Installs the dependencies required by the project's build toolchain (e.g. Ruby + Graphviz for Jekyll, Java + Maven for Quarkus Roq, Node.js for Vite/Next.js).
4. Builds the static site using the appropriate command for the stack.
5. Validates that `SURGE_TOKEN` and `SURGE_DOMAIN` are configured; fails with a clear message if either is missing.
6. Deploys the build output to the configured Surge domain.

## Trigger

Every push to the `main` branch automatically starts the deployment.

## Required secrets

| Secret | Description |
|--------|-------------|
| `SURGE_TOKEN` | Authentication token for the Surge account used for deployments |
| `SURGE_DOMAIN` | The full Surge domain to deploy to (e.g. `my-project.surge.sh`) |

Both secrets are required. The workflow fails with a diagnostic message if either is missing or empty.

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

## How to set SURGE_DOMAIN

Add a second secret to the repository:

- Go to **Repository Settings → Secrets and variables → Actions → New repository secret**
- Name: `SURGE_DOMAIN`
- Value: your chosen domain (e.g. `my-project.surge.sh`)

The domain must end in `.surge.sh` unless you have a [custom domain](https://surge.sh/help/adding-a-custom-domain) configured.

## Default workflow name

```
Deploy to Surge
```

## Customization

| What to change | Where to change it |
|----------------|--------------------|
| Deploy domain | Set the `SURGE_DOMAIN` repository secret |
| Source branch | Replace `main` in the `branches` list under `on.push` |
| Build command | Replace `bundle exec jekyll build` in the **Build** step |
| Publish directory | Replace `_site` in the **Deploy to Surge** step with your build output directory |

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

- `SURGE_TOKEN` is passed via `env:` and never echoed in logs.
- The workflow uses minimal permissions (`contents: read`).

## Example usage

See [`examples/example-usage.md`](examples/example-usage.md).
