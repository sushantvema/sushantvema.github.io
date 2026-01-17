---
name: quartz-note-creator
description: |
  Create new Quartz notes with proper YAML frontmatter. Use when:
  (1) User wants to create a new note in content/notes/
  (2) User specifies a topic/title for a new note
  (3) User says "create a note about..." or "make a new note for..."
  (4) User wants to draft content with proper frontmatter
  Automatically adds author (Sushant Vema), timestamps (ISO format), and handles publish flag.
---

# Quartz Note Creator

Create new notes in `content/notes/` with proper Quartz frontmatter.

## Usage

Use the `scripts/create_note.py` script:

```bash
python3 scripts/create_note.py "Note Title" [options]
```

**Options:**
- `-d`, `--description`: Note description
- `-p`, `--publish`: Set `publish: true` (default: false)
- `-t`, `--tags`: Space-separated tags
- `-o`, `--output`: Output directory (default: content/notes/)

## Examples

**Basic unpublished note:**
```bash
python3 scripts/create_note.py "Machine Learning Basics"
```

**Published note with description and tags:**
```bash
python3 scripts/create_note.py "Kubernetes Guide" \
  -d "Notes on k8s deployment" \
  --publish \
  -t devops kubernetes cloud
```

**Draft note:**
```bash
python3 scripts/create_note.py "Weekend Plans" -t personal
```

## Generated Frontmatter

```yaml
---
title: "Note Title"
description: "Optional description"
author: "Sushant Vema"
date_created: 2026-01-17T11:14:47
date: 2026-01-17T11:14:47
publish: false
tags:
  - "tag1"
  - "tag2"
---
```

## Field Descriptions

| Field | Value | Notes |
|-------|-------|-------|
| `title` | User-provided | Required |
| `description` | User-provided | Optional |
| `author` | "Sushant Vema" | Always set |
| `date_created` | ISO timestamp | Auto-generated |
| `date` | ISO timestamp | Auto-generated |
| `publish` | true/false | Default: false |
| `tags` | List | Optional |

## Filename Generation

- Title is slugified (lowercase, dashes instead of spaces)
- Example: "Machine Learning Basics" → `machine-learning-basics.md`
- Placed in `content/notes/` by default
