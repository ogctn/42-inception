DC := docker-compose -f ./srcs/docker-compose.yml
DB_PATH = /home/ogcetin/data

all:
	@mkdir -p $(DB_PATH)
	@mkdir -p $(DB_PATH)/wordpress
	@mkdir -p $(DB_PATH)/mariadb
	@$(DC) up -d --build
	@sudo echo "127.0.0.1 ogcetin.42.fr" > /etc/hosts

down:
	@$(DC) down

clean: down
	@rm -rf /home/ogcetin/data
	@docker stop $(docker ps -qa); \
	docker rm $(docker ps -qa); \
	docker volume rm $(docker volume ls -q); \
	docker network rm $(docker network ls -q) 2>/dev/null;

re: down all

.PHONY: all down re