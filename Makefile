NAME		 = inception

DB_PATH		:= /home/ogcetin/data
HOST_LINK	:= "127.0.0.1	ogcetin.42.fr" > /etc/hosts

all		:	$(NAME) up

$(NAME)	:
	@sudo mkdir -p $(DB_PATH)/mariadb
	@sudo mkdir -p $(DB_PATH)/wordpress
	@sudo echo $(HOST_LINK)
	@sudo chmod -R 777 $(DB_PATH)

down	:
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

up	:
	@sudo docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d


clean	: down
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down --volumes
	@docker container prune --force
	@docker image prune --force
	@sudo rm -rf $(DB_PATH)/mariadb/*
	@sudo rm -rf $(DB_PATH)/wordpress/*

fclean	: clean
	@sudo rm -rf $(DB_PATH)
	@docker network prune --force
	@docker volume prune --force

re	: fclean all

.PHONY	: all clean fclean re
