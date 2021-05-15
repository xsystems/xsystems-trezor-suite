FROM node:16.1.0-alpine3.13 AS builder

ARG TREZOR_SUITE_VERSION
ARG ORIGIN_HOSTNAME
ARG BLOCKBOOK_BITCOIN_URL
ARG DISABLE_MONITORING
ARG DISABLE_ANALYTICS
ARG DISABLE_NEWS_FEED

WORKDIR trezor-suite

RUN apk add --no-cache cairo-dev g++ git jpeg-dev make pango-dev pixman-dev pkgconfig python3

RUN git clone https://github.com/trezor/trezor-suite.git . \
 && git checkout tags/${TREZOR_SUITE_VERSION} -b release/${TREZOR_SUITE_VERSION}

COPY modify-files.sh /

RUN /modify-files.sh \
 && yarn \
 && yarn build:libs \
 && yarn suite:build:web


FROM httpd:2.4.46-alpine

COPY --from=builder \
     /trezor-suite/packages/suite-web/build \
     /usr/local/apache2/htdocs/
