---
title: Useful Bash Commands
date_created: 2025-02-24T18:46:05
date: 2025-02-24T18:46:07
tags:
  - productivity
  - command-line
author: Sushant Vema
publish: true
---

There are many useful **Bash readline** shortcuts that can speed up your command-line workflow. Here are some of the most useful ones I use, grouped by category:

### **Editing Commands**

- `Ctrl + w` → Delete the word before the cursor
- `Ctrl + u` → Delete everything before the cursor
- `Ctrl + k` → Delete everything after the cursor
- `Ctrl + y` → Paste (yank) the last deleted text
- `Alt + d` → Delete the word after the cursor
- `Alt + Backspace` → Delete the word before the cursor (like `Ctrl + w`, but stops at punctuation)
- `Ctrl + l` → Clear the terminal screen (like `clear`)

### **Cursor Movement**

- `Ctrl + a` → Move cursor to the beginning of the line
- `Ctrl + e` → Move cursor to the end of the line
- `Alt + f` → Move forward one word
- `Alt + b` → Move backward one word
- `Ctrl + f` → Move forward one character
- `Ctrl + b` → Move backward one character

### **History & Navigation**

- `Ctrl + r` → Search command history (type to search, press `Ctrl + r` again for next match)
- `Ctrl + g` → Cancel history search
- `Up/Down Arrow` → Browse command history
- `Ctrl + p` → Previous command (same as Up Arrow)
- `Ctrl + n` → Next command (same as Down Arrow)
- `!!` → Re-run the last command
- `!<n>` → Run command number `<n>` from history (`history` command lists them)
- `!<prefix>` → Run the most recent command that starts with `<prefix>`

### **Process Management**

- `Ctrl + c` → Cancel the current command
- `Ctrl + z` → Suspend (pause) the current process (can be resumed with `fg`)
- `fg` → Resume a suspended process in the foreground
- `bg` → Resume a suspended process in the background

### **Miscellaneous**

- `Ctrl + x Ctrl + e` → Open the current command in your default editor (`$EDITOR`)
- `Ctrl + s` → Freeze terminal output (resume with `Ctrl + q`)
- `Ctrl + d` → Send EOF (End-of-File) signal, often used to exit a terminal session
