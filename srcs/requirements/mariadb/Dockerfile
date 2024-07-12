FROM debian:bullseye

RUN  apt update && apt upgrade -y
RUN  apt install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/init-edit.sh /tmp/init-edit.sh

RUN  chmod +x /tmp/init-edit.sh

ENTRYPOINT  ["/bin/bash", "/tmp/init-edit.sh"]

EXPOSE 3306