###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3041
RUN curl -fsSL "https://rpm.nodesource.com/setup_${NODEJS_MAJOR_VERSION}.x" | bash - && \
    dnf -y install nodejs-${NODEJS_MAJOR_VERSION}.* \
                   java-${SET_OPENJDK_MAJOR}-devel && \
    npm install --global "yarn@${YARN_VERSION}" && \
    yarn global add "node-gyp@${NODE_GYP_VERSION}" && \
    curl "https://dlcdn.apache.org/maven/maven-${MAVEN_MAIN_VERSION}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -o /tmp/maven.tar.gz && \
    mkdir /opt/maven && \
    tar xzf /tmp/maven.tar.gz --strip-components=1 -C /opt/maven && \
    dnf clean all

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
