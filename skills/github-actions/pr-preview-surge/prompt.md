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
- Install Ruby 3.1, Node.js 20, and Graphviz.
- Build a Jekyll site using `bundle exec jekyll build` with `JEKYLL_ENV: production`. The output directory is `_site`.
- Validate that the `SURGE_TOKEN` secret exists and is not empty after checkout. If it is missing, fail with a clear explanation of how to create and add the secret.
- Deploy `_site/` to Surge using the domain: `pr-{PR_NUMBER}-sciam-preview.surge.sh`, passing the domain and token as explicit flags (`--domain` and `--token`). Store the deployed URL in `DEPLOY_URL`.
- On success, **update** the in-progress comment with the deployed preview URL.
- On failure, **update** the in-progress comment with a link to the failed workflow run.
- Add concurrency control scoped to the PR number so repeated `/preview` comments do not create overlapping runs.
- Use minimal permissions: `contents: read` and `pull-requests: write`.
- Keep build steps inline in the workflow. Do not extract steps into composite actions or reusable workflows.
- Prefer clarity and readability over abstraction. Include comments in the YAML to explain key decisions.
- Place the workflow file at `.github/workflows/preview-pr.yml`.

Use these actions:
- `actions/checkout` for checking out the PR merge ref
- `actions/setup-node` for Node.js
- `ruby/setup-ruby` for Ruby
- `actions/github-script@v7` for posting and updating PR comments

Refer to the template at `skills/github-actions/pr-preview-surge/templates/preview-pr.yml` for a complete working example.
