YML_PATH = srcs/docker-compose.yml
FILES_PATH = /home/meskelin/data

.PHONY: up down ps clean fclean prune re all reset info

all:
	@if [ ! -d "$(FILES_PATH)/maria-db" ]; then \
		mkdir -p $(FILES_PATH)/maria-db; \
	fi
	# @if [ ! -d "/home/meskelin/data/html" ]; then \
	#	mkdir -p /home/meskelin/data/html; \
	#fi
	sudo docker compose -f $(YML_PATH) up -d

up:
	sudo docker compose -f $(YML_PATH) up -d

down:
	sudo docker compose -f $(YML_PATH) down

ps:
	sudo docker compose -f $(YML_PATH) ps

clean:
	sudo docker compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean
	@if [ -d $(FILES_PATH) ]; then \
		sudo rm -rf $(FILES_PATH); \
	fi;

prune:
	sudo docker system prune --all --force --volumes

reset:
	sudo docker stop $(sudo docker ps -a -q); sudo  docker rm $(sudo docker ps -qa); \
	sudo docker rmi -f $(docker images -qa); sudo docker volume rm $(sudo docker volume ls -q); \
	sudo docker network rm $(sudo docker network ls -q)

re: fclean all

info:
	@echo "==================== IMAGES ===================="
	@docker images
	@echo
	@echo "============================= CONTAINERS ============================="
	@docker ps -a
	@echo
	@echo "=============== NETWORKS ==============="
	@docker network ls
	@echo
	@echo "====== VOLUMES ======"
	@docker volume ls
