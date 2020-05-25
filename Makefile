MAIN_SERVICE := app
TEST_COMPOSE_FILE := docker-compose.test.yml

#############################
# Docker machine states
#############################

## Start the project
up:
	docker-compose up -d

## Stop the project
stop:
	docker-compose stop

## Remove the project images, volumes and docker network
destroy:
	docker-compose down --rmi all -v

## Restart all project containers
restart: stop up

## Display current state of the containers
state:
	docker-compose ps

## Rebuild all containers
rebuild: stop
	docker-compose pull
	docker-compose build --pull
	make up

## Run all tests
test: stop
	docker-compose -f $(TEST_COMPOSE_FILE) pull
	docker-compose -f $(TEST_COMPOSE_FILE) build --pull

#############################
# General
#############################

## Bash shell as application user in main container
bash:
	docker exec -it -u 1000 $$(docker-compose ps -q $(MAIN_SERVICE) /bin/bash

## Bash shell as root user in main container
root:
	docker exec -it -u root $$(docker-compose ps -q $(MAIN_SERVICE)) /bin/bash

## Show logs for all containers. Use "make logs <container>" to specify a single container. 
logs:
	docker-compose logs -f --tail=50 $(ARGS)

#############################
# Argument fix workaround
#############################
%:
	@:
