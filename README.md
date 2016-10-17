#Plex Media Server

[![](https://images.microbadger.com/badges/image/marcnc/docker-plexmediaserver.svg)](http://microbadger.com/images/marcnc/docker-plexmediaserver "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/marcnc/docker-plexmediaserver.svg)](http://microbadger.com/images/marcnc/docker-plexmediaserver "Get your own version badge on microbadger.com")

## Do not support Plex-Pass yet!

# Table of Contents
- [Installation](#installation)
    - [Mount Points](#mount-points)
- [Run Docker Container](#run-docker-container)

## <a name="installation"></a>Installation

### <a name="mount-points"></a>Mount Points
    * `/config`: Mount point for Plex Media Server configuration files. Need read-write access to `plex` user `942`
    * `/transcode`: Mount point for Plex Media Server temporary transcode files. Need read-write access to `plex` user `942`
    * `/media`: Mount point for your media files. Need read access to `plex` user `942`
    
Please note that `/config` and `/transcode`, for security purpose, won't be automatically created.

Example:

    $ mkdir /usr/appdata/plexmediaserver
    $ chown 942:942 -R /usr/appdata/plexmediaserver

## <a name="run-docker-container"></a>Run Docker Container
    
    $ docker run -d --restart=always -v /usr/appdata/plexmediaserver:/config -v ~/Media:/media  -v /mnt/fast_volume/appdata/plexmediaserver/transcode:/trancode --net=host -p 32400:32400 marcnc/plexmediaserver

`--net=host` is required only the first time you start the docker container, so Plex Media Server access the server.

Open `http://localhost:32400/web` in your browser to access Plex Media Server web.

Once you have access, go to `Server -> Network -> Advanced -> List of IP addresses and networks that are allowed without auth` and populate it with your docker gateway that most of the time be `172.17.0.0/16`. (This will be done by default by the container if required on a future release)
You will then be able to access Plex Media Server web without `--not=host`.
