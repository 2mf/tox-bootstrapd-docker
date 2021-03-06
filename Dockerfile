FROM alpine:3.13 as build

ENV TOX_VERSION=v0.2.12

RUN apk add libsodium-dev libvpx-dev opus-dev cmake autoconf libtool automake gcc g++ libconfig-dev make file linux-headers git
RUN mkdir -p /build
RUN cd /build && \
 git clone https://github.com/TokTok/c-toxcore -b ${TOX_VERSION} c-toxcore && \
 cd c-toxcore && \
 autoreconf -vif && ./configure --enable-static=true --disable-shared --enable-daemon --enable-dht-bootstrap && \
 make -j2

FROM alpine:3.13
RUN apk add libsodium libconfig bash
RUN mkdir -p /opt/tox /var/lib/tox-bootstrapd

COPY --from=build /build/c-toxcore/build/tox-bootstrapd /opt/tox/
COPY --from=build /build/c-toxcore/other/bootstrap_daemon/tox-bootstrapd.conf /opt/tox/tox-bootstrapd.conf

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh
