# see hooks/build and hooks/.config
ARG BASE_IMAGE_PREFIX
FROM ${BASE_IMAGE_PREFIX}alpine

# see hooks/post_checkout
ARG ARCH
COPY .gitignore qemu-${ARCH}-static* /usr/bin/

# see hooks/build and hooks/.config
ARG BASE_IMAGE_PREFIX
FROM ${BASE_IMAGE_PREFIX}alpine

# see hooks/post_checkout
ARG ARCH
COPY qemu-${ARCH}-static /usr/bin

RUN apk update && apk upgrade

# ports and volumes
EXPOSE 0
VOLUME /config

CMD [""]

# annotation labels according to
# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md#pre-defined-annotation-keys
LABEL org.opencontainers.image.title=""
LABEL org.opencontainers.image.description=""
LABEL org.opencontainers.image.url="https://github.com/dpvDuncan/"
LABEL org.opencontainers.image.documentation="https://github.com/dpvDuncan/#readme"
LABEL org.opencontainers.image.version=""
LABEL org.opencontainers.image.licenses=""
LABEL org.opencontainers.image.authors="dpvDuncan"