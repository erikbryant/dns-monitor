#!/bin/bash

function pinger() {
  host=$1
  LOG=stats.${host?}

  START=$( date +%s )
  ping -c 1 ${host?} 2>&1 | head -2 | egrep -v "^PING" >> ${LOG?}
  STATUS=${PIPESTATUS[0]}
  STOP=$( date +%s )

  ELAPSED=$(( ${STOP?} - ${START?} ))
  echo "${ELAPSED?}  -  $( date )" >> ${LOG?}

  if [[ ${STATUS?} -ne 0 ]] ; then
    echo "$( date )  -  DNS fail ${host?}"
  fi

  return ${STATUS?}
}

HOSTS="google.com wsj.com nytimes.com apple.com"

while [[ 1 ]] ; do
  for host in ${HOSTS?} ; do
    pinger ${host?} &
  done
  sleep 2
done
