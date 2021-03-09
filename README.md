# tox-docker
run Tox node in Docker

# Public images
docker pull dm2mf/tox

# Run
````
docker run -d -p 33445:33445 -p 33445:33445/udp -p 3389:3389 \
  -v /etc/tox-bootstapd.conf:/etc/tox-bootstrapd.conf \
  -e CONFIG=/etc/tox-bootstapd.conf \
  dm2mf/tox
````
# Run with existing `keys` file in /var/lib/tox-bootstrapd
````
docker run -d -p 33445:33445 -p 33445:33445/udp -p 3389:3389 \
 -v /var/lib/tox-bootstrapd/keys:/var/lib/tox-bootstrapd/keys \
 -v /etc/tox-bootstapd.conf:/etc/tox-bootstrapd.conf \
 -e CONFIG=/etc/tox-bootstapd.conf \
 dm2mf/tox
````
