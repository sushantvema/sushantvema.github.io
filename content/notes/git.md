---
title: "Big Book of Useful Git Operations"
date_created: 2024-12-24T14:08:15
date: 2024-12-24T14:08:19
publish: true
tags:
  - technical
  - git
author: Sushant Vema
---

# Big Book of Git

> [git](https://git-scm.com/) is a free and open-source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

Amongst version-control systems, git is by far the most used. Almost all open-source projects are developed using Git and GitHub. In enterprise there is more various in version control system usage due to security preferences, etc. This is a resource to keep track of less intuitive git operations I use extremely frequently as a developer.

> [!NOTE]
> My preferred interface for working with git repositories in the command line AND within my text editor is [lazygit - a simple terminal UI for git commands](https://github.com/jesseduffield/lazygit).

## Branch Management

Renaming local branches and synchronizing those changes to a remote repository:
Source: [stackoverflow thread](https://stackoverflow.com/questions/30590083/git-how-to-rename-a-branch-both-local-and-remote)

1. **Rename your local branch:**

   - If you are on the branch you want to rename (`new-name` and `old-name` should be replaced with the strings of the names you intend):

     ```bash
     git branch -m new-name
     ```

   - If you are on a different branch:

     ```bash
     git branch -m old-name new-name
     ```

2. **Delete the `old-name` remote branch and push the `new-name` local branch:**

   ```bash
   git push origin :old-name new-name
   ```

3. **Reset the upstream branch for the `new-name` local branch:**

   - Switch to the branch and then:

     ```bash
     git push origin -u new-name
     ```
