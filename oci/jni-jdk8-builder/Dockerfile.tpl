###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get -y install --no-install-recommends build-essential \
      cdbs \
      cmake \
      debhelper \
      devscripts \
      debsigs \
      dh-autoreconf \
      openjdk-8-jdk="${OPENJDK_8_JDK_VERSION}" \
      patchutils && \
    curl "https://dlcdn.apache.org/maven/maven-${MAVEN_MAIN_VERSION}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -o /tmp/maven.tar.gz && \
    mkdir /opt/maven && \
    tar xzf /tmp/maven.tar.gz --strip-components=1 -C /opt/maven && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENTRYPOINT ["/bin/bash"]

CMD ["-i"]

### Runtime information and not relevant at build time
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/maven/bin
ENV M2_HOME=/opt/maven

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Bluebird Community" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="AGPLv3"
