# Valheim Vanilla Server in container
dockered (and composed) version of vanilla Valheim server

## Installiation

> Tested on Ubuntu 18 and Ubuntu 20 cloud servers (VM)

1. Clone this repo

```
git clone <link from upper-right green button of this repository> valheim
```

1. Switch to newly created folder

```
cd valheim-server-containerized
```

### Preparations

`./install-tools.sh` - will install all necessary tools on fresh Ubuntu-based OS (it uses apt). 
Run it as root user (add `sudo` before it if you are not root user).

Or you can install them using the actual docs (You'll need these two tools):

[Docker](https://docs.docker.com/engine/install/)

[Docker-compose](https://docs.docker.com/compose/install/)

> You can also deploy server in Docker swarm mode (no need to install Docker compose then) or even run it in kubernetes (you'll need only Dockerfile then). 
> But I will not teach you how to do this :p

#### (optional) advice: get permissions to rule Docker

It will be handy to add your user (if you are not root) to docker group. If you don't want to use `sudo` every time 

(replace `username` with your actual user name)

`sudo usermod -aG docker username`

restart instance to apply changes

`sudo reboot`

### Configure and (re)start

#### configure

> It looks okay running it on shared 2vCPU 2Gb cloud instance (I tried it on Digital Ocean).
>
> Less CPU has caused disconnections, there was no option to get less than 2 Gb RAM when I tested it

1. create (or just define) directory for your save files, get its absolute path (the config is set to `/opt/valheim-server`)

1. `docker-compose.yaml`: edit `volumes` section: paste (or type) absolute path of your save files' on left side of ":" 
(change it if you want to save files not in `/opt/valheim-server`)

1. (optional) if you have saved world you want to continue, you can put it in save files folder (can't say how exactly, so figure it out)

1. `docker-compose.yaml`: edit `args` section: set server name, world name and password
(if you've improted save files on a previous step, world name must match the world name from the save files)

1. (optional) `docker-compose.yaml`: uncomment [and change if needed] `cpu_count`, `mem_limit` and `memswap_limit`. Memory params can understand size units: `g`,`m`,`k`,`b`. I don't recommend set it lower than 1.5g (1.5 Gb)

1. (optional) `launch_server.sh`: edit number after `-public` argument

#### Re(build) and (Re)Start

`./hit-it.sh`

This allows you to build and start the server the first time, as well as rebuild and restart it in future

> The next command should be used inside this repo root folder, as it has to find `docker-compose.yaml` file

> in case you did not add your non-root user to docker group, just use `sudo` for next command

This script tries to stop server gracefully (if it is already running) so your game files shoud be saved properly. 
Then it (re)builds Docker image (basically update server version to latest) and starts server. 
You can launch it periodically via cron or manually every time devs updates game/server version.
