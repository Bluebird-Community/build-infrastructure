#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export JDK17_BUILDER_IMAGE="quay.io/bluebird/java-builder:rocky.0.3.0.jdk-17.b31"
export BASE_IMAGE="eclipse-temurin:17.0.17_10-jdk-ubi10-minimal"
export JICMP_GIT_REPO_URL="https://github.com/Bluebird-Community/jicmp.git"
export JICMP_VERSION="v4.0.0"
export JICMP6_GIT_REPO_URL="https://github.com/Bluebird-Community/jicmp6.git"
export JICMP6_VERSION="v4.0.0"
export JRRD2_GIT_REPO_URL="https://github.com/Bluebird-Community/jrrd2.git"
export JRRD2_VERSION="2.2.0"
export RRDTOOL_VERSION="1.8.*"
export CONFD_VERSION="v0.33.0"
export CONFD_BASE_URL="https://github.com/abtreece/confd/releases/download/${CONFD_VERSION}"
export PROM_JMX_EXPORTER_VERSION="1.5.0"
export PROM_JMX_EXPORTER_URL="https://github.com/prometheus/jmx_exporter/releases/download/${PROM_JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${PROM_JMX_EXPORTER_VERSION}.jar"
export PROM_JMX_EXPORTER_SHA256="0315f3f657876302c6205a98d4036ec775dca529c5d0419ca60ee669c688239f"
export PYROSCOPE_VERSION="2.1.2"
export PYROSCOPE_SHA256="bbf88777b8241934ce24447cd6bd1be3f80497d153972d32a716fb21b1e12b32"
export PYROSCOPE_URL="https://github.com/grafana/pyroscope-java/releases/download/v${PYROSCOPE_VERSION}/pyroscope.jar"
export JAVA_HOME="/opt/java/openjdk"
