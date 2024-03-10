FROM debian:bullseye

COPY	./conf/my.cnf /etc/my.cnf.d/my.cnf
COPY	./tools/setup.sh /tmp/mariadb-setup.sh

RUN	apt-get update && apt-get upgrade &&  \
	apt-get install -y mariadb-server mariadb-client && \
	chmod +x /tmp/mariadb-setup.sh

EXPOSE 3306

CMD ["sh", "/tmp/mariadb-setup.sh"]
