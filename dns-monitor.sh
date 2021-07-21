#!/bin/zsh

function pinger() {
  host=$1

  RESULT=$( ping -c 1 ${host?} 2>&1 )
  if [[ $? -ne 0 ]] ; then
    echo
    echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    date
    echo ${RESULT?}
    echo
    echo
    return 1
  fi

  return 0
}

TOTAL=0
DNS_FAILS=0
NET_FAILS=0

while [[ 1 ]] ; do
  TOTAL=$(( ${TOTAL?} + 1 ))

  host=po-2-rur01.sfpine.ca.sfba.comcast.net
  pinger ${host?}
  DNS_FAILS=$(( ${DNS_FAILS?} + $? ))

  host=96.120.95.37
  pinger ${host?}
  NET_FAILS=$(( ${NET_FAILS?} + $? ))

  echo -n "Network: ${NET_FAILS?} / ${TOTAL?}   DNS: ${DNS_FAILS?} / ${TOTAL?}      \r"
  sleep 2
done
