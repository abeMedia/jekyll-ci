FROM ubuntu:xenial
MAINTAINER Adam Bouqdib <adam@abemedia.co.uk>

ENV PNGOUT_VERSION=20150319 \
    JEKYLL_ENV=production \
    LANG=C.UTF-8

RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common \
    && apt-add-repository ppa:brightbox/ruby-ng \
    && apt-get update && apt-get install -y --no-install-recommends \
        curl tar git \
        ruby2.3 ruby2.3-dev \
        nodejs nodejs-legacy npm \
        imagemagick \
	  && rm -rf /var/lib/apt/lists/* \
    && apt-get --purge autoremove -y software-properties-common \
    && npm install -g bower svgo \

    # required for image_optim (as not included in image_optim_pack)
    && curl -s http://static.jonof.id.au/dl/kenutils/pngout-$PNGOUT_VERSION-linux.tar.gz | tar zx \
    && cp -f pngout-$PNGOUT_VERSION-linux/x86_64/pngout /usr/local/bin/pngout \
    && rm -rf pngout-$PNGOUT_VERSION-linux

ENV DON_PAGES_VERSION=0.0.1
RUN gem install don-pages:$DON_PAGES_VERSION

COPY jekyll-ci /bin/jekyll-ci

CMD /bin/sh
