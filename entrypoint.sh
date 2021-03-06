#!/bin/bash
set -e
/opt/tox/tox-bootstrapd --foreground --config=${CONFIG:-/opt/tox/tox-bootstrapd.conf} --log-backend=stdout
