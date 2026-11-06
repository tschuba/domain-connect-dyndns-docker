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

# Configuration

The config file `config/domain-connect-dyndns.json` contains one entry per domain (provider, API URL, access/refresh tokens, IP state). It is written by `domain-connect-dyndns setup`; don't edit it by hand.

## Create a new config

```shell
pip3 install domain-connect-dyndns
mkdir -p config && touch ./config/domain-connect-dyndns.json
domain-connect-dyndns --config ./config/domain-connect-dyndns.json --domain example.com setup
```

Follow the printed instructions (log in at your provider and authorize). The domain is then stored in the file.

## Add a domain to an existing config

Run `setup` again with the same `--config` file and the additional domain. Existing entries are kept:

```shell
domain-connect-dyndns --config ./config/domain-connect-dyndns.json --domain sub.example.com setup
```

Subdomains are separate entries (e.g. `example.com` and `wache.example.com`). Afterwards restart the container: `docker compose restart`.

The file is mounted into the container (see `docker-compose.yaml`) and contains secrets, so keep it out of version control.

# Releases

The image is published to `ghcr.io/tschuba/domain-connect-dyndns` (`linux/amd64`, `linux/arm64`).

1. Open a PR with a Conventional Commits title (`feat:`, `fix:`, ...). If `src/` changed, a workflow bumps `VERSION` in the PR branch (`feat` = minor, `fix`/`perf` = patch, `!` = major).
2. Merge to `main`: the image is pushed as `edge`, and a tag `vX.Y.Z` plus a draft release are created.
3. Publish the draft release: the image is pushed as `X.Y.Z`, `X.Y`, `X` and `latest`.

## One-time repository setup

Create the secret `RELEASE_TOKEN`. Pushes made with the default `GITHUB_TOKEN` don't trigger other workflows, so a PAT is needed for the version bump, tagging and the image publish.

1. GitHub → Settings → Developer settings → Personal access tokens → Fine-grained tokens: create a token for this repository with `Contents: Read and write`.
2. Repository → Settings → Secrets and variables → Actions → New repository secret: `RELEASE_TOKEN`. For Dependabot PRs, add it under *Dependabot* as well.

Optionally, create the secret `REPO_SETTINGS_TOKEN` (fine-grained PAT, `Administration: Read and write`, `Contents: Read-only`). The workflow "Apply repo settings" then applies `.github/repo-settings.yml` (PR-only merges to `main`, squash merge only, required checks) on changes and nightly. Run it once manually via Actions → "Apply repo settings".
