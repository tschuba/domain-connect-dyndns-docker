FROM debian:12.13-slim

## Install required dependencies
RUN <<EOF
apt-get update
apt-get upgrade
apt-get install -y --no-install-recommends \
    software-properties-common \
    python3 \
    python3-pip \
    cron \
    sudo
rm -rf /var/lib/apt/lists/*
EOF

# Install the domain-connect-dyndns package
RUN <<EOF
pip3 install --no-cache-dir domain-connect-dyndns --break system-packages
EOF

WORKDIR /app
COPY src/main/scripts/domain-connect-dyndns.sh ./run.sh
RUN chmod +x ./run.sh

VOLUME /app/config

ENTRYPOINT ["/app/run.sh"]
