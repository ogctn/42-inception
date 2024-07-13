FROM debian:bullseye

RUN  apt update && apt upgrade -y && apt install -y redis-server

COPY conf/redis.conf /usr/local/etc/redis/redis.conf

RUN  echo "include /usr/local/redis/redis.conf" >> /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "--protected-mode no", "--appendonly yes"]
