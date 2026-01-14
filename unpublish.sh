#!/bin/bash
# unpublish.sh
# Removes tracked files without 'publish: true' from git (keeps local files)
#
# Usage:
#   ./unpublish.sh              # Preview what would be removed
#   ./unpublish.sh --apply      # Remove from git and update .gitignore

set -e
cd "$(dirname "$0")"

# Check if a file should be published
should_publish() {
    local file="$1"
    local frontmatter
    frontmatter=$(awk '/^---$/{p++} p==1{print} p==2{exit}' "$file" 2>/dev/null)
    echo "$frontmatter" | grep -qE '^publish:\s*true\s*$'
}

# Find tracked markdown files that shouldn't be published
find_tracked_unpublished() {
    git ls-files 'content/*.md' 'content/**/*.md' 2>/dev/null | while read -r file; do
        if [ -f "$file" ] && ! should_publish "$file"; then
            echo "$file"
        fi
    done
}

echo "Scanning for tracked files without 'publish: true'..."
echo ""

tracked_unpublished=$(find_tracked_unpublished)

if [ -z "$tracked_unpublished" ]; then
    echo "No tracked unpublished files found. You're all set!"
    exit 0
fi

count=$(echo "$tracked_unpublished" | wc -l | tr -d ' ')
echo "Found $count tracked file(s) that should be unpublished:"
echo "--------------------------------------------------------"
echo "$tracked_unpublished"
echo ""

if [ "$1" != "--apply" ]; then
    echo "To remove these from git (keeps local files), run:"
    echo "  ./unpublish.sh --apply"
    exit 0
fi

# Apply changes
echo "Removing from git tracking..."
echo "$tracked_unpublished" | while read -r file; do
    if [ -n "$file" ]; then
        echo "  git rm --cached: $file"
        git rm --cached "$file" >/dev/null 2>&1
    fi
done

echo ""
echo "Updating .git/info/exclude..."
./update-gitignore.sh --apply

echo ""
echo "Done! Changes staged. To complete, run:"
echo "  npx quartz sync"
echo ""
