## Futures, delays and promises

In order to achieve concurrency in Clojure, we can use 3 tools for that; futures, delays and promises.

### Futures

_futures_ are used to define a task and place it on another thread without requiring the result immediately. Can be created with the `future` macro.

```clojure
(future (Thread/sleep 4000)
        (println "I'll print after 4 seconds"))

(println "I'll print immediately")
```

If you want the result, `future` returns a reference that can be used to request the result. This is called _dereferencing_ the future, and can be done with either the `deref` macro or the `@` reader macro.

```clojure
(let [result (future (println "this prints once") (+ 1 1))]
  (println "deref: " (deref result))
  (println "@: " @result))
```

The future body is cached after the first execution, so that's why it only printed once.

Dereferencing a future will block if it hasn't finished running, to check it is finished, the function `realized?` can be used, like so:

```clojure
(realized? (future (Thread/sleep 9000)))
; => false

(let [f (future)]
  @f
  (realized? f))
; => true
```

### Delays

_delays_ allow the definition of a task without having to execute it or require the result immediately.

```clojure
(def jackson-5-delay
  (delay (let [message "Just call my name and I'll be there"]
            (println "First deref: " message)
            message)))
```

To evaluate it, use either `force` or `deref` to execute the expression.

```clojure
(force jackson-5-delay)
; => "Just call my name and I'll be there"
```


### Promises

_promises_ allow the expression that a result is expected without having to define the task that should produce it or when that task should run.

```clojure
(def my-promise (promise))
(deliver promise1 (+ 3 4))
@my-promise
; => 7
```
