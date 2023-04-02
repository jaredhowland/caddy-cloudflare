ARG CADDY_VERSION=2.6.4
ARG CADDY_MODULES="--with github.com/caddy-dns/cloudflare"

ENV CADDY_VERSION=${CADDY_VERSION}
ENV CADDY_MODULES=${CADDY_MODULES}

#FROM caddy:$CADDY_VERSION-alpine AS final
FROM caddy:$CADDY_VERSION-builder-alpine AS build

RUN xcaddy build $CADDY_MODULES

FROM caddy:$CADDY_VERSION-alpine AS final
#FROM final

COPY --from=build /usr/bin/caddy /usr/bin/caddy
