###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL4001
RUN curl -fsSL "https://deb.nodesource.com/setup_${NODEJS_MAJOR_VERSION}.x" | bash - && \
    wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null && \
    echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && \
    apt-get -y install --no-install-recommends temurin-${OPENJDK_MAJOR}-jdk && \
    apt-get -y install --no-install-recommends nodejs="${NODEJS_MAJOR_VERSION}.*" && \
    ln -s /usr/lib/jvm/temurin-${OPENJDK_MAJOR}-jdk* /usr/lib/jvm/temurin-${OPENJDK_MAJOR}-jdk && \
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
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/maven/bin
ENV M2_HOME=/opt/maven
ENV JAVA_HOME=/usr/lib/jvm/temurin-${OPENJDK_MAJOR}-jdk

ENTRYPOINT ["/bin/bash"]

CMD ["-i"]

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Bluebird Community" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.java.version="Temurin ${OPENJDK_MAJOR}"
