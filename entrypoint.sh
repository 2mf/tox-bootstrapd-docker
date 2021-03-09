#!/bin/bash
set -e
if [ -z ${CONFIG+x} ]; then
   /opt/tox/render.py -e PORT,KEYS_FILE_PATH,PID_FILE_PATH,ENABLE_IPV6,ENABLE_IPV4_FALLBACK,ENABLE_LAN_DISCOVERY,ENABLE_TCP_RELAY,TCP_RELAY_PORTS,ENABLE_MOTD,MOTD -o /etc/tox-bootstrapd.conf /opt/tox/tox-bootstrapd.conf.j2 ${NODES_URL}
fi

/opt/tox/tox-bootstrapd --foreground --config=${CONFIG:-/etc/tox-bootstrapd.conf} --log-backend=stdout
