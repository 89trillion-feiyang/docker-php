FROM php:7.4-fpm
RUN apt-get update && apt-get install -y \
       python3-pip \
       git \
       bzip2 \
        libzip-dev \
        libbz2-dev \
        libjpeg-dev \
        libpng-dev \
        curl \
        libcurl4-openssl-dev \
        libonig-dev \
        libxml2-dev \
        supervisor  \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        zlib1g-dev \
        vim \
   && docker-php-ext-install -j$(nproc) gd \
       && docker-php-ext-install zip \
       && docker-php-ext-install pcntl \
       && docker-php-ext-install pdo_mysql \
       && docker-php-ext-install opcache \
       && docker-php-ext-install mysqli \
       && docker-php-ext-install mbstring \
       && docker-php-ext-install bz2 \
       && docker-php-ext-install soap \
       && rm -r /var/lib/apt/lists/* \
       && pip3 install pymongo
RUN pecl install -o -f redis \
        &&  docker-php-ext-enable redis
RUN pecl install -o -f mongodb \
        &&  docker-php-ext-enable mongodb
# Composer
ENV COMPOSER_HOME /root/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH
