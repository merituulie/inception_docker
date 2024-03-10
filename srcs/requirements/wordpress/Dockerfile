FROM alpine:3.18

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN	apk update && \
	apk add \
	php81 \
	php81-fpm \
	php81-mysqli \
	php81-phar \
	php81-mbstring \
	wget \
	curl \
	libcurl \
	php81-curl \
	libzip \
	php81-zip && \
	addgroup -S www && \
	adduser -S -H -g "" www -G www && \
	chmod +x /usr/local/bin/wp 

EXPOSE 9000

COPY tools/create_wordpress.sh /tmp/create_wordpress.sh
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

CMD ["sh", "/tmp/create_wordpress.sh"]
