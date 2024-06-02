###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -fsSL "https://deb.nodesource.com/setup_${NODEJS_MAJOR_VERSION}.x" | bash - && \
    apt-get update && \
    apt-get -y install --no-install-recommends openjdk-17-jdk="${OPENJDK_17_JDK_VERSION}" && \
    apt-get -y install --no-install-recommends nodejs="${NODEJS_MAJOR_VERSION}.*" && \
    npm install --global "yarn@${YARN_VERSION}" && \
    yarn global add "node-gyp@${NODE_GYP_VERSION}" && \
    curl "https://dlcdn.apache.org/maven/maven-${MAVEN_MAIN_VERSION}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -o /tmp/maven.tar.gz && \
    mkdir /opt/maven && \
    tar xzf /tmp/maven.tar.gz --strip-components=1 -C /opt/maven && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

### Runtime information and not relevant at build time
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/maven/bin
ENV M2_HOME=/opt/maven

ENTRYPOINT ["/bin/bash"]

CMD ["-i"]

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Bluebird Community" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="AGPLv3" \
      org.opencontainers.image.java.version="${OPENJDK_17_JDK_VERSION}"
