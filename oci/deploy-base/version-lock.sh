#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export JDK8_BUILDER_IMAGE="quay.io/bluebird/java-builder:rocky.0.1.5.jdk-8.b21"
export JDK17_BUILDER_IMAGE="quay.io/bluebird/java-builder:rocky.0.1.5.jdk-17.b21"
export BASE_IMAGE="registry.access.redhat.com/ubi9/ubi-minimal:9.6-1751286687"
export JICMP_GIT_REPO_URL="https://github.com/Bluebird-Community/jicmp.git"
export JICMP_VERSION="v3.0.7"
export JICMP6_GIT_REPO_URL="https://github.com/Bluebird-Community/jicmp6.git"
export JICMP6_VERSION="v3.0.7"
export JRRD2_GIT_REPO_URL="https://github.com/Bluebird-Community/jrrd2.git"
export JRRD2_VERSION="v2.1.1"
export RRDTOOL_VERSION="1.7.*"
export CONFD_VERSION="v0.30.0"
export CONFD_BASE_URL="https://github.com/abtreece/confd/releases/download/${CONFD_VERSION}"
export PROM_JMX_EXPORTER_VERSION="1.3.0"
export PROM_JMX_EXPORTER_URL="https://github.com/prometheus/jmx_exporter/releases/download/${PROM_JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${PROM_JMX_EXPORTER_VERSION}.jar"
export PROM_JMX_EXPORTER_SHA256="ba74aad73934e59f4ca9c0779b49f1663c1fc7a81d5d99fc665bd5e5039310f5"
export JAVA_MAJOR_VERSION="17"
export JAVA_PKG="java-${JAVA_MAJOR_VERSION}-openjdk-devel"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
