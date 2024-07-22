---
title: "Git Reset"
description: "Reset your branch to exactly match the state of a specific commit."
author: "Sushant Vema"
date_created: "2024-07-22T09:33:42"
date: "2024-07-22T09:34:17"
tags: 
  - "technical"
  - "git"
publish: true
---

We use `git reset` to revert to a specific commit in a Git repository. There are a couple of options depending on what you want to achieve: 
  - undoing changes
  - resetting to a previous state.

### Undoing Changes with Revert

If you want to create a new commit that undoes the changes made by a specific commit, you can use `git revert`. This is useful when you want to keep a record of the fact that you've undone a commit.

1. **Find the commit hash**: First, find the hash of the commit you want to revert to. You can do this using `git log`, which shows a history of commits along with their hashes.

   ```bash
   git log
   ```

2. **Revert the commit**: Use `git revert` followed by the commit hash of the commit you want to revert.

   ```bash
   git revert <commit-hash>
   ```

   Replace `<commit-hash>` with the actual hash of the commit you want to revert.

3. **Resolve conflicts (if any)**: Git might prompt you to resolve any conflicts that occur during the revert process. Once conflicts are resolved (if any), Git will create a new commit that undoes the changes introduced by the specified commit.

### Resetting to a Specific Commit

If you want to reset your branch to exactly match the state of a specific commit, you can use `git reset`. This is a more forceful operation and should be used with caution, especially if the commit you're resetting to is not the most recent one.

1. **Find the commit hash**: Again, find the hash of the commit you want to reset to using `git log`.

2. **Reset to the commit**: Use `git reset --hard` followed by the commit hash.

   ```bash
   git reset --hard <commit-hash>
   ```

   Replace `<commit-hash>` with the actual hash of the commit you want to reset to.

   **Warning**: `git reset --hard` will remove any local changes you have that are not committed. Use it carefully to avoid losing work.

### Summary

- **git revert**: Creates a new commit that undoes changes from a specific commit.
  ```bash
  git revert <commit-hash>
  ```

- **git reset --hard**: Resets the current branch to the specified commit, discarding all changes after that commit.
  ```bash
  git reset --hard <commit-hash>
  ```

Choose the method that best fits your situation. If you're unsure, `git revert` is safer because it leaves a record of the undo operation in your commit history.
