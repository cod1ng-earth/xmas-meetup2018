FROM php:7.2-fpm-alpine AS app_php
RUN apk add --no-cache acl icu-dev file gettext bash;
RUN docker-php-ext-install -j$(nproc) intl;

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY docker/php/php.ini /usr/local/etc/php/php.ini
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN set -eux; composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --classmap-authoritative; composer clear-cache;
ENV PATH="${PATH}:/root/.composer/vendor/bin"
WORKDIR /srv/app

ENV CB_XMAS_VAR=phew

COPY composer.json composer.lock ./
RUN set -eux; composer install --prefer-dist --no-dev --no-autoloader --no-scripts --no-progress --no-suggest; composer clear-cache

COPY . ./

RUN set -eux; mkdir -p var/cache var/log; composer dump-autoload --classmap-authoritative --no-dev; composer run-script --no-dev post-install-cmd; chmod +x bin/console; sync
VOLUME /srv/app/var

COPY docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
CMD ["php-fpm"]

FROM nginx:1.15-alpine AS app_nginx
COPY docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
WORKDIR /srv/app
COPY --from=app_php /srv/app/public public/
