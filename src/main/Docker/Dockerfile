FROM debian:12.13-slim

## Install required dependencies
RUN <<EOF
apt-get update
apt-get upgrade -y
apt-get install -y --no-install-recommends \
    software-properties-common \
    python3 \
    python3-pip \
    cron \
    sudo
rm -rf /var/lib/apt/lists/*
EOF

# Install the domain-connect-dyndns package
RUN pip3 install --no-cache-dir domain-connect-dyndns --break-system-packages

WORKDIR /app
COPY src/main/scripts/* ./
RUN chmod +x ./entrypoint.sh ./run.sh && mkdir -p /var/log

VOLUME /app/config

ENV CRON_INTERVAL='*/15 * * * *'

ENTRYPOINT ["/app/entrypoint.sh"]
