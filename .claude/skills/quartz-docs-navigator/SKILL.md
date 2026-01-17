---
name: quartz-docs-navigator
description: |
  Navigate Quartz v4 documentation to answer implementation questions. Use when user asks about:
  (1) Adding or configuring Quartz features (backlinks, RSS, search, images, etc.)
  (2) Modifying UI components or layout
  (3) Understanding plugins or transformers
  (4) Deployment and build configuration
  (5) Custom component development
  Triggers: "how do I", "add", "enable", "configure", "modify" + Quartz features
---

# Quartz Documentation Navigator

Find the right Quartz docs to answer implementation questions.

## Quick Reference

**First, load the docs map**: Read `references/docs_structure.md` for comprehensive overview.

## Navigation Strategy

### For Feature Questions
**Pattern**: "How do I add/enable [feature]?"

1. Check `references/docs_structure.md` for the feature
2. Read the corresponding `docs/features/[feature].md`
3. Check `docs/configuration.md` for enabling the feature

**Examples**:
- "How do I add backlinks?" → `docs/features/backlinks.md`
- "How do I add an RSS feed?" → `docs/features/RSS Feed.md`
- "How do I enable dark mode?" → `docs/features/darkmode.md`

### For Layout/Component Questions
**Pattern**: "How do I modify/customize [UI element]?"

1. Check `docs/layout.md` for page structure
2. Check `docs/layout-components.md` for available components
3. For custom components: `docs/advanced/creating components.md`

**Examples**:
- "How do I change the sidebar?" → `docs/layout.md`
- "How do I add a custom header?" → `docs/advanced/creating components.md`

### For Content Authoring Questions
**Pattern**: "How do I add/format [content]?"

1. Check `docs/authoring content.md`
2. For specific syntax: `docs/features/[feature].md`

**Examples**:
- "How do I add images?" → `docs/authoring content.md`
- "How do I use callouts?" → `docs/features/callouts.md`
- "How do I add LaTeX?" → `docs/features/Latex.md`

### For Plugin Questions
**Pattern**: "How does [plugin] work?" or "How to configure [plugin]?"

1. Check `docs/plugins/[Plugin].md`
2. For custom plugins: `docs/advanced/making plugins.md`

**Examples**:
- "How does ExplicitPublish work?" → `docs/plugins/ExplicitPublish.md`
- "How to create a custom plugin?" → `docs/advanced/making plugins.md`

### For Build/Deploy Questions
1. Build process: `docs/build.md`
2. Deployment: `docs/hosting.md`
3. Configuration: `docs/configuration.md`

## Common Questions → Docs Mapping

| Question | Primary Doc |
|----------|-------------|
| Add inline images | `docs/authoring content.md` |
| Enable backlinks | `docs/features/backlinks.md` |
| Add RSS feed | `docs/features/RSS Feed.md` |
| Modify UI components | `docs/layout-components.md` + `docs/layout.md` |
| Create custom component | `docs/advanced/creating components.md` |
| Enable search | `docs/features/full-text search.md` |
| Configure site metadata | `docs/configuration.md` |
| Deploy to GitHub Pages | `docs/hosting.md` |
| Handle unpublished notes | `docs/features/private pages.md` |
| Add dark mode toggle | `docs/features/darkmode.md` |
| Enable graph view | `docs/features/graph view.md` |
| Add table of contents | `docs/features/table of contents.md` |

## Workflow

1. **Understand the question** - What is the user trying to implement?
2. **Consult docs map** - Read `references/docs_structure.md` to find relevant docs
3. **Read primary doc** - Load and read the most relevant doc file
4. **Read supporting docs** - If needed, check related docs for configuration/setup
5. **Provide answer** - Synthesize information with code examples if available

## Important Notes

- Docs are in the `docs/` directory of the Quartz repo
- Features require configuration in `quartz.config.ts`
- Layout changes happen in `quartz.layout.ts`
- Most features are opt-in via configuration
- For code examples, prefer reading the actual doc files over invention
