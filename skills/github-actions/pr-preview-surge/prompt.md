# Prompt: Add PR Preview Deployment with Surge

Use this prompt to instruct an AI agent to add a GitHub Actions workflow that deploys a static site PR preview to Surge.

---

Add a GitHub Actions workflow to this repository that deploys a pull request preview to Surge.

Requirements:

- Trigger on `issue_comment` created events.
- Run only when the comment body is exactly `/preview`.
- Ignore comments that are not on pull requests.
- Validate that the `SURGE_TOKEN` secret exists and is not empty. If it is missing, fail the workflow immediately with a clear explanation of how to create and add the secret.
- Resolve the PR number from the event payload.
- Check out the pull request HEAD commit (not the default branch).
- Install Ruby 3.1, Node.js 20, and Graphviz.
- Build a Jekyll site using `bundle exec jekyll build`. The output directory is `_site`.
- Deploy `_site/` to Surge using the domain: `pr-{PR_NUMBER}-sciam-preview.surge.sh`.
- Read the Surge token from the `SURGE_TOKEN` repository secret.
- Post a success comment on the PR with the deployed preview URL: `https://pr-{PR_NUMBER}-sciam-preview.surge.sh`.
- Post a failure comment on the PR if the deployment fails.
- Add concurrency control scoped to the PR number so repeated `/preview` comments do not create overlapping runs.
- Use minimal permissions: `contents: read` and `pull-requests: write`.
- Keep build steps inline in the workflow. Do not extract steps into composite actions or reusable workflows.
- Prefer clarity and readability over abstraction. Include comments in the YAML to explain key decisions.
- Place the workflow file at `.github/workflows/preview-pr.yml`.

Use these actions:
- `actions/checkout` for checking out the PR branch
- `actions/setup-node` for Node.js
- `ruby/setup-ruby` for Ruby

Refer to the template at `skills/github-actions/pr-preview-surge/templates/preview-pr.yml` for a complete working example.
