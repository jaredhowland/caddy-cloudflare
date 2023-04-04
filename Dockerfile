# syntax=docker/dockerfile:1
ARG CADDY_VERSION=2.6.4
ARG CADDY_MODULES="--with github.com/caddy-dns/cloudflare"

FROM caddy:$CADDY_VERSION-builder-alpine AS build

ARG CADDY_VERSION
ARG CADDY_MODULES

RUN XCADDY_SKIP_CLEANUP=0 xcaddy build $CADDY_MODULES

FROM caddy:$CADDY_VERSION-alpine AS final

COPY --from=build /usr/bin/caddy /usr/bin/caddy
