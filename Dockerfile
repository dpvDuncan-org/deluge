# syntax=docker/dockerfile:1

FROM alpine:latest

ENV PUID=0
ENV PGID=0

COPY scripts/start.sh /

RUN apk -U --no-cache upgrade
RUN apk add --no-cache ca-certificates
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache deluge py3-pip
RUN pip install install setuptools
RUN rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN mkdir /config
RUN chmod -R 777 /start.sh /config

# ports and volumes
EXPOSE 8112 51414 51414/udp
VOLUME /config

CMD ["/start.sh"]