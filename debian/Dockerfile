FROM ruby:2.3-slim
MAINTAINER Adam Bouqdib <adam@abemedia.co.uk>

ENV DON_PAGES_VERSION=0.0.8 \
    PNGOUT_VERSION=20150319 \

    BUNDLE_SILENCE_ROOT_WARNING=1 \
    CI=true \
    JEKYLL_ENV=production \
    LANGUAGE=en_GB \
    LANG=en_GB.UTF-8 \
    LC_ALL=en_GB \
    NOKOGIRI_USE_SYSTEM_LIBRARIES=true

RUN apt-get update \
    && apt-get install -y curl git nodejs nodejs-legacy npm imagemagick \
    && npm install -g svgo \
    && curl -s http://static.jonof.id.au/dl/kenutils/pngout-$PNGOUT_VERSION-linux.tar.gz | tar zx \
    && cp -f pngout-$PNGOUT_VERSION-linux/x86_64/pngout /usr/local/bin/pngout \
    && rm -rf pngout-$PNGOUT_VERSION-linux \
    && gem update --system && gem update && gem clean \
    && gem install don-pages:$DON_PAGES_VERSION

COPY jekyll-ci /bin/jekyll-ci

CMD /bin/sh
