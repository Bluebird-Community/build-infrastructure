#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export BASE_IMAGE="ubuntu:noble-20241118.1"
export JICMP_VERSION="3.*"
export JICMP6_VERSION="3.*"
export JRRD2_VERSION="2.*"
export RRDTOOL_VERSION="1.7.*"
export CONFD_VERSION="v0.19.1"
export PROM_JMX_EXPORTER_VERSION="1.0.1"
export PROM_JMX_EXPORTER_URL="https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/$(PROM_JMX_EXPORTER_VERSION)/jmx_prometheus_javaagent-$(PROM_JMX_EXPORTER_VERSION).jar"
export JAVA_MAJOR_VERSION="17"
export JAVA_PKG="openjdk-${JAVA_MAJOR_VERSION}-jdk-headless"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"