# Prompt: Add a GitHub Star Button to a Webapp

Use this prompt to instruct an AI agent to add a GitHub star button with a live star count to a web page.

---

Add a GitHub star button to this web page that shows the live star count of the GitHub repository and links visitors to the repository page so they can star it.

Requirements:

- Render an anchor element that links to `https://github.com/{owner}/{repo}` with `target="_blank"` and `rel="noopener noreferrer"`.
- Label the link with a ⭐ star icon and the text **Star** followed by a `<span>` that will hold the count.
- On page load, fetch `https://api.github.com/repos/{owner}/{repo}` (unauthenticated, use `encodeURIComponent` for owner and repo in the URL) and populate the `<span>` with the `stargazers_count` value formatted as `(N)`.
- If the API call fails for any reason (network error, rate limit exceeded, etc.), leave the `<span>` empty and keep the link functional — log the error to the console but do not show an error to the user.
- Use plain JavaScript (no external libraries or frameworks).
- Do not add any CSS. Leave styling to the existing page styles.
- Replace `{owner}` and `{repo}` with the actual repository owner and name.
- Place the snippet at the location in the page where the star button should appear (e.g. header, footer, or sidebar).

Refer to the template at `skills/webapp/github-star-button/templates/github-star-button.html` for a complete working example.
