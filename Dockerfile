FROM debian:jessie

RUN apt-get update && \
	apt-get install -y \
	    --no-install-recommends \
        ca-certificates \
        wget && \
    
# Creates a dummy /bin/start to avoid install to fail due to upstart not being installed.
    touch /bin/start && \
    chmod +x /bin/start && \

# repo sources
    wget -O - http://shell.ninthgate.se/packages/shell.ninthgate.se.gpg.key | apt-key add - && \
    echo "deb http://shell.ninthgate.se/packages/debian jessie main" > /etc/apt/sources.list.d/plex.list && \

# install plex
    apt-get update && \
    apt-get install -y plexmediaserver && \

# clean
    rm -f /bin/start && \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir /config
    
# global environment settings
ENV HOME="/config" \
    DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm" \

# Plex environment settings
    PLEX_USER=plex
    PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6 \
    PLEX_MEDIA_SERVER_MAX_STACK_SIZE=3000 \
    PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR=/config \
    PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver \
    PLEX_MEDIA_SERVER_TMPDIR=/transcode \
    LD_LIBRARY_PATH=/usr/lib/plexmediaserver

# ports and volumes
EXPOSE 32400
VOLUME ["/media", "/config", "/transcode"]

# entrypoint
COPY ./entrypoint.sh /
WORKDIR /usr/lib/plexmediaserver
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD ./Plex\ Media\ Server