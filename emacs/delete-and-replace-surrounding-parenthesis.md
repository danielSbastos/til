## Replace and delete surrounding parenthesis

If you are using evil mode, then this will work. It uses the [`evil-surround`](https://github.com/emacs-evil/evil-surround) package.

### Delete surrounding

Given the following expression in Clojure (which will fail)

```clojure
(+ ((- 10 9)) 9)
```
to fix it by removing the surrounding parenthesis, just type

`ds<text-object>` which in our case `ds(` which the cursor on visual mode inside the parenthesis to delete, which results in

```clojure
(+ (- 10 9) 9)
```

### Replace surrounding

```clojure
(+ ((- 10 9)) 9)
```
to replece the parenthesis to curly bracket, just type

`cs<old-textobject><new-textobject>` which in our case `cs({` which the cursor on visual mode inside the parenthesis to change, which results in

```clojure
(+ {- 10 9} 9) ;; this doesn't make sense but it is just for the sake of exemplifying
```

