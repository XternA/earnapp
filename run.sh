#!/bin/sh

cat <<'EOF'
  _____    _    ____  _   _    _    ____  ____
 | ____|  / \  |  _ \| \ | |  / \  |  _ \|  _ \ 
 |  _|   / _ \ | |_) |  \| | / _ \ | |_) | |_) |
 | |___ / ___ \|  _ <| |\  |/ ___ \|  __/|  __/ 
 |_____/_/   \_\_| \_\_| \_/_/   \_\_|   |_|
EOF
printf "v%s\n\n" "$(cat /etc/earnapp/ver)"

[ -n "$EARNAPP_UUID" ] && printf "%s" "$EARNAPP_UUID" > /etc/earnapp/uuid

earnapp start > /dev/null 2>&1 &

retries=10
count=0
while [ $count -lt $retries ]; do
    if [ "$(cat /etc/earnapp/status)" = "enabled" ]; then
        status="enabled"
        break
    fi
    count=$((count + 1))
    sleep 2
done

if [ $count -eq $retries ]; then
    printf "EarnApp couldn't be started after $retries attempts.\n\n"
    exit 1
fi

printf "✔ UUID:   %s\n" "$(cat /etc/earnapp/uuid)"
printf "%s Status: %s\n\n" "$([ "$status" = enabled ] && echo "✔" || echo "✖")" "${status:-disabled}"

earnapp register
earnapp autoupgrade &
earnapp run
