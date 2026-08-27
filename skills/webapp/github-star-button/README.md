# github-star-button

Add a GitHub star button to a webapp that displays the live star count of a repository and links visitors directly to the GitHub page to star it.

## Install it with diderot

[diderot](https://github.com/sunix/diderot) is a package manager for agent skills: it resolves a version constraint, pins what it resolved to by content digest in `diderot.lock`, and installs the same bytes anywhere. From the registry:

```bash
diderot add oci://ghcr.io/sunix/skills/github-star-button --version "^1.0.0"
diderot install
```

Or from this repository, to follow git rather than releases:

```bash
diderot add git+https://github.com/sunix/ai-skills#skills/webapp/github-star-button --version main
diderot install
```

`diderot add` needs a build newer than v0.2.0 ([diderot#34](https://github.com/sunix/diderot/pull/34)). With v0.2.0, declare it in `diderot.yaml` yourself and run `diderot update && diderot install`:

```yaml
skills:
  - name: github-star-button
    source: oci://ghcr.io/sunix/skills/github-star-button
    version: "^1.0.0"      # newest 1.x — or an exact tag, or `latest`
targets: [claude]          # or [agents], for .agents/skills
```

## Purpose

Encourage visitors to star your repository by surfacing the current star count alongside a direct link to the GitHub repo page, updated dynamically on every page load.

## What it does

1. Renders a link to the GitHub repository with a ⭐ icon and the label **Star**.
2. On page load, fetches the repository metadata from the GitHub API.
3. Extracts the `stargazers_count` field and appends it to the button label (e.g. **⭐ Star (42)**).
4. If the API call fails (e.g. rate limit, offline), the button still renders and links correctly — the count is simply omitted.

## Prerequisites

- A web page that loads in a browser (plain HTML, React, Vue, Jekyll, Hugo, etc.).
- The repository must be **public** so that unauthenticated GitHub API requests work without a token.

## No secrets required

The snippet calls the unauthenticated GitHub REST API endpoint:

```
https://api.github.com/repos/{owner}/{repo}
```

Unauthenticated requests are rate-limited to 60 per hour per IP. For most public sites this is sufficient.

For high-traffic sites that may approach this limit, consider:

- **Caching on the server side** — proxy the GitHub API response and cache it for several minutes.
- **Using an authenticated request** — pass a `Authorization: Bearer {token}` header with a GitHub personal access token (read-only scope is sufficient) to raise the limit to 5,000 requests per hour. Store the token server-side; never embed it in client-side JavaScript.

When the rate limit is exceeded, the API returns HTTP 403. The snippet handles this gracefully: the star count is omitted and the link to the GitHub repo continues to work normally.

## Customization

| What to change | Where to change it |
|----------------|--------------------|
| Repository owner | Replace `OWNER` in both the `href` and the JavaScript variable |
| Repository name | Replace `REPO` in both the `href` and the JavaScript variable |
| Button text | Replace `⭐ Star` inside the `<a>` tag |
| Star count element | Replace `github-star-count` with any `id` unique on the page |
| Link element | Replace `github-star-link` with any `id` unique on the page |

## Styling

The snippet ships with no CSS. Apply your own styles to `#github-star-link` and `#github-star-count`:

```css
/* Example */
#github-star-link {
  display: inline-flex;
  align-items: center;
  gap: 0.25rem;
  text-decoration: none;
}

/* Hide the count on small screens */
@media (max-width: 640px) {
  #github-star-count {
    display: none;
  }
}
```

## Example usage

See [`examples/example-usage.md`](examples/example-usage.md).
