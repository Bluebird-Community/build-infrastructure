# Build Infrastructure

Repository with Ansible roles for GitHub actions runner and container images used in our CI/CD pipeline.

## Container images

| Build status | Image name | Description |
|:-------------|:-----------|:------------|
| [![base-builder](https://github.com/Bluebird-Community/build-infrastructure/actions/workflows/base-builder.yml/badge.svg)](https://github.com/Bluebird-Community/build-infrastructure/actions/workflows/base-builder.yml) | [quay.io/bluebird/base-builder]() | Ubuntu base image with build tools for Linux with Docker and Cloudsmith-CLI |
| [![java-builder](https://github.com/Bluebird-Community/build-infrastructure/actions/workflows/java-builder.yml/badge.svg)](https://github.com/Bluebird-Community/build-infrastructure/actions/workflows/java-builder.yml) | [quay.io/bluebird/java-builder](https://quay.io/repository/bluebird/java-builder) | Java build environment in different version flavors with Node extending the base builder image |
| [![iplike-builder](https://github.com/Bluebird-Community/build-infrastructure/actions/workflows/iplike-builder.yml/badge.svg)](https://github.com/Bluebird-Community/build-infrastructure/actions/workflows/iplike-builder.yml) | [quay.io/bluebird/iplike](https://quay.io/repository/bluebird/iplike-builder) | Container image to build IPlike against various PostgreSQL flavors extending the base builder image |
| [![jni-jdk8-builder](https://github.com/Bluebird-Community/build-infrastructure/actions/workflows/jni-jdk8-builder.yml/badge.svg)](https://github.com/Bluebird-Community/build-infrastructure/actions/workflows/jni-jdk8-builder.yml) | [quay.io/bluebird/jni-jdk8-builder](https://quay.io/repository/bluebird/jni-jdk8-builder) | Container image to build JICMP and JICMP6 extending the base build image |
