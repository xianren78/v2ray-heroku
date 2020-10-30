[ -z "$SSH_CLIENT" ] && source <(curl --fail --retry 3 -sSL "$HEROKU_EXEC_URL")

  if [ $(ps -ef | grep "v3" | grep -v "grep" | wc -l) -eq 0 ]
  then
  rm -rf /v3bin/ss-loop*
  /v3bin/v3 -config=/v3bin/config.json &
  echo "Restart v2ray Success!"
  fi