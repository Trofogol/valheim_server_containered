# made using manuals:
# https://valheim.fandom.com/wiki/Valheim_Dedicated_Server
# https://blog.serverflex.io/how-to-create-a-valheim-server-on-linux/

# this image looks consistent (official)
FROM steamcmd/steamcmd:ubuntu

ARG name="your containerized server"
ARG world="Valhalleim or watever"
ARG password="change-me-pls"
ARG public=1

ENV PASSWORD=$password WORLD=$world SERVER_NAME=$name PUBLIC=$public SAVEDIR="/valheim-data"

# folders for game
RUN mkdir -p /valheim && mkdir -p $SAVEDIR

WORKDIR /valheim

# install valheim server
RUN steamcmd +force_install_dir /valheim +login anonymous +app_update 896660 validate +quit

COPY ./launch_server.sh ./launch_server.sh

# server's port
EXPOSE 2456
EXPOSE 2457
EXPOSE 2458

ENTRYPOINT ./launch_server.sh

# remember to mount folder to SAVEDIR (check ENV line) to save game
# files outside container
