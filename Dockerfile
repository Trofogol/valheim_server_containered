# made using manuals:
# https://valheim.fandom.com/wiki/Valheim_Dedicated_Server
# https://blog.serverflex.io/how-to-create-a-valheim-server-on-linux/

# this image looks consistent (official)
FROM steamcmd/steamcmd:ubuntu

ARG port=2456
ARG next_port=2457
ARG name="your containerized server"
ARG world="Valhalleim or watever"
ARG password="change-me-pls"
ARG public=1

ENV PASSWORD=$password WORLD=$world SERVER_NAME=$name PORT=$port PUBLIC=$public NEXT_PORT=$next_port SAVEDIR="/valheim-data"

# folders for game
RUN mkdir -p /valheim && mkdir -p $SAVEDIR

WORKDIR /valheim

# install valheim server
RUN steamcmd +force_install_dir /valheim +login anonymous +app_update 896660 validate +quit

COPY ./launch_server.sh ./launch_server.sh

# server's port
EXPOSE $PORT
# some Steams's "query port" (must be exposed as 2457 to external world)
# not sure you need it, but let it be
EXPOSE $NEXT_PORT

ENTRYPOINT ./launch_server.sh

# remember to mount folder to SAVEDIR (check ENV line) to save game
# files outside container
