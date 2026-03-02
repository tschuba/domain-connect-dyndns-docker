#!/usr/bin/env bash

# enable strict mode
set -euo pipefail
IFS=$'\n\t'

CONFIG_FILE=/app/config/domain-connect-dyndns.json
INTERVAL=${CRON_INTERVAL:-"*/15 * * * *"}

# setup cron job if it does not exist
if [ ! -f /etc/cron.d/app-cron ]; then

cat > /etc/cron.d/app-cron <<EOF
$INTERVAL /app/run.sh >> /proc/1/fd/1 2>&1
EOF

fi

# update all dynamic DNS records
./run.sh

# start cron daemon to keep the container running
service cron start

# keep container running
tail -f /dev/null

