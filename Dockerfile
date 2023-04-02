ARG CADDY_VERSION=2.6.4
ARG CADDY_MODULES="--with github.com/caddy-dns/cloudflare"

#FROM caddy:$CADDY_VERSION-alpine AS final
FROM caddy:$CADDY_VERSION-builder-alpine AS build

ARG CADDY_MODULES
RUN xcaddy build $CADDY_MODULES

ARG CADDY_VERSION
FROM caddy:$CADDY_VERSION-alpine AS final
#FROM final

COPY --from=build /usr/bin/caddy /usr/bin/caddy
