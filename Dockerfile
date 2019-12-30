FROM mcr.microsoft.com/dotnet/core/runtime:2.1-stretch-slim

# source: https://github.com/eclipse/mosquitto/blob/6bfd52af9e29165bbf82e3c67b0c4f8310e92b43/docker/1.6/Dockerfile

ENV VERSION=1.6.8 \
    DOWNLOAD_SHA256=7df23c81ca37f0e070574fe74414403cf25183016433d07add6134366fb45df6 \
    GPG_KEYS=A0D6EEA1DCAE49A635A3B2F0779B22DFB3E717B7 \
    LWS_VERSION=2.4.2

RUN addgroup --system -gid 1883 mosquitto && \
adduser --system --uid 1883 --home /var/empty --shell /sbin/nologin --gid 1883 mosquitto && \
mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log 

RUN apt-get update && \
    apt-get install -y software-properties-common wget gnupg apt-transport-https && \
    wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key && \
    apt-key add mosquitto-repo.gpg.key && \
    cd /etc/apt/sources.list.d/ && \
    wget http://repo.mosquitto.org/debian/mosquitto-stretch.list && \
    apt-get update && \
    apt-get install -y mosquitto && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/mosquitto/data", "/mosquitto/log"]
