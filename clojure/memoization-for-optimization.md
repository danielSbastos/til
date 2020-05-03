## Memoization for optimization

> Memoization takes advantage of referential transparency by storing the arguments passed to a function and the return value of the function. - Clojure for the Brave and True, page 106

This technique can optimize algorithms, and transform that slow recursion to a "fast" one.

Let's take the fibonnacci algorithm using recursion with no memoization (snippet from [clojure docs](https://clojuredocs.org/clojure.core/memoize#example-5530eceee4b01bb732af0a83)

```clojure
(defn fib [n]
  (condp = n
    0 1
    1 1
    (+ (fib (dec n)) (fib (- n 2)))))
    
(time (fib 30))
;; "Elapsed time: 56.13118 msecs"
```

and now let's memoize it

```clojure
(def m-fib
  (memoize (fn [n]
             (condp = n
               0 1
               1 1
               (+ (m-fib (dec n)) (m-fib (- n 2)))))))

(time (m-fib 30))
;; "Elapsed time: 0.421574 msecs"
```

Clojure's memoization function stores the arguments and return values in a map, `{}`. For each function call, it checks it the key is already set, if yes, it uses the value and does not compute it, if not, it computes and stores the result for future calls.

Source code of [`memoize`](https://github.com/clojure/clojure/blob/f9b04ae5f7fd9f11ea7a431675f4ec2d23f295f5/src/clj/clojure/core.clj#L6345-L6359)

```clojure
(defn memoize
  "Returns a memoized version of a referentially transparent function. The
  memoized version of the function keeps a cache of the mapping from arguments
  to results and, when calls with the same arguments are repeated often, has
  higher performance at the expense of higher memory use."
  {:added "1.0"
   :static true}
  [f]
  (let [mem (atom {})]
    (fn [& args]
      (if-let [e (find @mem args)]
        (val e)
        (let [ret (apply f args)]
          (swap! mem assoc args ret)
          ret)))))
```

we can add a print statement to check how the args and values are stored:


```clojure
(defn my-memoize
  [f]
  (let [mem (atom {})]
    (fn [& args]
      (if-let [e (find @mem args)]
        (val e)
        (let [ret (apply f args)]
          (println args @mem)
          (swap! mem assoc args ret)
          ret)))))

(def m-fib
  (my-memoize (fn [n]
             (condp = n
               0 1
               1 1
               (+ (m-fib (dec n)) (m-fib (- n 2)))))))

(m-fib 10)
;; (1) {}
;; (0) {(1) 1}
;; (2) {(1) 1, (0) 1}
;; (3) {(1) 1, (0) 1, (2) 2}
;; (4) {(1) 1, (0) 1, (2) 2, (3) 3}
;; (5) {(1) 1, (0) 1, (2) 2, (3) 3, (4) 5}
;; (6) {(1) 1, (0) 1, (2) 2, (3) 3, (4) 5, (5) 8}
;; (7) {(1) 1, (0) 1, (2) 2, (3) 3, (4) 5, (5) 8, (6) 13}
;; (8) {(1) 1, (0) 1, (2) 2, (3) 3, (4) 5, (5) 8, (6) 13, (7) 21}
;; (9) {(4) 5, (7) 21, (6) 13, (3) 3, (8) 34, (0) 1, (5) 8, (2) 2, (1) 1}
;; (10) {(4) 5, (7) 21, (6) 13, (9) 55, (3) 3, (8) 34, (0) 1, (5) 8, (2) 2, (1) 1}
```

tada, the arguments are stored as the key and the memoized value on the value. You can now thank Richard Hickey for this lovely function.
