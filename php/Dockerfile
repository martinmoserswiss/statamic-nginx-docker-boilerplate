FROM php:8.5-fpm

# Install system packages & Node.js (via Nodesource)
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    zip \
    gnupg \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libssl-dev \
    libicu-dev \
    libpq-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    lsb-release

# Node.js 20 installieren
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# PHP Extensions installieren (inkl. GD mit JPEG & FreeType)
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
 && docker-php-ext-install \
    zip \
    pdo \
    pdo_mysql \
    bcmath \
    intl \
    gd \
    exif

# Composer installieren (über offiziellen Composer-Container)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# NPM Cache-Verzeichnis umlegen (damit nicht /.npm verwendet wird)
ENV npm_config_cache=/app/.npm

# PsySH-Konfig in /tmp schreiben (damit Tinker nicht abstürzt)
ENV XDG_CONFIG_HOME=/tmp

# PHP upload limits anpassen
COPY ./php.ini /usr/local/etc/php/conf.d/uploads.ini

WORKDIR /app
