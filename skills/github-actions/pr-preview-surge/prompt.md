# Prompt: Add PR Preview Deployment with Surge

Use this prompt to instruct an AI agent to add a GitHub Actions workflow that deploys a static site PR preview to Surge.

---

Add a GitHub Actions workflow to this repository that deploys a pull request preview to Surge.

Requirements:

- Trigger on `issue_comment` created events.
- Run only when the comment body contains `/preview` and the comment is on a pull request (not a plain issue).
- Resolve the PR number from the event payload and validate that it is numeric.
- Post an "in progress" comment on the PR immediately, capturing the comment ID so it can be updated later.
- Check out the PR merge ref (`refs/pull/{PR_NUMBER}/merge`) so the preview reflects the merged state.
- Detect the project's build toolchain and install only the dependencies it requires. For example:
  - **Jekyll**: Install Ruby 3.1, Graphviz, and Node.js 20; build with `bundle exec jekyll build` (`JEKYLL_ENV: production`); publish directory is `_site`.
  - **Quarkus Roq / Maven**: Install Java and Maven; build with `mvn package -DskipTests`; publish the generated static output directory.
  - **Node.js (Vite, Next.js, etc.)**: Install Node.js 20; build with `npm ci && npm run build`; publish directory is `dist` or `out`.
  - **Hugo**: Install Hugo; build with `hugo`; publish directory is `public`.
  - If the toolchain cannot be determined, default to Node.js 20 with `npm ci && npm run build`.
- Validate that the `SURGE_TOKEN` secret exists and is not empty after checkout. If it is missing, fail with a clear explanation of how to create and add the secret.
- Deploy the build output directory to Surge using the domain: `pr-{PR_NUMBER}-sciam-preview.surge.sh`, passing the domain and token as explicit flags (`--domain` and `--token`). Store the deployed URL in `DEPLOY_URL`.
- On success, **update** the in-progress comment with the deployed preview URL.
- On failure, **update** the in-progress comment with a link to the failed workflow run.
- Add concurrency control scoped to the PR number so repeated `/preview` comments do not create overlapping runs.
- Use minimal permissions: `contents: read` and `pull-requests: write`.
- Keep build steps inline in the workflow. Do not extract steps into composite actions or reusable workflows.
- Prefer clarity and readability over abstraction. Include comments in the YAML to explain key decisions.
- Place the workflow file at `.github/workflows/preview-pr.yml`.

Use these actions (as appropriate for the detected toolchain):
- `actions/checkout` for checking out the PR merge ref
- `actions/setup-node` for Node.js
- `ruby/setup-ruby` for Ruby (Jekyll only)
- `actions/setup-java` for Java (Quarkus Roq / Maven only)
- `actions/github-script@v7` for posting and updating PR comments

Refer to the template at `skills/github-actions/pr-preview-surge/templates/preview-pr.yml` for a complete working example.
