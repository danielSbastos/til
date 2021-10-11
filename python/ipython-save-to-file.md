## Ipython save and edit history to file 

Ipython is one of the best tools in the Python's ecossystem, however, I regurarly face the issue of after a long iteraing session of coding, I need to save it somewhere apart from the REPL's history. Thankfully, we can use the following two magic (%) command:


### Saving to file

```py
from inspect import getsouce
%save <file-name> getsource(foo)
```


### Editing file

Will open the file with your default code editor and once closed, return to the REPL

```py
%edit <file-name>
```
