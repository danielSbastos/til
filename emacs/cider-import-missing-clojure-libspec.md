## Add missing lib in Clojure with Cider

Suppose you write the following code:

```clj
(join " " ["hey" "there"])
```

and sent it to the REPL, an error saying that `join` was not imported will appear, to auto import, just execute

`, r a m` and then from the menu, choose `clojure.string`
