export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970
export SaveInterval=600
export BackupNumbers=1
export FirstBackupInterval=7200
export BackupInterval=43200

echo "Starting server"

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.
./valheim_server.x86_64 -name $SERVER_NAME -port 2456 -world $WORLD -password $PASSWORD -public 1 -savedir $SAVEDIR -saveinterval $SaveInterval -backups $BackupNumbers -backupshort $FirstBackupInterval -backuplong $BackupInterval

export LD_LIBRARY_PATH=$templdpath
