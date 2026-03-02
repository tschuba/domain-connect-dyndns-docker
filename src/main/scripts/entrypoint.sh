#!/usr/bin/env bash

# enable strict mode
set -euo pipefail
IFS=$'\n\t'

CONFIG_FILE=/app/config/domain-connect-dyndns.json
INTERVAL=${CRON_INTERVAL:-"15 * * * *"}

# setup cron job if it does not exist
if [ ! -f /etc/cron.d/app-cron ]; then

cat > /etc/cron.d/app-cron <<EOF
$INTERVAL /app/run.sh >> /var/log/cron.log 2>&1
EOF

fi

# start cron daemon in foreground to keep the container running
service cron start
tail -f /dev/null

