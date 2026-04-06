# Example Usage: pr-preview-surge

## When to use this skill

Use this skill when you want reviewers to be able to trigger a live preview of a pull request without waiting for a full CI pipeline. It is ideal for documentation sites, marketing pages, or any project with a static site output.

## Triggering a preview

Post this comment on any open pull request:

```
/preview
```

The workflow will pick it up, build the site from the PR branch, deploy it to Surge, and reply with the URL.

---

## Sample success comment

After a successful deployment, the workflow posts:

> 🚀 Preview deployed to **https://pr-42-sciam-preview.surge.sh**

The URL is deterministic: `pr-{PR_NUMBER}-sciam-preview.surge.sh`. Posting `/preview` again on the same PR overwrites the previous deployment.

---

## Sample failure comment — missing SURGE_TOKEN

If `SURGE_TOKEN` is not configured, the workflow fails at the validation step and posts:

> ❌ Preview deployment failed. Check the [workflow run](https://github.com/your-org/your-repo/actions/runs/12345678) for details.

The workflow run log will contain:

```
::error::SURGE_TOKEN secret is not configured.
::error::To fix this:
::error::  1. Install Surge: npm install -g surge
::error::  2. Log in:        surge login
::error::  3. Get a token:   surge token
::error::  4. Add it to:     Repository Settings > Secrets and variables > Actions > New repository secret
::error::     Name: SURGE_TOKEN
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

Also update the `SURGE_DOMAIN` variable and remove the Ruby/Graphviz setup steps if they are not needed by your stack.
