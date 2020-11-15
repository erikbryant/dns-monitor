#!/bin/zsh

function pinger() {
  host=$1

  RESULT=$( ping -c 1 ${host?} 2>&1 )
  if [[ $? -ne 0 ]] ; then
    date
    echo ${RESULT?}
    echo
    echo
    return 1
  fi

  return 0
}

TOTAL=0
FAILS=0

while [[ 1 ]] ; do
  # for host in google.com wsj.com nytimes.com apple.com ; do
  for host in po-2-rur01.sfpine.ca.sfba.comcast.net ; do
    TOTAL=$(( ${TOTAL?} + 1 ))
    pinger ${host?}
    FAILS=$(( ${FAILS?} + $? ))
  done
  echo -n "${FAILS?} / ${TOTAL?}                                           \r"
  sleep 2
done
