# Quartz Documentation Structure

Comprehensive map of Quartz v4 documentation in the `docs/` directory.

## Top-Level Documentation Files

| File | Purpose | Use When |
|------|---------|----------|
| `authoring content.md` | Writing and organizing content | Questions about markdown, frontmatter, organizing files |
| `configuration.md` | Core Quartz config (`quartz.config.ts`) | Modifying site metadata, base URL, locale settings |
| `layout.md` | Page layout configuration | Changing page structure (header, left sidebar, right sidebar) |
| `layout-components.md` | Available layout components | Listing what components can be added to layout |
| `build.md` | Building the site | Build process, output directory questions |
| `hosting.md` | Deployment options | GitHub Pages, Cloudflare, Netlify, Vercel deployment |
| `setting up your GitHub repository.md` | Initial setup | First-time repo setup |
| `upgrading.md` | Version upgrades | Migrating between Quartz versions |

## Features Directory (`docs/features/`)

User-facing features and how to enable/configure them.

### Navigation & Discovery
- `backlinks.md` - Showing pages that link to current page
- `breadcrumbs.md` - Navigation breadcrumbs
- `explorer.md` - File tree explorer sidebar
- `folder and tag listings.md` - Automatic index pages
- `graph view.md` - Interactive knowledge graph
- `full-text search.md` - Search functionality
- `table of contents.md` - On-page TOC

### Content Enhancement
- `callouts.md` - Obsidian-style callout boxes
- `Citations.md` - Academic citations support
- `Latex.md` - Math equations with LaTeX
- `Mermaid diagrams.md` - Flowcharts and diagrams
- `syntax highlighting.md` - Code block highlighting
- `wikilinks.md` - [[wiki-style]] links

### Interactivity
- `comments.md` - Comment systems (Giscus, etc.)
- `popover previews.md` - Hover link previews
- `SPA Routing.md` - Single-page app navigation
- `darkmode.md` - Dark mode toggle

### Publishing & SEO
- `RSS Feed.md` - RSS feed generation
- `social images.md` - Open Graph images
- `private pages.md` - Unpublished content handling

### Compatibility
- `Obsidian compatibility.md` - Obsidian features support
- `Roam Research compatibility.md` - Roam features support
- `OxHugo compatibility.md` - Hugo compatibility

### Other
- `i18n.md` - Internationalization
- `recent notes.md` - Recent notes component
- `reader mode.md` - Distraction-free reading
- `Docker Support.md` - Docker deployment

## Plugins Directory (`docs/plugins/`)

Technical plugin implementations. Each plugin transforms or emits content during build.

### Content Transformation (Transformers)
- `Frontmatter.md` - Process YAML frontmatter
- `CreatedModifiedDate.md` - Add date metadata
- `Description.md` - Generate page descriptions
- `Latex.md` - Transform LaTeX
- `ObsidianFlavoredMarkdown.md` - Obsidian syntax
- `OxHugoFlavoredMarkdown.md` - OxHugo syntax
- `GitHubFlavoredMarkdown.md` - GFM support
- `HardLineBreaks.md` - Line break handling
- `SyntaxHighlighting.md` - Code highlighting
- `TableOfContents.md` - Generate TOC
- `CrawlLinks.md` - Process internal links
- `RemoveDrafts.md` - Filter draft content
- `ExplicitPublish.md` - Require `publish: true`

### Content Generation (Emitters)
- `ContentPage.md` - Generate HTML pages
- `TagPage.md` - Generate tag index pages
- `FolderPage.md` - Generate folder index pages
- `ContentIndex.md` - Generate search index
- `AliasRedirects.md` - Create redirect pages
- `Assets.md` - Copy static assets
- `Static.md` - Copy static files
- `ComponentResources.md` - Bundle component assets
- `CustomOgImages.md` - Generate social images
- `CNAME.md` - GitHub Pages CNAME
- `Favicon.md` - Favicon handling
- `NotFoundPage.md` - 404 page generation

## Advanced Directory (`docs/advanced/`)

Deep dives for developers extending Quartz.

- `architecture.md` - How Quartz works internally
- `creating components.md` - Build custom React components
- `making plugins.md` - Write transformers and emitters
- `paths.md` - Path handling and slug generation

## Common Implementation Questions → Where to Look

| Question | Primary Doc | Supporting Docs |
|----------|-------------|-----------------|
| How to add images? | `authoring content.md` | - |
| Enable backlinks? | `features/backlinks.md` | `configuration.md` |
| Add RSS feed? | `features/RSS Feed.md` | `configuration.md` |
| Modify UI components? | `layout-components.md`, `layout.md` | `advanced/creating components.md` |
| Change site structure? | `layout.md` | `configuration.md` |
| Add dark mode? | `features/darkmode.md` | `configuration.md` |
| Custom 404 page? | `plugins/NotFoundPage.md` | `advanced/creating components.md` |
| Enable search? | `features/full-text search.md` | `plugins/ContentIndex.md` |
| Deploy site? | `hosting.md` | `build.md` |
| Handle unpublished notes? | `features/private pages.md` | `plugins/ExplicitPublish.md` |

## Reading Strategy

1. **Feature questions**: Start in `docs/features/`
2. **Configuration questions**: Check `docs/configuration.md` and `docs/layout.md`
3. **Plugin behavior**: Look in `docs/plugins/`
4. **Custom development**: Explore `docs/advanced/`
5. **Build/deploy**: See `docs/build.md` and `docs/hosting.md`
