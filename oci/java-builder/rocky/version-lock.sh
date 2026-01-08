#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export BASE_IMAGE="quay.io/bluebird/base-builder:rocky-10.1-0.1.b26"
export MAVEN_MAIN_VERSION="3"
export MAVEN_MINOR_VERSION="8.9"
export MAVEN_VERSION="${MAVEN_MAIN_VERSION}.${MAVEN_MINOR_VERSION}"
export NODEJS_MAJOR_VERSION="24"
export PNPM_VERSION="latest-10"

# shellcheck disable=SC2153
case "${JAVA_MAJOR_VERSION}" in
"8")
    export JAVA_MINOR_VERSION="u472"
    export JAVA_BUILD_VERSION="b08"
    export JAVA_VERSION_DIR="jdk${JAVA_MAJOR_VERSION}${JAVA_MINOR_VERSION}-${JAVA_BUILD_VERSION}"
    export JAVA_VERSION="${JAVA_MAJOR_VERSION}${JAVA_MINOR_VERSION}${JAVA_BUILD_VERSION}"
    ;;
"11")
    export JAVA_MINOR_VERSION="0.29"
    export JAVA_BUILD_VERSION="7"
    export JAVA_VERSION_DIR="jdk-${JAVA_MAJOR_VERSION}.${JAVA_MINOR_VERSION}%2B${JAVA_BUILD_VERSION}"
    export JAVA_VERSION="${JAVA_MAJOR_VERSION}.${JAVA_MINOR_VERSION}_${JAVA_BUILD_VERSION}"
    ;;
"17")
    export JAVA_MINOR_VERSION="0.17"
    export JAVA_BUILD_VERSION="10"
    export JAVA_VERSION_DIR="jdk-${JAVA_MAJOR_VERSION}.${JAVA_MINOR_VERSION}%2B${JAVA_BUILD_VERSION}"
    export JAVA_VERSION="${JAVA_MAJOR_VERSION}.${JAVA_MINOR_VERSION}_${JAVA_BUILD_VERSION}"
    ;;
"21")
    export JAVA_MINOR_VERSION="0.9"
    export JAVA_BUILD_VERSION="10"
    export JAVA_VERSION_DIR="jdk-${JAVA_MAJOR_VERSION}.${JAVA_MINOR_VERSION}%2B${JAVA_BUILD_VERSION}"
    export JAVA_VERSION="${JAVA_MAJOR_VERSION}.${JAVA_MINOR_VERSION}_${JAVA_BUILD_VERSION}"
    ;;
*)
    echo "Unsupported Java major version ${JAVA_MAJOR_VERSION}."
    echo "Supported JDK versions: 8, 11, 17, 21"
    exit 1
    ;;
esac

export JAVA_JDK_BASE_URL="https://github.com/adoptium/temurin${JAVA_MAJOR_VERSION}-binaries/releases/download"
export JAVA_HOME="/usr/lib/jvm/java-${JAVA_MAJOR_VERSION}-temurin"
