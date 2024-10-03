#!/bin/sh

# configs
AUUID=$1
CADDYIndexPage=https://github.com/AYJCSGM/mikutap/archive/master.zip
CONFIGXCORE=https://raw.githubusercontent.com/paieer/railway-run/main/etc/xcore.json
CONFIGCADDY=https://raw.githubusercontent.com/paieer/railway-run/main/etc/Caddyfile

PORT=8433
mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt
wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/
wget -qO- $CONFIGCADDY | sed -e "1c :$PORT" >/etc/caddy/Caddyfile
wget -qO- $CONFIGXCORE | sed -e "s/\$AUUID/$AUUID/g" > /etc/xcore.json
# start
# tor &

/xcore -config /etc/xcore.json &

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
