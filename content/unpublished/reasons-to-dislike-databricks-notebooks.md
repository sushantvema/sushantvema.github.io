# All my reasons to dislike Databricks Notebooks

- Have to connect each file (script) to the computer resource one at a time.
- There's no REPL to quickly test logic. "Web terminal is not available on compute with Shared access mode"
- Have to manually %pip install every package
- No tabs or quick navigation through files or across directories
- No process monitoring on the compute like `htop`, `btop` etc
- Notebooks can't access the same packages. There's no pip in doing %pip install -r requirements.txt
- Sometimes the editor freezes and becomes unresponsive to keyboard input after restoring a prior version

