#!/bin/bash
# find-unpublished.sh
# Finds markdown files that should not be published:
# - Files with publish: false in frontmatter
# - Files without a publish attribute in frontmatter
#
# Usage:
#   ./find-unpublished.sh              # List unpublished files
#   ./find-unpublished.sh --gitignore  # Output in .gitignore format
#   ./find-unpublished.sh --skip       # Apply git skip-worktree to files
#   ./find-unpublished.sh --no-skip    # Remove git skip-worktree from files

set -e

CONTENT_DIR="${CONTENT_DIR:-content}"
MODE="${1:-list}"

# Function to check if a file should be published
should_publish() {
    local file="$1"

    # Extract frontmatter (content between first two ---)
    local frontmatter
    frontmatter=$(awk '/^---$/{p++} p==1{print} p==2{exit}' "$file" 2>/dev/null)

    # Check if publish: true exists in frontmatter
    if echo "$frontmatter" | grep -qE '^publish:\s*true\s*$'; then
        return 0  # Should publish (true)
    else
        return 1  # Should not publish (false)
    fi
}

# Find all markdown files and filter
find_unpublished() {
    find "$CONTENT_DIR" -name "*.md" -type f 2>/dev/null | while read -r file; do
        if ! should_publish "$file"; then
            echo "$file"
        fi
    done
}

case "$MODE" in
    --gitignore)
        echo "# Auto-generated: Files without publish: true"
        echo "# Generated on: $(date)"
        find_unpublished | sort
        ;;
    --skip)
        echo "Applying skip-worktree to unpublished files..."
        find_unpublished | while read -r file; do
            if git ls-files --error-unmatch "$file" &>/dev/null; then
                git update-index --skip-worktree "$file"
                echo "  Skipped: $file"
            else
                echo "  Untracked (ignored): $file"
            fi
        done
        echo "Done. Use 'git ls-files -v | grep ^S' to see skipped files."
        ;;
    --no-skip)
        echo "Removing skip-worktree from all content files..."
        find "$CONTENT_DIR" -name "*.md" -type f 2>/dev/null | while read -r file; do
            if git ls-files --error-unmatch "$file" &>/dev/null; then
                git update-index --no-skip-worktree "$file" 2>/dev/null || true
            fi
        done
        echo "Done."
        ;;
    --list|*)
        find_unpublished
        ;;
esac
