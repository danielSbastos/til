# TIL - Today I Learned

- [Clojure](#clojure)
- [VIM](#vim)
- [Unix](#unix)


## Clojure

### `comp` function 

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

## VIM

### Multicursor in block mode

<select-text> + ctrl-v

### Filter command

Use filter command to process text. If something is selected, filter command will replace that with the output of the command

```ruby
def foo
  "bar"
end
```

===> `:<,'>!! cowsay`

```ruby
 ___________________ 
< def foo "bar" end >
 ------------------- 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

### Jump to other end of visual select

Suppose you selected something but need to select more lines on the beggining, maybe you would cancel the selection and start all over, however, you coould jump to the other end of the select and use the motion keys to increase the selected area.

<select-text> `o`

## Unix

### Line numbers

`nl`

