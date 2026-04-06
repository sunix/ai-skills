# Prompt: Add Surge Deployment on Push to Main

Use this prompt to instruct an AI agent to add a GitHub Actions workflow that deploys a static site to Surge on every push to the `main` branch.

---

Add a GitHub Actions workflow to this repository that deploys a static site to Surge whenever code is pushed to the `main` branch.

Requirements:

- Trigger on `push` events targeting the `main` branch only.
- Check out the repository at the pushed commit using `actions/checkout@v4`.
- Detect the project's build toolchain and install only the dependencies it requires. For example:
  - **Jekyll**: Install Ruby 3.1, Graphviz, and Node.js 20; build with `bundle exec jekyll build` (`JEKYLL_ENV: production`); publish directory is `_site`.
  - **Quarkus Roq / Maven**: Install Java and Maven; build with `mvn package -DskipTests`; publish the generated static output directory.
  - **Node.js (Vite, Next.js, etc.)**: Install Node.js 20; build with `npm ci && npm run build`; publish directory is `dist` or `out`.
  - **Hugo**: Install Hugo; build with `hugo`; publish directory is `public`.
  - If the toolchain cannot be determined, default to Node.js 20 with `npm ci && npm run build`.
- Install the Surge CLI with `npm install -g surge`.
- Validate that both the `SURGE_TOKEN` and `SURGE_DOMAIN` secrets exist and are not empty. If either is missing, fail with a clear explanation of how to create and add the secrets.
- Deploy the build output directory to Surge using the domain from `SURGE_DOMAIN`, passing the domain and token as explicit flags (`--domain` and `--token`).
- Use minimal permissions: `contents: read`.
- Keep build steps inline in the workflow. Do not extract steps into composite actions or reusable workflows.
- Prefer clarity and readability over abstraction. Include comments in the YAML to explain key decisions.
- Name the workflow `Deploy to Surge`.
- Place the workflow file at `.github/workflows/deploy-main.yml`.

Use these actions (as appropriate for the detected toolchain):
- `actions/checkout@v4` for checking out the repository
- `actions/setup-node@v4` for Node.js
- `ruby/setup-ruby@v1` for Ruby (Jekyll only)
- `actions/setup-java@v4` for Java (Quarkus Roq / Maven only)

Refer to the template at `skills/github-actions/push-to-surge/templates/deploy-main.yml` for a complete working example.
