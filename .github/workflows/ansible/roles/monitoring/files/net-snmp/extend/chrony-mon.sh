#!/usr/bin/env bash
# 
# License: GPLv3
# --------------
#
# Script to monitor chrony status and statistics with Net-SNMP and extend directive
#
# Sample output from CSV:
# Reference-ID, IP, Stratum, Ref time, system time, Last offset, RMS offset, frequency, residial freq, skew, root delay, root dispersion, Update interval, Leap status
# 12827CCD,18.130.124.205,2,1568046882.271586497,-0.000194602,0.000039465,0.000138593,16.919,-0.000,0.022,0.045095846,0.002291578,1029.0,Normal
#
# Uncomment for debug
# set -x  

CHRONYC_CMD="/usr/bin/chronyc"
CHRONYC_TRACKING="${CHRONYC_CMD} -c tracking"

if [ ! -f ${CHRONYC_CMD} ]; then
  echo "Required command ${CHRONYC_CMD} not found." 1>&2
  exit 1
fi

if [ $# -eq 0 ]; then
	echo "Usage: $0 <last-offset | rms-offset | skew | root-delay | root-dispersion | leap-status>"
	echo ""
	echo "OpenNMS - http://www.opennms.org"
	exit 1
fi

RESULT=$(${CHRONYC_TRACKING})

while [ $# -gt 0 ]; do
  case "$1" in
    "last-offset")
        echo "${RESULT}" | awk -F, '{print $6 * 1000000000}'
        exit 0
        ;;
    "rms-offset")
        echo "${RESULT}" | awk -F, '{print $7 * 1000000000}'
        exit 0
        ;;
    "skew")
        echo "${RESULT}" | awk -F, '{print $10 * 1000}'
        exit 0
        ;;
    "root-delay")
        echo "${RESULT}" | awk -F, '{print $11 * 1000000000}'
        exit 0
        ;;
    "root-dispersion")
        echo "${RESULT}" | awk -F, '{print $12 * 1000000000}'
        exit 0
        ;;
    "leap-status")
        echo "${RESULT}" | awk -F, '{print $14}'
        exit 0
        ;;
    *)
        echo "Usage: $0 <delay | offset | jitter>"
        echo ""
        echo "OpenNMS - http://www.opennms.org"
        exit 1
        ;;
  esac
done
# EOF
