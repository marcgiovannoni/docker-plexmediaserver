FROM debian:jessie

# global environment settings
ENV HOME="/config" \
    DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm"

RUN apt-get update && \
# Plex user
    useradd --system --uid 942 -M --shell /usr/sbin/nologin plex && \
# Dependencies
	apt-get install -y \
	    --no-install-recommends \
        ca-certificates \
        curl && \
# Creates a dummy /bin/start to avoid install to fail due to upstart not being installed.
    touch /bin/start && \
    chmod +x /bin/start && \
# Repo sources
    curl http://shell.ninthgate.se/packages/shell.ninthgate.se.gpg.key | apt-key add - && \
    echo "deb http://shell.ninthgate.se/packages/debian jessie main" > /etc/apt/sources.list.d/plex.list && \
# Install plex
    apt-get update && \
    apt-get install -y plexmediaserver && \
# Clean
    rm -f /bin/start && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Plex environment settings
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6 \
    PLEX_MEDIA_SERVER_MAX_STACK_SIZE=3000 \
    PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR=/config \
    PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver \
    PLEX_MEDIA_SERVER_TMPDIR=/transcode \
    LD_LIBRARY_PATH=/usr/lib/plexmediaserver

# Ports and volumes
EXPOSE 32400
VOLUME ["/media", "/config", "/transcode"]

USER plex

# Entrypoint
COPY ./entrypoint.sh /
WORKDIR /usr/lib/plexmediaserver
ENTRYPOINT ["/entrypoint.sh"]
CMD ./Plex\ Media\ Server
