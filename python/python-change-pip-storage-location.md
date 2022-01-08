## Change where python deps are installed

### Altering pip storage location

In your `~/.pip/pip.conf`, change the content to the following


```
[global]
target=<your directory>
```

For me, since I wanted to save the deps in my HD instead of SSD, the file ended up like this:

```
[global]
target=/home/daniel/hd/pythondeps
```

### Altering import

It is not enough to alter the target directory, if a `import blabla` is executed, it will still look at the previous location. To fix this, simply export the following env var

`PYTHONPATH=<your directory>`

I added it to my `.zshrc` file.


