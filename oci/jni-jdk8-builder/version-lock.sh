#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export BASE_IMAGE="quay.io/bluebird/base-builder:0.0.6"
export OPENJDK_8_JDK_VERSION="8u412-ga-1~24.04.2"
export MAVEN_MAIN_VERSION="3"
export MAVEN_MINOR_VERSION="8.8"
export MAVEN_VERSION="${MAVEN_MAIN_VERSION}.${MAVEN_MINOR_VERSION}"
