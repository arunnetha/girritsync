FROM php:apache

EXPOSE 8086

RUN apt-get update -y
RUN apt-get install -y libpng-dev
RUN cd /tmp
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install gd
#RUN docker-php-ext-install mbstring
RUN docker-php-ext-install fileinfo
RUN curl -sSL https://sourceforge.net/projects/mantisbt/files/mantis-stable/2.24.1/mantisbt-2.24.1.tar.gz
RUN tar -xvf mantisbt-2.24.1.tar.gz
RUN mv mv mantisbt-2.24.1*/* /var/www/html
RUN chown -R www-data:www-data /var/www/html && \
    rm -rf /*.zip /tmp/* /var/tmp/* /var/lib/apt/lists/* && \
	mkdir /config && \
	cp /var/www/html/config/* /config && \
	rm -rf /var/www/html/config && \
	ln -s /config /var/www/html	&& \
	chown -R www-data:www-data /config
#curl -sSL https://downloads.sourceforge.net/project/mantisbt/mantis-stable/2.22.1/mantisbt-2.22.1.tar.gz
COPY ./httpd.conf /etc/apache2/sites-available/000-default.conf

COPY ./php.ini $PHP_INI_DIR/conf.d/

COPY ./cleanup.sh ./entrypoint.sh /

RUN chmod 500 /entrypoint.sh /cleanup.sh

ENTRYPOINT /entrypoint.sh
