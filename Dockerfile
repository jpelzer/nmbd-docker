#FROM resin/rpi-raspbian:latest
FROM debian:jessie

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
#RUN mv /etc/bind /etc/bind.orig
#RUN mv /var/lib/bind /var/lib/bind.orig

# Define working directory.
WORKDIR /opt/wins

# Add files to the container.
ADD . /opt/wins

# Define volumes.
VOLUME ["/etc/bind", "/var/lib/bind", "/var/run/wins"]

# Expose ports.
EXPOSE 53
EXPOSE 53/udp

# Define entrypoint.
ENTRYPOINT ["./entrypoint"]

# Define command
#CMD ["/usr/sbin/wins", "-u", "bind", "-g"]
