#!/bin/bash
# purge-unpublished-from-history.sh
# Removes all unpublished files from git history
#
# WARNING: This rewrites git history!
# - All commit hashes will change
# - You must force-push after running this
# - Anyone with a clone will need to re-clone
#
# Usage:
#   ./purge-unpublished-from-history.sh           # Dry run (preview)
#   ./purge-unpublished-from-history.sh --apply   # Actually purge

set -e
cd "$(dirname "$0")"

# Check for git-filter-repo
if ! command -v git-filter-repo &> /dev/null; then
    echo "ERROR: git-filter-repo is not installed"
    echo ""
    echo "Install it with:"
    echo "  brew install git-filter-repo"
    echo ""
    exit 1
fi

# Generate list of unpublished files
echo "Finding unpublished files..."
TEMP_FILE=$(mktemp)
./find-unpublished.sh > "$TEMP_FILE"
FILE_COUNT=$(wc -l < "$TEMP_FILE" | tr -d ' ')

echo "Found $FILE_COUNT files without 'publish: true'"
echo ""

if [ "$1" != "--apply" ]; then
    echo "=== DRY RUN MODE ==="
    echo ""
    echo "Files that would be removed from history:"
    echo "----------------------------------------"
    cat "$TEMP_FILE"
    echo ""
    echo "----------------------------------------"
    echo ""
    echo "To actually purge these files, run:"
    echo "  ./purge-unpublished-from-history.sh --apply"
    echo ""
    echo "BEFORE RUNNING:"
    echo "  1. Make a backup: cp -r ../quartz ../quartz-backup"
    echo "  2. Ensure you can force-push to your remote"
    echo ""
    rm "$TEMP_FILE"
    exit 0
fi

# Confirm
echo "WARNING: This will permanently rewrite git history!"
echo ""
read -p "Have you made a backup? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "Aborting. Please backup first: cp -r ../quartz ../quartz-backup"
    rm "$TEMP_FILE"
    exit 1
fi

echo ""
echo "Starting purge..."
echo ""

# Convert file list to paths-from-file format for git-filter-repo
# git-filter-repo uses --invert-paths with --paths-from-file to remove files
PATHS_FILE=$(mktemp)
cat "$TEMP_FILE" > "$PATHS_FILE"

# Run git-filter-repo
git filter-repo --invert-paths --paths-from-file "$PATHS_FILE" --force

# Cleanup
rm "$TEMP_FILE" "$PATHS_FILE"

echo ""
echo "=== PURGE COMPLETE ==="
echo ""
echo "Next steps:"
echo "  1. Verify the repo looks correct"
echo "  2. Force push to remote:"
echo "     git push origin --force --all"
echo "     git push origin --force --tags"
echo ""
echo "  3. Anyone with a clone must re-clone or run:"
echo "     git fetch origin"
echo "     git reset --hard origin/v4"
echo ""
