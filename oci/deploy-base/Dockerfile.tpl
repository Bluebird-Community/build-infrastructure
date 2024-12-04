##
# do some common things that all layers use, on top of the Ubuntu base; also
# make sure security updates are installed
##
FROM ${BASE_IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# We need to install inetutils-ping to get the JNI Pinger to work.
# The JNI Pinger is tested with getprotobyname("icmp") and it is null if inetutils-ping is missing.
RUN apt-get update && \
    env DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
        ca-certificates \
        inetutils-ping \
        curl \
        ${JAVA_PKG} \
        rrdtool="${RRDTOOL_VERSION}" && \
    curl -1sLf 'https://dl.cloudsmith.io/public/bluebird/common/setup.deb.sh' | bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Prevent setup prompt
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk"

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="Bluebird deploy image based on ${BASE_IMAGE}" \
      org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.vendor="Bluebird Community" \
      org.opencontainers.image.authors="'Bluebird' Community" \
      org.opencontainers.image.licenses="AGPL-3.0" \
      org.opennms.image.base="${BASE_IMAGE}" \
      org.opennms.image.java.version="${JAVA_MAJOR_VERSION}" \
      org.opennms.image.java.home="${JAVA_HOME}" \
      org.opennms.image.jicmp.version="${JICMP_VERSION}" \
      org.opennms.image.jicmp6.version="${JICMP6_VERSION}" \
      org.opennms.cicd.branch="${BUILD_BRANCH}" \
      org.opennms.cicd.buildurl="${BUILD_URL}" \
      org.opennms.cicd.buildnumber="${BUILD_NUMBER}"
