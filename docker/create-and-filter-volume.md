### Create volume and filter it

```bash
# create volume
docker volume create --name volumeName
# using it
docker run -it -v volumeOnDocker:/volumeName 23894u32hued /bin/bash

# filter volume by its name
docker volume ls --filter "name=volumeName" # "volumeName" here can actually be a valid substring, e.g. "vol", "umeNa", etc.
```
