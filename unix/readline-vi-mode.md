## Readline vi mode

The default readline mode is set to emacs, which means that some commands from it can be used, such as Ctrl-a to move to the beggining of the line, Ctrl-e, to go to the end, Ctrl-u to delete everything before the line (in zsh it actually deletes the whole line)

However, readline GNU is just any other program, and we could also alter the default mode from emacs to vi, and vice-versa. 

Using vi mode means that the majority of vi commands can be used in readline, see all of them [here](https://catonmat.net/ftp/bash-vi-editing-mode-cheat-sheet.txt). This [blogpost](https://catonmat.net/bash-vi-editing-mode-cheat-sheet) is also great.

```bash
set -o vi
set -o emacs
```
