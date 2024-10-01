ARG CADDY_VERSION=2

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/mholt/caddy-l4 \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@main \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4@main \
    --with github.com/hslatman/caddy-crowdsec-bouncer/crowdsec

FROM caddy:${CADDY_VERSION} AS caddy

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
