#!/bin/bash

while [ 1 ] ; do
  /v3bin/traffic.sh
  echo -n "Current user is $(whoami) and your "; echo -n "$(last)" |sed '/^[[:space:]]*$/d'; echo .
  sleep 240s
done
