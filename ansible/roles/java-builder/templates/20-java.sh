#!/usr/bin/env bash
JAVA_HOME="/usr/lib/jvm/java-{{ openjdk_version }}-openjdk-{{ openjdk_java_arch }}"
M2_HOME="{{ openjdk_maven_home }}"
PATH="${M2_HOME}/bin:${PATH}"
