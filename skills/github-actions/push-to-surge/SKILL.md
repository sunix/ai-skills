---
name: push-to-surge
description: Add a GitHub Actions workflow that deploys a static site (Jekyll, Hugo, Vite, Next.js, Quarkus Roq...) to Surge on every push to the main branch. Use when the user wants continuous deployment of a static site to Surge or a surge.sh URL updated on each push.
---

# Deploy to Surge on push to main

Add a GitHub Actions workflow to the current repository that deploys a static site to Surge whenever code is pushed to the `main` branch.

Copy [templates/deploy-main.yml](templates/deploy-main.yml) to `.github/workflows/deploy-main.yml` in the target repository, then adapt it:

- Detect the project's build toolchain and keep only the setup/build steps it requires:
  - **Jekyll**: Ruby 3.1, Graphviz, Node.js 20; build with `bundle exec jekyll build` (`JEKYLL_ENV: production`); publish `_site`.
  - **Quarkus Roq / Maven**: Java + Maven; build with `mvn package -DskipTests`; publish the generated static output directory.
  - **Node.js (Vite, Next.js, etc.)**: Node.js 20; `npm ci && npm run build`; publish `dist` or `out`.
  - **Hugo**: build with `hugo`; publish `public`.
  - Unknown toolchain: default to Node.js 20 with `npm ci && npm run build`.
- Keep the validation step that checks `SURGE_TOKEN` and `SURGE_DOMAIN` secrets exist, failing with instructions on how to create them (see [README.md](README.md) for the token generation steps to include).
- Deploy with explicit `--domain` and `--token` flags; minimal permissions (`contents: read`); build steps inline, no composite actions.

Full requirements list: [prompt.md](prompt.md). Human documentation and customization table: [README.md](README.md).
