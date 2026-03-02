#!/usr/bin/env bash

# enable strict mode
set -euo pipefail
IFS=$'\n\t'

CONFIG_FILE=/app/config/domain-connect-dyndns.json
INTERVAL=${CRON_INTERVAL:-"*/15 * * * *"}

# setup cron job if it does not exist
if [ ! -f /etc/cron.d/app-cron ]; then

cat > /etc/cron.d/app-cron <<EOF
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
$INTERVAL root /app/run.sh >> /proc/1/fd/1 2>&1
EOF

chmod 0644 /etc/cron.d/app-cron

fi

# update all dynamic DNS records
/app/run.sh

# start cron and keep the container running
cron -f -l 2
