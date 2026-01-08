###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3041
RUN curl -fsSL "https://rpm.nodesource.com/setup_${NODEJS_MAJOR_VERSION}.x" | bash - && \
    dnf -y install nodejs-${NODEJS_MAJOR_VERSION}.* && \
    npm install --global "pnpm@${PNPM_VERSION}" && \
    curl "https://dlcdn.apache.org/maven/maven-${MAVEN_MAIN_VERSION}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -o /tmp/maven.tar.gz && \
    mkdir /opt/maven && \
    tar xzf /tmp/maven.tar.gz --strip-components=1 -C /opt/maven && \
    dnf clean all

RUN install -d /usr/lib/jvm/java-17-openjdk && \
    if [ "$(uname -m)" = "x86_64" ]; then \
      curl -L "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.17%2B10/OpenJDK17U-jdk_x64_linux_hotspot_17.0.17_10.tar.gz" | tar xvz --strip-components=1 -C /usr/lib/jvm/java-17-openjdk; \
      curl -L "https://github.com/hadolint/hadolint/releases/download/v/hadolint-Linux-x86_64" --output /usr/local/bin/hadolint; \
    elif [ "$(uname -m)" = "aarch64" ]; then \
      curl -L "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.17%2B10/OpenJDK17U-jdk_aarch64_linux_hotspot_17.0.17_10.tar.gz" | tar xvz --strip-components=1 -C /usr/lib/jvm/java-17-openjdk; \
      curl -L "https://github.com/hadolint/hadolint/releases/download/v/hadolint-Linux-arm64" --output /usr/local/bin/hadolint; \
    elif [ "$(uname -m)" = "arm64" ]; then \
      curl -L "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.17%2B10/OpenJDK17U-jdk_arm_linux_hotspot_17.0.17_10.tar.gz" | tar xvz --strip-components=1 -C /usr/lib/jvm/java-17-openjdk; \
      curl -L "https://github.com/hadolint/hadolint/releases/download/v/hadolint-Linux-arm64" --output /usr/local/bin/hadolint; \
    else \
      echo "Unsupported architecture. Only x86_64, aarch64, arm64 supported." \
      exit 1; \
    fi && \
    chmod +x /usr/local/bin/hadolint

### Runtime information and not relevant at build time
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/maven/bin
ENV M2_HOME=/opt/maven
ENV JAVA_HOME=/usr/lib/jvm/java-${SET_OPENJDK_MAJOR}-openjdk

ENTRYPOINT ["/bin/bash"]

CMD ["-i"]

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Bluebird Community" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.java.version="${SET_OPENJDK_MAJOR}"
