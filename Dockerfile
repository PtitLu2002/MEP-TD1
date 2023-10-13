FROM php:7.4.33-apache-bullseye

# Package système
RUN apt-get update && \
apt-get install --yes \
git=1:2.30.2-1+deb11u2 \
wget=1.21-1+deb11u1 \
ffmpeg=7:4.3.6-0+deb11u1 \
lsb-release

RUN apt-get update && \
apt-get install --yes \
librabbitmq-dev && \
pecl install amqp && \
docker-php-ext-enable amqp

# Extensions librairies
RUN docker-php-ext-install bcmath && \
docker-php-ext-install sockets

RUN curl --silent --show-error https://getcomposer.org/installer --output /tmp/composer-setup.php && \
php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer -version=2.6.2

COPY . /var/www/html/

RUN apt install unzip
RUN composer install


