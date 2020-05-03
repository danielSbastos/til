## `comp` function

Takes a set of functions and returns a fn that is the composition
of those fns.

```clojure
user=> (defn f [x] (+ x 1))
#'user/f
user=> (defn g [x] (+ x 2))
#'user/g
user=> ((comp f g) 1)
4
```

[source](https://clojuredocs.org/clojure.core/comp)

### Handmade

```clojure
(defn my-comp
  ([] identity)
  ([f] f)
  ([f g] (fn [& args] (f (apply g args))))
  ([f g & args] (reduce my-comp (list* f g args))))
```
