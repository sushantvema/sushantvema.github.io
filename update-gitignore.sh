#!/bin/bash
# update-gitignore.sh
# Updates .git/info/exclude with unpublished markdown files (local only, not pushed)
#
# Usage:
#   ./update-gitignore.sh          # Preview changes
#   ./update-gitignore.sh --apply  # Apply changes to .git/info/exclude

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXCLUDE_FILE="$SCRIPT_DIR/.git/info/exclude"
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

# Remove existing auto-generated block from exclude file
remove_existing_block() {
    if [ -f "$EXCLUDE_FILE" ]; then
        sed "/$MARKER_START/,/$MARKER_END/d" "$EXCLUDE_FILE"
    fi
}

if [ "$1" = "--apply" ]; then
    echo "Updating .git/info/exclude..."

    # Ensure .git/info directory exists
    mkdir -p "$(dirname "$EXCLUDE_FILE")"

    # Create new exclude content
    {
        remove_existing_block
        echo ""
        generate_block
    } > "$EXCLUDE_FILE.tmp"

    mv "$EXCLUDE_FILE.tmp" "$EXCLUDE_FILE"

    # Count files added
    count=$(get_unpublished | wc -l | tr -d ' ')
    echo "Added $count unpublished files to .git/info/exclude"
    echo "Done."
else
    echo "Preview of files that would be added to .git/info/exclude:"
    echo "=========================================================="
    generate_block
    echo ""
    echo "Run with --apply to update .git/info/exclude"
fi
