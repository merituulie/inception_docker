YML_PATH = srcs/docker-compose.yml
FILES_PATH = /home/meskelin/data
DOMAIN_NAME = meskelin.42.fr

.PHONY: up down ps clean fclean prune re all reset info

all:
	@if [ ! -d "$(FILES_PATH)/maria-db" ]; then \
		mkdir -p $(FILES_PATH)/maria-db; \
	fi
	@if [ ! -d "$(FILES_PATH)/wordpress-data" ]; then \
		mkdir -p $(FILES_PATH)/wordpress-data; \
	fi
	@if ! grep -q "$(DOMAIN_NAME)" /etc/hosts ; then \
		echo "127.0.0.1 $(DOMAIN_NAME)" | sudo tee -a /etc/hosts; \
	fi
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
	sudo docker system prune

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
