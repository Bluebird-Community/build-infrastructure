###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

ARG GROUP_ID
ARG USER_ID

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3040,DL3041
RUN dnf install -y dnf && \
    dnf groupinstall -y 'Development Tools' && \
    dnf install -y epel-release && \
    dnf install -y bzip2 \
      ca-certificates \
      cmake \
      gettext \
      git \
      gnupg2 \
      patchutils \
      pkgconf-pkg-config \
      python3-pip \
      rsync \
      ruby \
      ruby-devel \
      selinux-policy-devel \
      shellcheck \
      sudo \
      tree \
      vim \
      wget \
      xz && \
    dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf install -y docker-ce docker-ce-cli containerd.io && \
    dnf clean all && \
    gem install "fpm:${FPM_VERSION}" && \
    pip install --upgrade --no-cache-dir cloudsmith-cli=="${CLOUDSMITH_CLI_VERSION}" && \
    groupadd -g ${GROUP_ID:-10001} opennms && \
    echo "%wheel   ALL=(ALL:ALL) ALL" > /etc/sudoers.d/10-wheel && \
    useradd -l -g ${GROUP_ID:-10001} -u ${USER_ID:-10001} -m -s /bin/bash -G wheel opennms && \
    usermod -a -G docker opennms && \
    useradd -l -m -s /bin/bash -G wheel cicd && \
    usermod -a -G docker cicd

ENTRYPOINT ["/bin/bash"]

CMD ["-i"]

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Bluebird Community" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="MIT"
