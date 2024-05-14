###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get -y install --no-install-recommends apt-utils \
      bzip2 \
      ca-certificates \
      curl \
      gettext \
      git \
      gnupg \
      make \
      ripgrep \
      shellcheck \
      tree \
      wget \
      xz-utils && \
    apt-get -y install --no-install-recommends openjdk-17-jdk="${OPENJDK_17_JDK_VERSION}" && \
    curl -fsSL "https://deb.nodesource.com/setup_${NODEJS_MAJOR_VERSION}.x" | bash - && \
    curl -fsSL "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64" -o /usr/local/bin/hadolint && \
    chmod +x /usr/local/bin/hadolint && \
    apt-get -y install --no-install-recommends nodejs="${NODEJS_MAJOR_VERSION}.*" && \
    curl -fsSL https://get.docker.com | sh && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

RUN  npm install --global "yarn@${YARN_VERSION}" && \
     yarn global add "node-gyp@${NODE_GYP_VERSION}"

RUN curl "https://dlcdn.apache.org/maven/maven-${MAVEN_MAIN_VERSION}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -o /tmp/maven.tar.gz && \
    mkdir /opt/maven && \
    tar xzf /tmp/maven.tar.gz --strip-components=1 -C /opt/maven

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
