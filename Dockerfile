FROM alpine:3.4
MAINTAINER Adam Bouqdib <adam@abemedia.co.uk>

RUN apk add --no-cache --update \
        curl wget ca-certificates \
        ruby ruby-bundler ruby-dev libffi-dev \
        libxml2-dev libxslt-dev \
        g++ make \
        nodejs \
        imagemagick \
    && npm install -g bower svgo \
    && wget -q http://static.jonof.id.au/dl/kenutils/pngout-20150319-linux.tar.gz \
    && tar -xzf pngout-20150319-linux.tar.gz \
    && mv pngout-20150319-linux/x86_64/pngout bin/pngout \
    && rm -rf pngout* \
    && export JEKYLL_ENV=production \
    && export LANG=C.UTF-8 \
    && export PNGOUT_BIN=bin/pngout \
    && export NOKOGIRI_USE_SYSTEM_LIBRARIES=true \
    && gem install --no-rdoc --no-ri \
        jekyll \
        html-proofer \
        less \
        therubyracer \
        uglifier \
        mini_magick \
        image_optim \
        image_optim_pack \
        jekyll-assets \
        autoprefixer-rails \
        jekyll-sitemap \
        jekyll-redirect-from \
        jekyll-tidy \
        jekyll-widgets \
        -- --use-system-libraries
