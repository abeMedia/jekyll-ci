FROM ubuntu:xenial
MAINTAINER Adam Bouqdib <adam@abemedia.co.uk>

ENV DON_PAGES_VERSION=0.0.4 \
    PNGOUT_VERSION=20150319 \
    JEKYLL_ENV=production \
    LANG=C.UTF-8 \
    BUNDLE_SILENCE_ROOT_WARNING=1

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl tar git \
        ruby2.3 ruby2.3-dev g++ make \
        nodejs nodejs-legacy npm \
        imagemagick \
    && rm -rf /var/lib/apt/lists/* \

    # don't install docs
    && echo 'gem: --no-document' >> /etc/gemrc \

    && gem install bundler image_optim_pack \
    && npm install -g svgo \

    # required for image_optim (as not included in image_optim_pack)
    && curl -s http://static.jonof.id.au/dl/kenutils/pngout-$PNGOUT_VERSION-linux.tar.gz | tar zx \
    && cp -f pngout-$PNGOUT_VERSION-linux/x86_64/pngout /usr/local/bin/pngout \
    && rm -rf pngout-$PNGOUT_VERSION-linux \

    && gem install don-pages:$DON_PAGES_VERSION \
    && apt-get purge --auto-remove -y g++ make

COPY jekyll-ci /bin/jekyll-ci

CMD /bin/sh
