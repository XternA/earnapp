#!/bin/sh

echo "
  _____    _    ____  _   _    _    ____  ____
 | ____|  / \  |  _ \| \ | |  / \  |  _ \|  _ \ 
 |  _|   / _ \ | |_) |  \| | / _ \ | |_) | |_) |
 | |___ / ___ \|  _ <| |\  |/ ___ \|  __/|  __/ 
 |_____/_/   \_\_| \_\_| \_/_/   \_\_|   |_|
"
printf "v$(earnapp --version | cut -d' ' -f2)\n\n"

[ -n "$EARNAPP_UUID" ] && echo "$EARNAPP_UUID" > /etc/earnapp/uuid

earnapp start > /dev/null 2>&1 &

retries=10
count=0
while [ $count -lt $retries ]; do
    [ $(cat /etc/earnapp/status) = "enabled" ] && break
    count=$((count + 1))
    sleep 2
done

if [ $count -eq $retries ]; then
    printf "EarnApp couldn't be started after $retries attempts.\n\n"
    exit 1
fi

printf "UUID:   $(cat /etc/earnapp/uuid)\n"
printf "Status: $(cat /etc/earnapp/status)\n\n"

wait
