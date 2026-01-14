#!/bin/bash
# update-gitignore.sh
# Updates .gitignore with unpublished markdown files
#
# Usage:
#   ./update-gitignore.sh          # Preview changes
#   ./update-gitignore.sh --apply  # Apply changes to .gitignore

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GITIGNORE="$SCRIPT_DIR/.gitignore"
MARKER_START="# BEGIN AUTO-GENERATED UNPUBLISHED FILES"
MARKER_END="# END AUTO-GENERATED UNPUBLISHED FILES"

# Get list of unpublished files
get_unpublished() {
    "$SCRIPT_DIR/find-unpublished.sh" --list | sort
}

# Generate the block to insert
generate_block() {
    echo "$MARKER_START"
    echo "# Generated on: $(date)"
    echo "# Files without 'publish: true' in frontmatter"
    get_unpublished
    echo "$MARKER_END"
}

# Remove existing auto-generated block from .gitignore
remove_existing_block() {
    if [ -f "$GITIGNORE" ]; then
        sed "/$MARKER_START/,/$MARKER_END/d" "$GITIGNORE"
    fi
}

if [ "$1" = "--apply" ]; then
    echo "Updating .gitignore..."

    # Create new .gitignore content
    {
        remove_existing_block
        echo ""
        generate_block
    } > "$GITIGNORE.tmp"

    mv "$GITIGNORE.tmp" "$GITIGNORE"

    # Count files added
    count=$(get_unpublished | wc -l | tr -d ' ')
    echo "Added $count unpublished files to .gitignore"
    echo "Done. Review with: git diff .gitignore"
else
    echo "Preview of files that would be added to .gitignore:"
    echo "=================================================="
    generate_block
    echo ""
    echo "Run with --apply to update .gitignore"
fi
