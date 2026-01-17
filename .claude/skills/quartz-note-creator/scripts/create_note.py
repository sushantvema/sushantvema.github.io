#!/usr/bin/env python3
"""Create a new Quartz note with proper frontmatter."""

import argparse
import os
import re
from datetime import datetime
from pathlib import Path


def slugify(text):
    """Convert text to a URL-friendly slug."""
    text = text.lower()
    text = re.sub(r'[^\w\s-]', '', text)
    text = re.sub(r'[-\s]+', '-', text)
    return text.strip('-')


def create_note(title, description=None, publish=False, tags=None, output_dir=None):
    """Create a new Quartz note with frontmatter.

    Args:
        title: Note title
        description: Optional description
        publish: Whether to publish (default: False)
        tags: Optional list of tags
        output_dir: Output directory (default: content/notes/)

    Returns:
        Path to created file
    """
    # Default output directory
    if output_dir is None:
        # Try to find content/notes from current directory
        repo_root = Path.cwd()
        while repo_root != repo_root.parent:
            content_notes = repo_root / "content" / "notes"
            if content_notes.exists():
                output_dir = content_notes
                break
            repo_root = repo_root.parent
        else:
            output_dir = Path("content/notes")
    else:
        output_dir = Path(output_dir)

    # Ensure output directory exists
    output_dir.mkdir(parents=True, exist_ok=True)

    # Generate filename from title
    filename = slugify(title) + ".md"
    filepath = output_dir / filename

    # Check if file exists
    if filepath.exists():
        print(f"Warning: {filepath} already exists. Overwriting.")

    # Generate timestamps in ISO format
    now = datetime.now().isoformat(timespec='seconds')

    # Build frontmatter
    frontmatter = ["---"]
    frontmatter.append(f'title: "{title}"')

    if description:
        frontmatter.append(f'description: "{description}"')

    frontmatter.append('author: "Sushant Vema"')
    frontmatter.append(f'date_created: {now}')
    frontmatter.append(f'date: {now}')
    frontmatter.append(f'publish: {"true" if publish else "false"}')

    if tags:
        frontmatter.append('tags:')
        for tag in tags:
            frontmatter.append(f'  - "{tag}"')

    frontmatter.append("---")
    frontmatter.append("")  # Empty line after frontmatter

    # Write file
    with open(filepath, 'w') as f:
        f.write('\n'.join(frontmatter))

    return filepath


def main():
    parser = argparse.ArgumentParser(description='Create a new Quartz note')
    parser.add_argument('title', help='Note title')
    parser.add_argument('-d', '--description', help='Note description')
    parser.add_argument('-p', '--publish', action='store_true', help='Set publish: true')
    parser.add_argument('-t', '--tags', nargs='+', help='Tags for the note')
    parser.add_argument('-o', '--output', help='Output directory (default: content/notes/)')

    args = parser.parse_args()

    filepath = create_note(
        title=args.title,
        description=args.description,
        publish=args.publish,
        tags=args.tags,
        output_dir=args.output
    )

    print(f"Created: {filepath}")


if __name__ == '__main__':
    main()
