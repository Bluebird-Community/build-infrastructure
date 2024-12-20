#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export BASE_IMAGE="quay.io/bluebird/base-builder:ubuntu.0.1.5.b8"
export MAVEN_MAIN_VERSION="3"
export MAVEN_MINOR_VERSION="8.8"
export MAVEN_VERSION="${MAVEN_MAIN_VERSION}.${MAVEN_MINOR_VERSION}"
export NODEJS_MAJOR_VERSION="18"
export YARN_VERSION="1.22.22"
export NODE_GYP_VERSION="10.1.0"
