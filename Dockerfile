# see hooks/build and hooks/.config
ARG BASE_IMAGE_PREFIX
FROM ${BASE_IMAGE_PREFIX}alpine

# see hooks/post_checkout
ARG ARCH
COPY .gitignore qemu-${ARCH}-static* /usr/bin/

# see hooks/build and hooks/.config
ARG BASE_IMAGE_PREFIX
FROM ${BASE_IMAGE_PREFIX}alpine:edge

# see hooks/post_checkout
ARG ARCH
COPY qemu-${ARCH}-static /usr/bin

ENV PUID=0
ENV PGID=0

COPY scripts/start.sh /

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    cat /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add --no-cache deluge && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* && \
    mkdir /config && \
    chmod -R 777 /start.sh /config

# ports and volumes
EXPOSE 8112 51414 51414/udp
VOLUME /config

CMD ["/start.sh"]