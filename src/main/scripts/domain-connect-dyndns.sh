#!/usr/bin/env bash

# enable strict mode
set -euo pipefail
IFS=$'\n\t'

# fail with exception if the file /app/config/domain-connect-dyndns.json does not exist
if [ ! -f /app/config/domain-connect-dyndns.json ]; then
    echo "Error: The file /app/config/domain-connect-dyndns.json does not exist."
    exit 1
fi

# update all dynamic DNS records
domain-connect-dyndns update --all --config /app/config/domain-connect-dyndns.json
