[ -z "$SSH_CLIENT" ] && source <(curl --fail --retry 3 -sSL "$HEROKU_EXEC_URL")

while [ 1 ] ; do
  if [ $(ps -ef | grep "v2ray" | grep -v "grep" | wc -l) -eq 0 ]
  then
  rm -rf /v2raybin/ss-loop*
 /entrypoint.sh
  echo "Restart v2ray Success!"
  fi
  echo "v2ray is running!"
  sleep 60s
done