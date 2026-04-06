# Example Usage: pr-preview-surge

## When to use this skill

Use this skill when you want reviewers to be able to trigger a live preview of a pull request without waiting for a full CI pipeline. It is ideal for documentation sites, marketing pages, or any project with a static site output.

## Triggering a preview

Post this comment on any open pull request:

```
/preview
```

The workflow will pick it up, immediately post a "build in progress" comment, build the site from the PR merge ref, deploy it to Surge, and update the comment with the URL.

---

## Sample "in progress" comment

As soon as the workflow starts, it posts:

> ⏳ **Preview build in progress...**
>
> 🔗 [View workflow run](https://github.com/your-org/your-repo/actions/runs/12345678)

---

## Sample success comment

After a successful deployment, the workflow updates the comment to:

> 🚀 **Preview deployed successfully!**
>
> 🌐 Preview: [https://pr-42-sciam-preview.surge.sh](https://pr-42-sciam-preview.surge.sh)

The URL is deterministic: `pr-{PR_NUMBER}-sciam-preview.surge.sh`. Posting `/preview` again on the same PR overwrites the previous deployment.

---

## Sample failure comment — missing SURGE_TOKEN

If `SURGE_TOKEN` is not configured, the workflow fails at the validation step and updates the comment to:

> ❌ **Preview build failed.**
>
> 🔗 [View workflow run](https://github.com/your-org/your-repo/actions/runs/12345678)

The workflow run log will contain:

```
❌ ERROR: SURGE_TOKEN is not set!

SURGE_TOKEN is mandatory to deploy to surge.sh with an account.

To generate a token:
  1. Install surge: npm install -g surge
  2. Login: surge login
  3. Generate token: surge token

Then add the token as a secret in GitHub Actions settings:
  Repository Settings > Secrets and variables > Actions > New repository secret
  Name: SURGE_TOKEN
  Value: <your token from 'surge token' command>
```

---

## Adapting for non-Jekyll sites

Replace the **Build Jekyll site** step in the template with the build command for your stack:

**Hugo:**

```yaml
- name: Build Hugo site
  run: hugo
# Change the deploy step: surge ./_site → surge ./public
```

**Next.js (static export):**

```yaml
- name: Install dependencies
  run: npm ci
- name: Build Next.js site
  run: npm run build
# Change the deploy step: surge ./_site → surge ./out
```

**Vite:**

```yaml
- name: Install dependencies
  run: npm ci
- name: Build site
  run: npm run build
# Change the deploy step: surge ./_site → surge ./dist
```

Also update the `DEPLOY_DOMAIN` variable and remove the Ruby/Graphviz setup steps if they are not needed by your stack.
