---
name: github-star-button
description: Add a GitHub star button with a live star count to a web page, using plain JavaScript and the public GitHub API. Use when the user wants to display a repository's star count or a "Star on GitHub" link/badge on a website.
---

# GitHub star button with live count

Add a star button to the current web page that shows the live GitHub star count and links visitors to the repository.

Copy the snippet from [templates/github-star-button.html](templates/github-star-button.html) into the page where the button should appear (header, footer, or sidebar), replacing `{owner}` and `{repo}`:

- An anchor to `https://github.com/{owner}/{repo}` with `target="_blank"` and `rel="noopener noreferrer"`, labeled with a ⭐ icon, the text **Star**, and a `<span>` for the count.
- On page load, fetch `https://api.github.com/repos/{owner}/{repo}` (unauthenticated, `encodeURIComponent` on both parts) and fill the `<span>` with `stargazers_count` formatted as `(N)`.
- On any API failure (network, rate limit), leave the count empty and keep the link functional — log to console, show nothing to the user.
- Plain JavaScript only, no libraries, no CSS (inherit the page's styles).

Full requirements list: [prompt.md](prompt.md). Human documentation: [README.md](README.md).
