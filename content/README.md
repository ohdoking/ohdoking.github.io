# Content Workflow

This site is intentionally static. Use this folder as a working area when you want to refresh the portfolio or blog from Notion, LinkedIn, or resume content.

## Workflow

1. Export Notion content as Markdown/CSV.
2. Put the raw export under `content/raw/notion/`.
3. Refine the content for public readability under `content/refined/`.
4. Move final portfolio data into `_data/*.yml`.
5. Move final blog posts into `_posts/YYYY-MM-DD-slug.md`.
6. Build and review the site locally.
7. Commit and push the branch.

## LinkedIn

LinkedIn is treated as a public profile link, not as an automated data source. Update the LinkedIn profile itself, then copy any career or profile text you want to publish into the refined content or `_data` files.

## Resume

Place the public resume PDF at:

```text
assets/resume/dokeun-oh-resume.pdf
```

The site config points the resume link to that local file.
