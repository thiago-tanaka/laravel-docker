FROM devilbox/php-fpm-8.1:latest

RUN apt-get update && apt-get install -y libmcrypt-dev --no-install-recommends \
    apt-utils \
    git \
    mariadb-client libmagickwand-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    #
    # fonts for japanese characters
    fonts-ipafont fonts-ipafont-gothic fonts-ipafont-mincho \
    libzip-dev zip unzip \
    libxrender1 libfontconfig1 libxext6 fonts-ipafont \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd exif bcmath pdo_mysql mysqli zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#  Install Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN apt-get update
RUN apt-get install nano


#install xdebug
RUN yes | pecl install xdebug 

COPY xdebug.ini /var/www/xdebug.ini

#enable xdebug:
ARG ENABLE_XDEBUG=false
RUN if [ ${ENABLE_XDEBUG} = true ]; then \
    cp /var/www/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini \
;fi

RUN rm -f /root/.bashrc
ADD .bashrc /root/.bashrc


# libfreetype6-dev \
#     libjpeg62-turbo-dev \
#     libpng-dev \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg \
#     && docker-php-ext-install -j$(nproc) gd
