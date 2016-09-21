#!/bin/sh

# Delete PID file (prevent start error when already started)
if [ -f /config/Plex\ Media\ Server/plexmediaserver.pid ]; then
    rm -f /config/Plex\ Media\ Server/plexmediaserver.pid
fi

exec "$@"
echo "Plex Media Server started!"

