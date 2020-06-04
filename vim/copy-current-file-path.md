## Copy current file path

We can use the read-only register `"%` to fetch the current file path where vim was started and the clipboard register, `"+`.

So, type in `:let @+=@%`, which means, copy the current file path to the clipboard.
