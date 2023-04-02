# jaredhowland/caddy-cloudflare
Docker container for setting up a Caddy 2 server with Cloudflare DNS

The `Caddyfile` assumes you have `PHP-FPM` installed as well and creates some defaults settings to ensure it runs properly. You can remove that part of the Caddyfile should you not want that.

# Usage
```bash
# Go to the directory you wish to use for the container
# For example: cd ~
# The following commands assume you have `podman`, `podman-compose`, git`, and `nano` installed
git clone https://github.com/jaredhowland/caddy-cloudflare.git caddy
cd caddy
# Edit `Caddyfile` to meet your needs (including your Cloudflare API token)
nano Caddyfile
# Place your files in the `websites` directory and build Caddy
podman build -t caddy-cf:latest .
# Or, if you would like to build with a different version or different module(s):
podman build -t caddy:latest --build-arg CADDY_VERSION=2.6.4 --build-arg CADDY_MODULES="--with github.com/caddy-dns/cloudflare --with …" .
```
