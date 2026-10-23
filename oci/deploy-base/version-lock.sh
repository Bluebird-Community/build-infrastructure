#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export JDK17_BUILDER_IMAGE="quay.io/bluebird/java-builder:rocky.0.3.0.jdk-17.b31"
export BASE_IMAGE="eclipse-temurin:25.0.4.1_1-jre-ubi10-minimal"
export JICMP_GIT_REPO_URL="https://github.com/Bluebird-Community/jicmp.git"
export JICMP_VERSION="v4.0.0"
export JICMP6_GIT_REPO_URL="https://github.com/Bluebird-Community/jicmp6.git"
export JICMP6_VERSION="v4.0.0"
export JRRD2_GIT_REPO_URL="https://github.com/Bluebird-Community/jrrd2.git"
export JRRD2_VERSION="2.2.0"
export RRDTOOL_VERSION="1.8.*"
export CONFD_VERSION="v0.41.2"
export CONFD_BASE_URL="https://github.com/abtreece/confd/releases/download/${CONFD_VERSION}"
export PROM_JMX_EXPORTER_VERSION="1.7.0"
export PROM_JMX_EXPORTER_URL="https://github.com/prometheus/jmx_exporter/releases/download/${PROM_JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${PROM_JMX_EXPORTER_VERSION}.jar"
export PROM_JMX_EXPORTER_SHA256="0ad843261c567d1924a017d542e14c40f2afff523d940c25ee000742fde4b3a9"
export PYROSCOPE_VERSION="2.9.2"
export PYROSCOPE_SHA256="ad738199a90734f7b8392bae1ab892027d411acb953ef1f00cd6e8e7c669ff8f"
export PYROSCOPE_URL="https://github.com/grafana/pyroscope-java/releases/download/v${PYROSCOPE_VERSION}/pyroscope.jar"
export JAVA_HOME="/opt/java/openjdk"
