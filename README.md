# run tox-bootstrapd in Docker with low maintenance
## Public images
`docker pull dm2mf/tox-bootstrapd`

## Run
````
docker run -d -p 33445:33445 -p 33445:33445/udp -p 3389:3389 dm2mf/tox-bootstrapd
````

### Run with existing `keys` file in `/var/lib/tox-bootstrapd` and render `tox-bootstrapd.conf` with current bootstrap nodes from https://nodes.tox.chat when the container starts
````
docker run -d -p 33445:33445 -p 33445:33445/udp -p 3389:3389 \
 -v /var/lib/tox-bootstrapd/keys:/var/lib/tox-bootstrapd/keys \
 dm2mf/tox-bootstrapd
````

### Configure tox-bootstrapd.conf with environment variables
- `NODES_URL`default `https://nodes.tox.chat/json`
- `PORT` default `33445`
- `KEYS_FILE_PATH` default `/var/lib/tox-bootstrapd/keys`
- `PID_FILE_PATH` default `/var/run/tox-bootstrapd/tox-bootstrapd.pid`
- `ENABLE_IPV6` default `true`
- `ENABLE_IPV4_FALLBACK` default `true`
- `ENABLE_LAN_DISCOVERY` default `false`
- `ENABLE_TCP_RELAY` default `true`
- `TCP_RELAY_PORTS` default `[33445,3389]`
- `ENABLE_MOTD` default `true`
- `MOTD` default `tox-bootstrapd`
