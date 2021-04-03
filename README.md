# Valheim Vanilla Server in container
dockered (and composed) version of vanilla Valheim server

## Installiation

> Tested on Ubuntu 18 and Ubuntu 20 servers

### Preparations

> It looks okay running it on shared 2vCPU 2Gb cloud instance (I tried it on Digital Ocean)

1. Clone this repo

```
git clone <link from upper-right green button of this repository> valheim
```

1. Switch to newly created folder

```
cd valheim-server-containerized
```

1. create (or just define) directory for your save files, get its absolute path

1. edit `volumes` section of `docker-compose.yaml`: paste (or type) absolute path of your save files' on left side of ":" (remove example path)

1. edit `args` section of `docker-compose.yaml`: set server name, world name and password

1. (optional) comment (disable) or change `cpu_count`, `mem_limit` and `memswap_limit`. Memory params can understand size units: `g`,`m`,`k`,`b`. I don't recommend set it lower than 1.5 Gb

1. (optional) edit number after `-public` argument in `launch_server.sh`


### Tools

You'll need docker and docker-compose tools. Install them using this small script `./install-tools.sh`. Run it as root user (add `sudo` before it if you are not root).

Or install them using actual docs:
[Docker](https://docs.docker.com/engine/install/)
[Docker-compose](https://docs.docker.com/compose/install/)

> You can also deploy server in Docker swarm mode (no need to install Docker compose). But I will not teach you how to do this :p

It will be handy to add your user (if you are not root) to docker group. If you don't want to use sudo every time (`username` is your user)

`sudo usermod -aG docker username`

restart instance to apply changes

`sudo reboot`

### (Re)Start server

> in case you did not add your non-root user to docker group, just use `sudo` for next command

`./hit-it.sh`

This script tries gracefully stop server (if it is already running) so your game files shoud be saved properly. 
Then it rebuilds image (update game) and starts server. You can launch it periodically via cron or manually every time when devs public update.
