###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

ARG GROUP_ID
ARG USER_ID

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
      apt-utils \
      build-essential \
      bzip2 \
      ca-certificates \
      cdbs \
      cmake \
      curl \
      debhelper \
      debsigs \
      devscripts \
      dh-autoreconf \
      gettext \
      git \
      gnupg \
      librrd-dev \
      lsb-release \
      make \
      patchutils \
      pkg-config \
      python3-pip \
      ripgrep \
      rpm \
      rsync \
      ruby \
      shellcheck \
      tree \
      vim \
      wget \
      xz-utils && \
    curl -fsSL https://get.docker.com | sh && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    gem install "fpm:${FPM_VERSION}" && \
    # I got the failure "error: externally-managed-environment" pip install cloudsmith-cli
    # The only way I got it working without digging into the details of venv with Docker running with other user contexts was using
    # --break-system-packages ¯\_(ツ)_/¯
    pip install --break-system-packages --upgrade --no-cache-dir cloudsmith-cli=="${CLOUDSMITH_CLI_VERSION}" && \
    groupadd -g ${GROUP_ID:-10001} opennms && \
    useradd -l -g ${GROUP_ID:-10001} -u ${USER_ID:-10001} -m -s /bin/bash -G sudo opennms && \
    usermod -a -G docker opennms
RUN if [ "$(uname -m)" = "x86_64" ]; then \
      curl -L "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64" --output /usr/local/bin/hadolint; \
    elif [ "$(uname -m)" = "aarch64" ]; then \
      curl -L "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-arm64" --output /usr/local/bin/hadolint; \
    elif [ "$(uname -m)" = "arm64" ]; then \
      curl -L "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-arm64" --output /usr/local/bin/hadolint; \
    else \
      echo "Unsupported architecture. Only x86_64, aarch64, arm64 supported." \
      exit 1; \
    fi && \
    chmod +x /usr/local/bin/hadolint

ENTRYPOINT ["/bin/bash"]

CMD ["-i"]

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
  org.opencontainers.image.revision="${VCS_REVISION}" \
  org.opencontainers.image.vendor="Bluebird Community" \
  org.opencontainers.image.authors="ronny@no42.org" \
  org.opencontainers.image.licenses="MIT"
