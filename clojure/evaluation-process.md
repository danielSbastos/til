## Evaluation process

*All the text below is rephrased and based on the book Clojure for the Brave and True.*

### 1) Reader

The Reader transforms text into Clojure data structures. It's like a translator between Unicode characters and Clojure lists, vectors, maps, and other data structures.

It produces the AST, which is just composed of Clojure's structures, which differs from the non-list languages. Given this, Clojure is homoiconic, because it represents ASTs using lists, which in practical terms means that the user can represent data structures that they are used to manipulating and the evaluator consumes those data structures.

Text `(str "my name is " "Daniel")` is just a sequence of Unicode characters, but it's meant to represent a combination of Clojure's data structures. This textual representation is called a `reader-form`

You can read it (but not evaluate it!) with the function `read-string`

```clojure
(read-string "(+ 1 2)")
; => (+ 1 2)

(list? (read-string "(+ 1 2)"))
; => true

(conj (read-string "(+ 1 2)") :zagglewag)
; => (:zagglewag + 1 2)

(read-string "#(+ 1 %)")
; => (fn* [p1__22#] (+ 1 p1__22#))
;; WHAT HAPPENED?
```

### 2) Macro

Okay, after the reader returns the AST, is time to go through the land of the macros.

On the last code snippet example, the return from the reader contains a `fn` because the reader used a reader macro to transform `#(+ 1 %)`. Reader macros often allow you to represent data structures into compact ways bacause they expand it later to its full form.

Reader macros are just a part of macros, there are plenty of more to it. Macros allow us to use Clojure to manipulate data structures that Clojure evaluates.

What makes macros powerful is that they are executed between the reader and evaluator, so they can manipulate the data structures that the reader spits out and transform with those data structures before passing them to the evaluator. For example:

```clojure
(defmacro ignore-last-operand [function-call]
  (butlast functiona-call))
  
(ignore-last-operand (+ 1 2 10))
; => 3
```

Differences between macros and functions
- The macro `ignore-last-operand` does not receive 13 as the argument, but rather the list `(+ 1 2 10)`, which is quite different from function calls, which always evaluate their arguments
- The data structure returned by a function is not evaluated, but from the macro is it. The process of determining the macro return value is called macro expansion.

Macros allow us to create syntactic abstraction :)

### 3) Evaluator

In simple terms, the evaluator processes the data structures using rules corresponding to the data structure's type, and returns a result, e.g., for a symbol, Clojure looks for its reference; for a list, Clojure looks at the first element and calls a function, macro or special form. 
