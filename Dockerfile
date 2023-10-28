# Use Debian Bookworm as the base image
FROM debian:bookworm

# Install Quake server
RUN echo "deb http://httpredir.debian.org/debian bookworm contrib" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y quake3-server && \
    apt-get clean

RUN rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/locale/* \
    /var/cache/debconf/*-old \
    /usr/share/doc/*

# Create a dedicated user and setup the working directory
RUN adduser --disabled-password --home /home/container container

# Expose the server port
EXPOSE 27960/udp

# Set a health check command for Docker to verify the service health
HEALTHCHECK --start-period=5s CMD ps -C ioq3ded

# Copy the entrypoint script into the container and make it executable
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /home/container
ENV HOME=/home/container
ENV USER=container
USER container

# Set the entry point script, which will start the Quake server
ENTRYPOINT ["/entrypoint.sh"]

# Set default parameters for the Quake server command
CMD ["+set", "dedicated", "1", "+set", "fs_game", "osp"]
