FROM php:8.2-fpm

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

# Node.js 18 installieren (statt kaputte Debian-Version)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# PHP Extensions installieren
RUN docker-php-ext-install \
    zip \
    pdo \
    pdo_mysql \
    bcmath \
    intl

# Composer installieren (über offiziellen Composer-Container)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# NPM Cache-Verzeichnis umlegen (damit nicht /.npm verwendet wird)
ENV npm_config_cache=/app/.npm

WORKDIR /app