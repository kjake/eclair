FROM ruby:alpine
MAINTAINER kjake
RUN apk --no-cache add -f \
    wget \
    unzip \
    && rm -rf /var/cache/apk/*
RUN mkdir -p /opt/eclair
RUN wget https://github.com/kjake/eclair/archive/master.zip -O /opt/eclair/master.zip
WORKDIR /opt/eclair
RUN unzip -j master.zip && rm master.zip
RUN bundler install
RUN printf "%b" '#!'"/usr/bin/env sh\n \
exec -- ruby eclair.rb \"\$@\"\n \
" >/entry.sh && chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
RUN adduser -S eclair
USER eclair
CMD []