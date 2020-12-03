#!/usr/bin/env bash

# https://stackoverflow.com/a/33597663
# https://stackoverflow.com/a/20942015
__VERBOSE=0
__QUIET=0
declare -A LOG_LEVELS
# https://en.wikipedia.org/wiki/Syslog#Severity_level
LOG_LEVELS=([0]="err" [1]="warning" [2]="notice" [3]="debug")
function .log () {
  local LEVEL=${1}
  shift
  if [ ${__QUIET} -eq 1 ]; then
    return 0
  fi
  if [ ${__VERBOSE} -ge ${LEVEL} ]; then
    echo "[${LOG_LEVELS[$LEVEL]}]" "$@"
  fi
}

#https://stackoverflow.com/a/34531699
while getopts ":vq" opt; do
    case $opt in
        v) 
           (( __VERBOSE=__VERBOSE+1 ))
        ;;
        q) 
           (( __QUIET=1 ))
        ;;
    esac
done
if [ ${__VERBOSE} -gt 3 ]; then
    __VERBOSE=3
fi

printf "%s %d\n" "Verbosity level set to:" "$__VERBOSE"
printf "%s %d\n" "Quiet level set to:" "$__QUIET"

.log 0 "Error"
.log 1 "Warning"
.log 2 "Notice"
.log 3 "Debug"
