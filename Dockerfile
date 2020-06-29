FROM debian:jessie

## The Data from the official point release.
ENV ioquake_data linuxq3apoint-1.32b-3.x86.run
ENV osp osp103a.tar.gz

RUN echo "deb http://httpredir.debian.org/debian jessie contrib" >> /etc/apt/sources.list && \
        apt-get update && \
        apt-get install -y quake3-server \
        wget && \
            apt-get clean

RUN rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/* \
        /var/cache/debconf/*-old \
        /var/lib/apt/lists/* \
        /usr/share/doc/*

WORKDIR /usr/share/games/quake3

RUN wget "http://michalkozak.cz/q3a/${ioquake_data}" && \
        chmod +x ${ioquake_data} && \
        ./${ioquake_data} --tar xvf && \
        rm -rf ./${ioquake_data}

RUN wget "http://michalkozak.cz/q3a/${osp}" && \
        tar -xvzf ${osp}

## You can include the pak0.pk3 file during the build, if you want to
#COPY pak0.pk3 baseq3/

USER Debian-quake3

EXPOSE 27960/udp

HEALTHCHECK --start-period=5s CMD ps -C ioq3ded

ENTRYPOINT ["/usr/games/quake3-server"]

CMD ["+set", "dedicated", "1", "+set", "fs_game", "osp", "+exec", "lanwarig.cfg"]
