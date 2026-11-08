#!/bin/sh
set -eu

if [ -z "${CONFIG:-}" ]; then
  curl \
    --fail \
    --silent \
    --show-error \
    --location \
    --retry 3 \
    --retry-connrefused \
    "$NODES_URL" \
    | p2 \
        --format json \
        --include-env \
        --template /opt/tox/tox-bootstrapd.conf.j2 \
        --output /var/lib/tox-bootstrapd/tox-bootstrapd.conf
fi

exec /usr/local/bin/tox-bootstrapd \
  --foreground \
  --config="${CONFIG:-/var/lib/tox-bootstrapd/tox-bootstrapd.conf}" \
  --log-backend=stdout