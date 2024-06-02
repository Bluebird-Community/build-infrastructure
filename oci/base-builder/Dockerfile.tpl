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
      lsb-release \
      make \
      python3-pip \
      ripgrep \
      shellcheck \
      tree \
      vim \
      wget \
      xz-utils && \
    curl -fsSL https://get.docker.com | sh && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -fsSL "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64" -o /usr/local/bin/hadolint && \
    chmod +x /usr/local/bin/hadolint && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    # I got the failure "error: externally-managed-environment" pip install cloudsmith-cli
    # The only way I got it working without digging into the details of venv with Docker running with other user contexts was using
    # --break-system-packages ¯\_(ツ)_/¯
    pip install --break-system-packages --upgrade --no-cache-dir cloudsmith-cli==${CLOUDSMITH_CLI_VERSION}

ENTRYPOINT ["/bin/bash"]

CMD ["-i"]

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
  org.opencontainers.image.revision="${VCS_REVISION}" \
  org.opencontainers.image.vendor="Bluebird Community" \
  org.opencontainers.image.authors="ronny@no42.org" \
  org.opencontainers.image.licenses="AGPLv3"
