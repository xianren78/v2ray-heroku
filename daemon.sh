#!/bin/bash

while [ 1 ] ; do
  /v3bin/traffic.sh
  echo -n "Your username is $(whoami)."; echo -n " Your v2 traffic is below. "
  sleep 240s
done
