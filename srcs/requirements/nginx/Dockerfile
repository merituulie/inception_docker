FROM debian:bullseye

RUN	apt-get update && apt-get -y upgrade && \
	apt-get -y install openssl nginx
RUN	mkdir /etc/nginx/ssl
RUN	openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/meskelin.crt \
	-keyout /etc/nginx/ssl/meskelin.key \
	-subj "/C=HK/ST=HK/L=HK/O=42 School/OU=meskelin/CN=meskelin/"

COPY	./conf/nginx.conf /etc/nginx/

RUN mkdir -p /run/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
