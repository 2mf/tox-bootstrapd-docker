#!/bin/sh
set -e
if [ -z ${CONFIG+x} ]; then
  curl --fail --silent --show-error --location --retry 3 --retry-connrefused https://nodes.tox.chat/json \
  | p2 --format json --include-env --template /opt/tox/tox-bootstrapd.conf.j2 --output /etc/tox-bootstrapd.conf
fi

/usr/local/bin/tox-bootstrapd --foreground --config=${CONFIG:-/etc/tox-bootstrapd.conf} --log-backend=stdout
