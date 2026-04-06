# Example Usage: push-to-surge

## When to use this skill

Use this skill when you want the live version of your static site to be updated automatically on every push to `main`. It is ideal for documentation sites, landing pages, or any project where the `main` branch always represents what should be publicly accessible.

## Setup

1. Generate a `SURGE_TOKEN`:
   ```bash
   npm install -g surge
   surge login
   surge token
   ```

2. Choose a Surge domain (e.g. `my-project.surge.sh`).

3. Add both values as repository secrets:
   - **Repository Settings → Secrets and variables → Actions → New repository secret**
   - `SURGE_TOKEN` → your token
   - `SURGE_DOMAIN` → `my-project.surge.sh`

4. Copy `.github/workflows/deploy-main.yml` from the template into your repository.

5. Push to `main`. The workflow runs automatically.

---

## Sample successful run output

```
✓ SURGE_TOKEN is set
✓ SURGE_DOMAIN is set
   Running   project at /home/runner/work/my-repo/my-repo/_site
             domain   my-project.surge.sh
   Success   - Published to my-project.surge.sh
✅ Deployed to https://my-project.surge.sh
```

---

## Sample failure output — missing secrets

If either secret is not configured, the workflow fails at the validation step:

```
❌ ERROR: The following required secret(s) are not set: SURGE_TOKEN SURGE_DOMAIN

SURGE_TOKEN — authentication token for the Surge account.
  To generate a token:
    1. Install surge: npm install -g surge
    2. Login: surge login
    3. Generate token: surge token

SURGE_DOMAIN — the Surge domain to deploy to (e.g. my-project.surge.sh).

Add both as repository secrets:
  Repository Settings > Secrets and variables > Actions > New repository secret
```

---

## Adapting for non-Jekyll sites

Replace the **Install dependencies** and **Build** steps in the template and update the publish directory in the **Deploy to Surge** step:

**Hugo:**

```yaml
- name: Build Hugo site
  run: hugo
# Change deploy step: surge ./_site → surge ./public
```

**Next.js (static export):**

```yaml
- name: Install dependencies
  run: npm ci
- name: Build Next.js site
  run: npm run build
# Change deploy step: surge ./_site → surge ./out
```

**Vite:**

```yaml
- name: Install dependencies
  run: npm ci
- name: Build site
  run: npm run build
# Change deploy step: surge ./_site → surge ./dist
```

Also remove the Ruby, Graphviz, and Node.js setup steps that are not needed by your stack.
