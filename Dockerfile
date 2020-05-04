FROM alpine:latest
MAINTAINER kjake
WORKDIR /opt/eclair
RUN apk update \
    && apk upgrade \
    && apk --no-cache add --virtual .builddeps \
    wget \
    unzip \
    ruby-dev \
    make \
    gcc \
    g++ \
    && apk --no-cache add \
    ruby \
    ruby-libs \
    ruby-etc \
    ruby-io-console \
    ruby-bundler \
    && mkdir -p /opt/eclair \
    && wget https://github.com/kjake/eclair/archive/master.zip -O /opt/eclair/master.zip \
    && unzip -j master.zip && rm master.zip \
    && gem update \
    && bundler install \
    && gem sources -c \
    && apk del .builddeps \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache \
    && rm -rf /root/.gem \
    && rm -rf /root/.bundle \
    && printf "%b" '#!'"/usr/bin/env sh\n \
    exec -- ruby eclair.rb \"\$@\"\n \
    " >/entry.sh && chmod +x /entry.sh \
    && adduser -S eclair
ENTRYPOINT ["/entry.sh"]
USER eclair
CMD []