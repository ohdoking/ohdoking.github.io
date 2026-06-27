# Dokeun Oh github page

## Content updates

This site uses a static content workflow. Put raw Notion exports in `content/raw/notion/`, refine public content into `_data/*.yml` and `_posts/*.md`, then build the Jekyll site locally before committing.

See `content/README.md` for the full workflow.

## Local preview

```sh
bundle install --path vendor/bundle
bundle exec jekyll serve --config _config.yml,_config-dev.yml
```

Before publishing, place the resume PDF at `assets/resume/resume_dokeun.pdf` or disable the resume link in `_config.yml`.
