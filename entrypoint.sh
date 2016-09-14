#!/bin/sh

# Output logs to stdout.
echo "Redirecting logs to stdout..."
mkdir -p '/config/logs'
touch '/config/main.log'
tail -f '/config/main.log' &

echo "Starting Plex Media Server..."
exec "$@"