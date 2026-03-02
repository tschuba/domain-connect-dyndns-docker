#!/usr/bin/env bash

# enable strict mode
set -euo pipefail
IFS=$'\n\t'

CONFIG_FILE=/app/config/domain-connect-dyndns.json

# fail with exception if the config file does not exist
if [ ! -f $CONFIG_FILE ]; then
    echo "Error: The file $CONFIG_FILE does not exist."
    exit 1
fi

# update all dynamic DNS records
domain-connect-dyndns update --all --config $CONFIG_FILE
