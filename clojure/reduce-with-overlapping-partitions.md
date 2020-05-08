## Reduce with overlapping partitions

### Intro

> In mathematics, reduction refers to the rewriting of an expression into a simpler form. - [Reduction - Wikipedia](https://en.wikipedia.org/wiki/Reduction_(mathematics)

Functional programming closely mimics mathematics, and thus there is a `reduce` function to deal with reductions. 

* In clojure:

`(reduce f coll)` `(reduce f val coll)`
```
f should be a function of 2 arguments. If val is not supplied,
returns the result of applying f to the first 2 items in coll, then
applying f to that result and the 3rd item, etc. If coll contains no
items, f must accept no arguments as well, and reduce returns the
result of calling f with no arguments. 
```

Examples:

```clojure
;; Create a word frequency map out of a large string s.

(def s "my name name is is is is daniel")

;; `s` is a long string containing a lot of words :)
(reduce #(assoc %1 %2 (inc (%1 %2 0)))
        {}
        (re-seq #"\w+" s))
;; => {"my" 1, "name" 2, "is" 4, "daniel" 1}
; (This can also be done using the `frequencies` function.)
```

- Content to read:
  - [Church–Rosser theorem](https://en.wikipedia.org/wiki/Church%E2%80%93Rosser_theorem)

### Our problem

Suppose you are given a structure of a person's meeting slots in military time (`[[900 1200] [1300 1500] [1530 1900]]`), the start and end shift times, and you are supposed to calculate available slots

How could you do this? You can do it with `reduce`, but our problem needs something else, because reduce receives one argument of the input per time, and we need to receive overlapping partitions of it in order to calculate the available time, e.g., given `[[900 1200] [1300 1500] [1530 1600] [1700 1730]]`, each step should be:

1) arguments = `[[900 1200] [1300 1500]]`, return `[[1200 1300]]`
2) arguments = `[[1300 1500] [1530 1600]]`, return `[[1200 1300] [1500 1530]]`
3) arguments = `[[1530 1600] [1700 1730]]`, return `[[1200 1300] [1500 1530] [1600 1700]]`

and calculating with the start and end time of `700` and `1800`, respectively:

`[[700 900] [1200 1300] [1500 1530] [1600 1700] [1730 1800]]`

There's where `partition` comes in

`(partition n coll)` `(partition n step coll)` `(partition n step pad coll)`

```
Returns a lazy sequence of lists of n items each, at offsets step
apart. If step is not supplied, defaults to n, i.e. the partitions
do not overlap. If a pad collection is supplied, use its elements as
necessary to complete last partition upto n items. In case there are
not enough padding elements, return a partition with less than n items.
```

```clojure
(partition 4 (range 20))
;;=> ((0 1 2 3) (4 5 6 7) (8 9 10 11) (12 13 14 15) (16 17 18 19))

(partition 3 6 ["a"] (range 20))
;;=> ((0 1 2) (6 7 8) (12 13 14) (18 19 "a"))
```

### Solution

```clojure
(defn available-slots
   [start-time occupied-slots end-time]
   (concat [[start-time (first (first occupied-slots))]]
           (reduce (fn [free-slots [[_ end1] [beginning2 _]]]
                     (conj free-slots [end1 beginning2]))
                   []
                   (partition 2 1 occupied-slots))
           [[(last (last occupied-slots)) end-time]]))

(def occupied-slots [[900 1200] [1300 1500] [1530 1400] [1500 1600]])
(available-slots 700 occupied-slots 1900)
;; => ([700 900] [1200 1300] [1500 1530] [1400 1500] [1600 1900])
```
