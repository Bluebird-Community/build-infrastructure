###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "ubuntu:noble-20240429"

RUN apt-get update && \
    apt-get -y install --no-install-recommends openjdk-17-jdk="17.0.11+9-1" && \
    rm -rf /var/lib/apt/lists/*

### Runtime information and not relevant at build time
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

LABEL org.opencontainers.image.source="https://github.com/Bluebird-Community/build-infrastructure.git" \
      org.opencontainers.image.revision="beba1e6" \
      org.opencontainers.image.vendor="Labmonkeys Space" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.java.version="17.0.11+9-1"
