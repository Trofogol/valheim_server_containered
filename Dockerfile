# made using manuals:
# https://valheim.fandom.com/wiki/Valheim_Dedicated_Server
# https://blog.serverflex.io/how-to-create-a-valheim-server-on-linux/

# this image looks consistent (official)
FROM steamcmd/steamcmd:ubuntu

ARG PORT=2456
ARG SERVER_NAME="your containerized server"
ARG WORLD="Valhalleim or watever"
ARG PASSWORD="change-me-pls"

# folder for game
RUN mkdir -p /valheim

# server's port
EXPOSE $PORT
# some Steams's "query port" (must be exposed as 2457 to external world)
# not sure you need it, but let it be
EXPOSE 2457

ENTRYPOINT steamcmd +force_install_dir /valheim +login anonymous +app_update 896660 validate +quit && valheim_server.x86_64

CMD -name $SERVER_NAME -port $PORT -world $WORLD -password $PASSWORD

# remember to mount folder to /root/.config/unity3d/IronGate/Valheim/worlds/ to save game 
# files (world DB and world itself) in case you want to destroy container
