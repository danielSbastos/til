# TIL - Today I Learned

- [Clojure](#clojure)
- [VIM](#vim)
- [Unix](#unix)
- [Docker](#docker)
- [PostgreSQL](#postgresql)


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

`<select-text>` + `o`

## Unix

### Line numbers

`nl`


## Docker

### Create volume and filter it

```bash
# create volume
docker volume create --name volumeName
# using it
docker run -it -v volumeOnDocker:/volumeName 23894u32hued /bin/bash

# filter volume by its name
docker volume ls --filter "name=volumeName" # "volumeName" here can actually be a valid substring, e.g. "vol", "umeNa", etc.
```

### Access host volume in MacOS with Docker Desktop

Since Docker Desktop runs a VM with docker in it, you will need to enter the VM and then access the mount point, which can be found by `docker volume inspect <volume-name>` 

```bash
screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
# and now go to the mount point
cd /var/lib/docker/volumes/<volume-name>/_data 
```

## PostgreSQL

### Using schemas

This is simple but it was new to me :)

*List Schemas*
```psql
\dn
```

*List schemas tables*
```
\dt schema-name.
```

*Access table under schema*
```psql
SELECT field FROM schema-name.table-name;
```
