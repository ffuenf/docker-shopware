FROM ubuntu:xenial

MAINTAINER Achim Rosenhagen <a.rosenhagen@ffuenf.de>

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ant \
    curl \
    git \
    libfreetype6-dev \
    libmcrypt-dev \
    libpng12-dev \
    libssl-dev \
    libxml2-dev \
    mysql-client \
    openjdk-8-jdk \
    wget \
    zlib1g-dev \
    apache2 \
    apache2-utils \
    php-apcu \
    php-cli \
    php-curl \
    php-gd \
    php-mcrypt \
    php-zip \
    phpmyadmin \
    unzip \
    bzip2 \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN mkdir /tmp/ioncube && \
    mkdir -p /usr/local/ioncube && \
    cd /tmp/ioncube && \
    wget -q https://www.ioncube.com/php7-linux-x86-64-beta8.tgz -O /tmp/ioncube/php7-linux-x86-64-beta8.tgz && \
    tar xvf /tmp/ioncube/php7-linux-x86-64-beta8.tgz && \
    cd `php -i | grep extension_dir | cut -d' ' -f 5` && \
    cp /tmp/ioncube/ioncube_loader_lin_x86-64_7.0b8.so /usr/local/ioncube/ioncube_loader_lin_x86-64_7.0b8.so && \
    echo zend_extension=/usr/local/ioncube/ioncube_loader_lin_x86-64_7.0b8.so > /etc/php/7.0/apache2/conf.d/00-ioncube.ini && \
    echo zend_extension=/usr/local/ioncube/ioncube_loader_lin_x86-64_7.0b8.so > /etc/php/7.0/cli/conf.d/00-ioncube.ini && \
    rm -rf /tmp/ioncube/

RUN pecl install xdebug
RUN touch /etc/php/7.0/apache2/conf.d/xdebug.ini; \
    echo xdebug.remote_enable=1 >> /etc/php/7.0/apache2/conf.d/xdebug.ini; \
    echo xdebug.remote_autostart=0 >> /etc/php/7.0/apache2/conf.d/xdebug.ini; \
    echo xdebug.remote_connephpct_back=1 >> /etc/php/7.0/apache2/conf.d/xdebug.ini; \
    echo xdebug.remote_port=9000 >> /etc/php/7.0/apache2/conf.d/xdebug.ini; \
    echo xdebug.remote_log=/tmp/php-xdebug.log >> /etc/php/7.0/apache2/conf.d/xdebug.ini;

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY files/apache-shopware.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite \
    && sed --in-place "s/^upload_max_filesize.*$/upload_max_filesize = 10M/" /etc/php/7.0/apache2/php.ini \
    && sed --in-place "s/^memory_limit.*$/memory_limit = 256M/" /etc/php/7.0/apache2/php.ini \
    && phpenmod mcrypt

COPY files/config.php.tmpl /config.php.tmpl
COPY files/config-db.php.tmpl /config-db.php.tmpl
COPY files/phpmyadmin.config.php.tmpl /phpmyadmin.config.php.tmpl

RUN ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-enabled/phpmyadmin.conf

VOLUME ["/var/www/html"]

COPY files/substitute-env-vars.sh /substitute-env-vars.sh
RUN chmod +x /substitute-env-vars.sh

COPY files/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80