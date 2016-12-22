FROM alpine:3.4
MAINTAINER Adam Bouqdib <adam@abemedia.co.uk>

ENV DON_PAGES_VERSION=0.0.3 \
    ADVANCECOMP_VERSION=1.20 \
    GIFSICLE_VERSION=1.88 \
    JHEAD_VERSION=3.00 \
    JPEGARCHIVE_VERSION=2.1.1 \
    JPEGOPTIM_VERSION=1.4.3 \
    JPEGTRAN_VERSION=9a \
    MOZJPEG_VERSION=3.1 \
    OPTIPNG_VERSION=0.7.5 \
    PNGCRUSH_VERSION=1.8.10 \
    PNGOUT_VERSION=20150319 \
    PNGQUANT_VERSION=2.5.2 \

    JEKYLL_ENV=production \
    LANGUAGE=en_GB \
    LANG=en_GB.UTF-8 \
    LC_ALL=en_GB \
    BUNDLE_SILENCE_ROOT_WARNING=1

RUN apk add --no-cache --update \
        curl ca-certificates git tar \
        ruby ruby-bundler ruby-json libffi nodejs imagemagick \

        # nokogiri
        libxslt \

        # image_optim
        libjpeg-turbo libpng \

    && apk add --no-cache --update --virtual build-dependencies \
        build-base bash ruby-dev libffi-dev \

        # nokogiri
        libxml2-dev libxslt-dev \

        # jpegoptim
        libjpeg-turbo-dev \

        # advancecomp
        zlib-dev \

        # pngquant
        bash libpng-dev \

        # mozjpeg
        pkgconfig autoconf automake libtool nasm \

    && npm install -g bower svgo \

    && cd /tmp \

    # advancecomp
    && curl -sL https://github.com/amadvance/advancecomp/releases/download/v$ADVANCECOMP_VERSION/advancecomp-$ADVANCECOMP_VERSION.tar.gz | tar zx \
    && cd advancecomp-$ADVANCECOMP_VERSION \
    && ./configure && make && make install \
    && cd .. \

    # gifsicle
    && curl -s https://www.lcdf.org/gifsicle/gifsicle-$GIFSICLE_VERSION.tar.gz | tar zx \
    && cd gifsicle-$GIFSICLE_VERSION \
    && ./configure && make && make install \
    && cd .. \

    # jhead
    && curl -s http://www.sentex.net/~mwandel/jhead/jhead-$JHEAD_VERSION.tar.gz | tar zx \
    && cd jhead-$JHEAD_VERSION \
    && make && make install \
    && cd .. \

    # jpegoptim
    && curl -s http://www.kokkonen.net/tjko/src/jpegoptim-$JPEGOPTIM_VERSION.tar.gz | tar zx \
    && cd jpegoptim-$JPEGOPTIM_VERSION \
    && ./configure && make && make install \
    && cd .. \

    # jpeg-recompress (from jpeg-archive along with mozjpeg dependency)
    && curl -sL https://github.com/mozilla/mozjpeg/archive/v$MOZJPEG_VERSION.tar.gz | tar zx \
    && cd mozjpeg-$MOZJPEG_VERSION \
    && autoreconf -fiv && ./configure && make && make install \
    && cd .. \
    && curl -sL https://github.com/danielgtaylor/jpeg-archive/archive/$JPEGARCHIVE_VERSION.tar.gz | tar zx \
    && cd jpeg-archive-$JPEGARCHIVE_VERSION \
    && make && make install \
    && cd .. \

    # jpegtran (from Independent JPEG Group)
    && curl -s http://www.ijg.org/files/jpegsrc.v$JPEGTRAN_VERSION.tar.gz | tar zx \
    && cd jpeg-$JPEGTRAN_VERSION \
    && ./configure && make && make install \
    && cd .. \

    # optipng
    && curl -sL http://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-$OPTIPNG_VERSION/optipng-$OPTIPNG_VERSION.tar.gz | tar zx \
    && cd optipng-$OPTIPNG_VERSION \
    && ./configure && make && make install \
    && cd .. \

    # pngcrush
    && curl -sL http://downloads.sourceforge.net/project/pmt/pngcrush/$PNGCRUSH_VERSION/pngcrush-$PNGCRUSH_VERSION.tar.gz | tar zx \
    && cd pngcrush-$PNGCRUSH_VERSION \
    && make && cp -f pngcrush /usr/local/bin \
    && cd .. \

    # pngout (binary distrib)
    && curl -s http://static.jonof.id.au/dl/kenutils/pngout-$PNGOUT_VERSION-linux-static.tar.gz | tar zx \
    && cd pngout-$PNGOUT_VERSION-linux-static \
    && cp -f x86_64/pngout-static /usr/local/bin/pngout \
    && cd .. \

    # pngquant
    && curl -sL http://pngquant.org/pngquant-$PNGQUANT_VERSION-src.tar.bz2 | tar jx \
    && cd pngquant-$PNGQUANT_VERSION \
    && ./configure && make && make install \
    && cd .. \

    && cd .. && rm -rf /tmp/* \

    && echo 'gem: --no-document' >> /etc/gemrc \
    && gem update --system && gem update && gem clean \
    && gem install don-pages:$DON_PAGES_VERSION \
    && apk del build-dependencies

COPY jekyll-ci /bin/jekyll-ci

CMD /bin/sh
