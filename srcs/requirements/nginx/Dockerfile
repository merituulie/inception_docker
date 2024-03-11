FROM alpine:3.18

COPY	./conf/nginx.conf /etc/nginx/http.d/nginx.conf

RUN	apk update  && \
	apk add openssl nginx && \
	mkdir -p /run/nginx /etc/nginx/ssl && \
	openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/meskelin.crt \
	-keyout /etc/nginx/ssl/meskelin.key \
	-subj "/C=HK/ST=HK/L=HK/O=42 School/OU=meskelin/CN=meskelin/" && \
	addgroup -S www && \
	adduser -S -H -g "" www -G www && \
	sed -i 's/user nginx/user www www/' /etc/nginx/nginx.conf && \
	sed -i 's/ssl_protocols TLSv1.1 TLSv1.2 TLSv1.2;/ssl_protocols TLSv1.2 TLSv1.3;/' /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
