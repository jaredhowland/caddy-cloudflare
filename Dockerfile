ARG CADDY_VERSION

FROM caddy:$CADDY_VERSION-alpine AS final
FROM caddy:$CADDY_VERSION-builder-alpine AS build

ARG CADDY_MODULES
RUN xcaddy build $CADDY_MODULES

FROM final

COPY --from=build /usr/bin/caddy /usr/bin/caddy
