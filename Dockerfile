FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates caddy tor wget && \
    wget -qO- https://yunt.in/d/xcore/xcore.zip | busybox unzip - && \
    chmod +x /xcore && \
    rm -rf /var/cache/apk/*

ADD start.sh /start.sh

ARG RAILWAY_ENVIRONMENT
ARG SSID

RUN chmod +x /start.sh

CMD ["/start.sh","$SSID"]