#get env variables
include srcs/.env

#build rule
all:	$(WP_VOLUME_PATH) $(MARIADB_VOLUME_PATH)
		docker compose -f ./srcs/docker-compose.yml up --build

#volume paths
$(WP_VOLUME_PATH):
		mkdir -p $(WP_VOLUME_PATH)
$(MARIADB_VOLUME_PATH):
		mkdir -p $(MARIADB_VOLUME_PATH)

#down rule -v supprime les volumes
down:
		docker compose -f ./srcs/docker-compose.yml down -v

re:		clean
		$(MAKE) all

#arrete les containers, volumes et images
clean:	
		docker compose -f ./srcs/docker-compose.yml down --volumes --rmi all
		sudo rm -rf $(WP_VOLUME_PATH) $(MARIADB_VOLUME_PATH)

ls:		
		docker compose -f srcs/docker-compose.yml paths
		@echo "----------------------------"
		docker images
		@echo "----------------------------"
		docker volume ls

#supprime tous les containers, images non utilisees, etc
prune:	clean
		sudo docker system prune -f -a

.PHONY:	all re down clean ls prune