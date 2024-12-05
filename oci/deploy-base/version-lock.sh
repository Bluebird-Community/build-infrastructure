#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export JDK8_BUILDER_IMAGE="quay.io/bluebird/java-builder:0.1.2.jdk-8.b2"
export JDK17_BUILDER_IMAGE="quay.io/bluebird/java-builder:0.1.2.jdk-17.b2"
export BASE_IMAGE="ubuntu:noble-20241118.1"
export JICMP_GIT_REPO_URL="https://github.com/Bluebird-Community/jicmp.git"
export JICMP_VERSION="v3.0.6"
export JICMP6_GIT_REPO_URL="https://github.com/Bluebird-Community/jicmp6.git"
export JICMP6_VERSION="v3.0.6"
export JRRD2_GIT_REPO_URL="https://github.com/Bluebird-Community/jrrd2.git"
export JRRD2_VERSION="v2.1.0"
export RRDTOOL_VERSION="1.7.*"
export CONFD_VERSION="v0.19.1"
export CONFD_BASE_URL="https://github.com/abtreece/confd/releases/download/${CONFD_VERSION}"
export PROM_JMX_EXPORTER_VERSION="1.0.1"
export PROM_JMX_EXPORTER_URL="https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${PROM_JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${PROM_JMX_EXPORTER_VERSION}.jar"
export JAVA_MAJOR_VERSION="17"
export JAVA_PKG="openjdk-${JAVA_MAJOR_VERSION}-jdk-headless"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
