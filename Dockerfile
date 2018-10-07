FROM ruby:alpine
MAINTAINER kjake
RUN apk update -f \
    && apk --no-cache add -f \
    ruby-bundler \
    curl \
    wget \
    git \
    && rm -rf /var/cache/apk/*
RUN git clone --depth 1 https://github.com/kjake/eclair.git /opt/eclair
WORKDIR /opt/eclair
RUN bundler install
RUN printf "%b" '#!'"/usr/bin/env sh\n \
exec -- ruby eclair.rb \"\$@\"\n \
" >/entry.sh && chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
CMD []