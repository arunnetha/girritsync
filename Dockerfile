FROM php:apache

EXPOSE 8086

RUN apt-get update -y && \
	apt-get install -y libpng-dev && \
	cd /tmp && \
	docker-php-ext-install mysqli && \
	docker-php-ext-install gd && \
	docker-php-ext-install mbstring && \
	docker-php-ext-install fileinfo && \
	curl -sSL https://sourceforge.net/projects/mantisbt/files/mantis-stable/2.24.1/mantisbt-2.24.1.tar.gz | tar xzC /tmp && \
	mv mantisbt-*/* /var/www/html && \
	chown -R www-data:www-data /var/www/html && \
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
