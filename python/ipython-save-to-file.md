## Ipython save and edit history to file 

Ipython is one of the best tools in the Python's ecosystem, however, I regularly face the issue of after a long coding session, I need to save the final results somewhere apart from the REPL's history. Thankfully, we can use the following two magic (%) commands:


### Saving to file

```py
from inspect import getsouce
%save <file-name> getsource(<your-fn>)
```


### Editing the file

Will open the file with your default code editor and, once closed, return to the REPL

```py
%edit <file-name>
```
