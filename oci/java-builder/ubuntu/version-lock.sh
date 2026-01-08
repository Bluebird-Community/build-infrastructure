#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export BASE_IMAGE="quay.io/bluebird/base-builder:ubuntu-25.10-0.1.b26"
export MAVEN_MAIN_VERSION="3"
export MAVEN_MINOR_VERSION="8.9"
export MAVEN_VERSION="${MAVEN_MAIN_VERSION}.${MAVEN_MINOR_VERSION}"
export NODEJS_MAJOR_VERSION="24"
export PNPM_VERSION="latest-10"
export JAVA_MAJOR_VERSION="17"
export JAVA_BUILD_VERSION="10"
export JAVA_VERSION="${JAVA_MAJOR_VERSION}.0.17"
export JAVA_JDK_BASE_URL="https://github.com/adoptium/temurin17-binaries/releases/download"
export JAVA_HOME="/usr/lib/jvm/java-17-temurin"