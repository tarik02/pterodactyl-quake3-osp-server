# Use Debian Bookworm as the base image
FROM debian:bookworm

# Set environment variables for the Quake server data
ENV ioquake_data=linuxq3apoint-1.32b-3.x86.run
ENV osp=osp103a.tar.gz

# Install necessary packages, including the Quake server and wget for downloading files
RUN echo "deb http://httpredir.debian.org/debian bookworm contrib" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y quake3-server wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/locale/* /var/cache/debconf/*-old /usr/share/doc/*

# Create a dedicated user and setup the working directory
RUN adduser --disabled-password --home /home/container container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Download and setup the Quake server data
RUN wget "https://dockerq3aosp.blob.core.windows.net/dockerq3aosp/${ioquake_data}" && \
    chmod +x ${ioquake_data} && \
    ./${ioquake_data} --tar xvf && \
    rm -rf ./${ioquake_data}

# Download and extract additional server data
RUN wget "https://dockerq3aosp.blob.core.windows.net/dockerq3aosp/${osp}" && \
    tar -xvzf ${osp}

# (Optional) If you have the pak0.pk3 file, you can uncomment this line to include it during the build
# COPY pak0.pk3 baseq3/

# Expose the server port
EXPOSE 27960/udp

# Set a health check command for Docker to verify the service health
HEALTHCHECK --start-period=5s CMD ps -C ioq3ded

# Copy the entrypoint script into the container and make it executable
COPY ./entrypoint.sh /entrypoint.sh
USER root
RUN chmod +x /entrypoint.sh
USER container

# Set the entry point script, which will start the Quake server
ENTRYPOINT ["/entrypoint.sh"]

# Set default parameters for the Quake server command
CMD ["+set", "dedicated", "1", "+set", "fs_game", "osp"]
