# Docker image for IONOS Multiplatform Client

This is an unofficial image to wrap and deploy the official [IONOS Multiplatform Client](https://www.ionos.de/hilfe/domains/ip-adresse-konfigurieren/domain-mittels-dynamischen-dns-mit-einem-netzwerk-mit-wechselnder-ip-verbinden-linux/) in a container.

# Running the container

```shell
pip3 install domain-connect-dyndns \
  && mkdir -p .config \
  && touch ./config/domain-connect-dyndns.json \
  && domain-connect-dyndns --config ./config/domain-connect-dyndns.json --domain $DOMAIN setup
```

> Replace `$DOMAIN` with your domain name!

To run the docker container:

```shell
docker compose up -d
```
