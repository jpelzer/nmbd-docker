FROM resin/rpi-raspbian:latest

MAINTAINER marc.lennox@gmail.com

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y curl dnsutils iproute nano samba wget

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Move the existing configuration and data directories out of the way
RUN mv /etc/samba /etc/samba.orig

# Define working directory.
WORKDIR /opt/samba

# Add files to the container.
ADD . /opt/samba

# Define volumes.
VOLUME ["/etc/samba", "/var/lib/samba", "/var/run/samba"]

# Expose ports.
EXPOSE 42
EXPOSE 137

# Define entrypoint.
ENTRYPOINT ["./entrypoint"]

# Define command
CMD ["/usr/sbin/nmbd", "-i", "-F", "-S", "-d", "3", "-H", "/var/samba/lmhosts"]
