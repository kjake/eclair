FROM alpine:latest
MAINTAINER kjake
WORKDIR /opt/eclair
RUN apk update \
    && apk upgrade \
    && apk --no-cache add -f \
    wget \
    unzip \
    ruby \
    ruby-bundler \
    ruby-io-console \
    ruby-dev \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /opt/eclair \
    && wget https://github.com/kjake/eclair/archive/master.zip -O /opt/eclair/master.zip \
    && unzip -j master.zip && rm master.zip \
    && bundler install \
    && printf "%b" '#!'"/usr/bin/env sh\n \
    exec -- ruby eclair.rb \"\$@\"\n \
    " >/entry.sh && chmod +x /entry.sh \
    && adduser -S eclair
ENTRYPOINT ["/entry.sh"]
USER eclair
CMD []