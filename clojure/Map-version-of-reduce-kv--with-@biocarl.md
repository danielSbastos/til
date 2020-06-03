## Map version of reduce-kv (with [@biocarl](https://github.com/biocarl))

Clojure has a `reduce-kv`, but no `map-kv`.

```clojure
(defn map-kv [transducer hash-map]
  (reduce-kv #(conj %1 (transducer %2 %3)) {} hash-map))
```

```clojure
(map-kv #(hash-map %1 (str %2 "♡")) {:garden "", :forest ""})
; => {:garden "♡", :forest "♡"}
```
