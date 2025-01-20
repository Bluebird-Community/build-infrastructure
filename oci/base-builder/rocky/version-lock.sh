#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export VCS_SOURCE
export VCS_REVISION
export DATE
export BASE_IMAGE="quay.io/rockylinux/rockylinux:9.5.20241118-ubi"
export HADOLINT_VERSION="2.12.0"
export CLOUDSMITH_CLI_VERSION="1.4.1"
export FPM_VERSION="1.15.1"
export RRDTOOL_VERSION="1.7.*"
