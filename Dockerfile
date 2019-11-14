ARG BASE_IMAGE_PREFIX

FROM multiarch/qemu-user-static as qemu

FROM ${BASE_IMAGE_PREFIX}alpine:edge

COPY --from=qemu /usr/bin/qemu-*-static /usr/bin/

ENV PUID=0
ENV PGID=0

COPY scripts/start.sh /

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk -U --no-cache upgrade
RUN apk add --no-cache deluge
RUN rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN mkdir /config
RUN chmod -R 777 /start.sh /config

RUN rm -rf /usr/bin/qemu-*-static

# ports and volumes
EXPOSE 8112 51414 51414/udp
VOLUME /config

CMD ["/start.sh"]