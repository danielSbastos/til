## Access host volume in MacOS with Docker Desktop

Since Docker Desktop runs a VM with docker in it, you will need to enter the VM and then access the mount point, which can be found by `docker volume inspect <volume-name>`

```bash
screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
# and now go to the mount point
cd /var/lib/docker/volumes/<volume-name>/_data
```
