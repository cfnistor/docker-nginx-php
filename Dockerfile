FROM cristake/debian

# nginx
RUN wget https://nginx.org/keys/nginx_signing.key \
 && apt-key add nginx_signing.key \
 && echo "deb https://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list.d/nginx.list \
 && echo "deb-src https://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list.d/nginx.list \
 && apt-get update \
 && apt-get install -y nginx

#php-fpm
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
 && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
 && apt-get update
RUN apt install -y \
    php7.2 \
    php7.2-gd \
    php7.2-ssh2 \
    php7.2-cli \
    php7.2-common \
    php7.2-json \
    php7.2-opcache \
    php7.2-mysql \
    php7.2-zip \
    php7.2-fpm \
    php7.2-mbstring \
    php7.2-xml \
    php7.2-curl \
    php7.2-bcmath

RUN usermod -aG www-data nginx

# Expose Ports
EXPOSE 80

WORKDIR /

ADD start.sh /start.sh
RUN chmod a+x /start.sh

CMD ["/start.sh"]