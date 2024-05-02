#!/bin/bash -e
#
# Ansible managed
#

if [ -f /var/run/reboot-required ]; then
  echo "system restart required"
  exit 0
else
  echo "ok"
  exit 0
fi
