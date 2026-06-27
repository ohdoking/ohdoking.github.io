# Notion Media Curation

Raw Notion export media was reviewed separately from Markdown content because image-heavy notes can include private screenshots, copied course material, or third-party diagrams.

## Raw Media Counts

- Study media files reviewed: 2,291 image files from Programming, AI, and Project.
- File types: 2,266 PNG, 24 JPEG, 1 GIF.
- Most files are exported with generic names such as `Untitled.png` or `image.png`, so visual inspection is required before publishing.

## Published Media

- Added 2 GraphQL diagrams from the original Programming/GraphQL note.
- Published paths:
  - `/assets/images/study/graphql/rest-vs-graphql-flow.png`
  - `/assets/images/study/graphql/graphql-resolver-flow.png`
- Updated `_posts/2024-10-15-graphql-for-backend-developers.md` with both diagrams and short explanatory context.

## Excluded From This Pass

- RAG and local LLM meetup images: useful as references, but many appear to be third-party course or blog diagrams.
- PostgreSQL redundancy images: useful technically, but several appear sourced from external tutorials.
- MS AI Agents Hackathon images: mostly official Microsoft/event slides.
- Kaggle capstone image: external event slide.
- AI Search hackathon images: third-party product screenshots.
- 2026 Berlin hackathon images: potentially strong project material, but the surrounding note is private/future ideation and should be reviewed manually before publishing.
- AI lecture images such as GAN, Autoencoder, Cross Entropy, and Word2Vec: useful for study, but likely copied learning material unless recreated as original diagrams.

## Strong Image Potential

- Recreate original diagrams for RAG, vector search, PostgreSQL replication, transaction isolation, and sharding instead of publishing copied screenshots.
- Publish project screenshots only when they show your own demo, architecture, notebook, UI, or generated result without secrets or private collaboration details.
- Use raw screenshots as source material for rewriting content, not as automatic public assets.
