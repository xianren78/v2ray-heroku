#!/bin/bash

while [ 1 ] ; do
  echo -n "Your username is $(whoami)."; echo -n " Your v2 traffic is below. "
  /v3bin/traffic.sh
  sleep 240s
done
