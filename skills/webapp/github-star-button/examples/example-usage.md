# Example Usage: github-star-button

## When to use this skill

Use this skill when you want visitors to your site to be able to star the backing GitHub repository directly from the page, with the current star count displayed as social proof.

## Setup

1. Open the HTML file where the button should appear (e.g. `index.html`, a layout file, or a Liquid/Nunjucks/Thymeleaf template).

2. Copy the snippet from `templates/github-star-button.html` into the desired location in the page.

3. Replace `OWNER` and `REPO` in the snippet with the actual repository owner and name.

4. Save and reload the page.

---

## Minimal standalone example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>My Project</title>
  </head>
  <body>
    <header>
      <nav>
        <a href="/">Home</a>

        <!-- GitHub Star Button -->
        <a
          id="github-star-link"
          href="https://github.com/acme/my-project"
          target="_blank"
          rel="noopener noreferrer"
          aria-label="Star on GitHub"
        >
          ⭐ Star <span id="github-star-count" aria-live="polite"></span>
        </a>

        <script>
          (function () {
            var OWNER = "acme";
            var REPO = "my-project";

            fetch("https://api.github.com/repos/" + encodeURIComponent(OWNER) + "/" + encodeURIComponent(REPO))
              .then(function (response) {
                if (!response.ok) {
                  throw new Error("GitHub API error: " + response.status);
                }
                return response.json();
              })
              .then(function (data) {
                var count = data.stargazers_count;
                var el = document.getElementById("github-star-count");
                if (el && typeof count === "number") {
                  el.textContent = "(" + count + ")";
                }
              })
              .catch(function (err) {
                // Fail silently — the link still works without the count.
                console.error("github-star-button: failed to fetch star count", err);
              });
          })();
        </script>
      </nav>
    </header>
  </body>
</html>
```

---

## Sample rendered output

When the GitHub API returns a star count of 42, the button renders as:

```
⭐ Star (42)
```

When the API call fails (e.g. network error or rate limit), the button renders as:

```
⭐ Star
```

The link to the GitHub repo remains functional in both cases.

---

## Styling example

To hide the star count on mobile and style the button as a pill badge:

```css
#github-star-link {
  display: inline-flex;
  align-items: center;
  gap: 0.25rem;
  padding: 0.25rem 0.5rem;
  border: 1px solid currentColor;
  border-radius: 0.25rem;
  text-decoration: none;
  font-size: 0.875rem;
}

@media (max-width: 640px) {
  #github-star-count {
    display: none;
  }
}
```
