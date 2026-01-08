###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN curl -fsSL "https://deb.nodesource.com/setup_${NODEJS_MAJOR_VERSION}.x" | bash - && \
    apt-get update && \
    apt-get -y install --no-install-recommends nodejs="${NODEJS_MAJOR_VERSION}.*" && \
    npm install --global "pnpm@${PNPM_VERSION}" && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN curl "https://dlcdn.apache.org/maven/maven-${MAVEN_MAIN_VERSION}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -o /tmp/maven.tar.gz && \
    mkdir /opt/maven && \
    tar xzf /tmp/maven.tar.gz --strip-components=1 -C /opt/maven

RUN install -d ${JAVA_HOME} && \
    if [ "$(uname -m)" = "x86_64" ]; then \
      curl -L "${JAVA_JDK_BASE_URL}/${JAVA_VERSION_DIR}/OpenJDK${JAVA_MAJOR_VERSION}U-jdk_x64_linux_hotspot_${JAVA_VERSION}.tar.gz" | tar xvz --strip-components=1 -C ${JAVA_HOME}; \
      curl -L "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64" --output /usr/local/bin/hadolint; \
    elif [ "$(uname -m)" = "aarch64" ]; then \
      curl -L "${JAVA_JDK_BASE_URL}/${JAVA_VERSION_DIR}/OpenJDK${JAVA_MAJOR_VERSION}U-jdk_aarch64_linux_hotspot_${JAVA_VERSION}.tar.gz" | tar xvz --strip-components=1 -C ${JAVA_HOME}; \
      curl -L "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-arm64" --output /usr/local/bin/hadolint; \
    elif [ "$(uname -m)" = "arm64" ]; then \
      curl -L "${JAVA_JDK_BASE_URL}/${JAVA_VERSION_DIR}/OpenJDK${JAVA_MAJOR_VERSION}U-jdk_aarch64_linux_hotspot_${JAVA_VERSION}.tar.gz" | tar xvz --strip-components=1 -C ${JAVA_HOME}; \
      curl -L "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-arm64" --output /usr/local/bin/hadolint; \
    else \
      echo "Unsupported architecture. Only x86_64, aarch64, arm64 supported." \
      exit 1; \
    fi && \
    chmod +x /usr/local/bin/hadolint

### Runtime information and not relevant at build time
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/maven/bin:${JAVA_HOME}/bin
ENV M2_HOME=/opt/maven
ENV JAVA_HOME="${JAVA_HOME}"

ENTRYPOINT ["/bin/bash"]

CMD ["-i"]

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Bluebird Community" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.java.version="${JAVA_VERSION}" \
      org.opennms.image.java.home="${JAVA_HOME}"
