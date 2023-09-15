#!make

.DEFAULT_GOAL := help

## help: list all available make targets with descriptions
.PHONY: help
help:
	@echo "[*] usage: make <target>"
	@sed -nr 's/^##\s+/\t/p' ${MAKEFILE_LIST} | column -t -s ':'

## clean: stop, remove data, containers and images
.PHONY: clean
clean:
	sudo docker compose -f docker/dev/docker-compose.yml down --rmi local -v --remove-orphans

## build: build containers / service
.PHONY: build
build:
	sudo docker compose -f docker/dev/docker-compose.yml build

## stop: stop containers / service
.PHONY: stop
stop:
	sudo docker compose -f docker/dev/docker-compose.yml down

## start: start containers daemonized
.PHONY: start
start:
	sudo docker compose -f docker/dev/docker-compose.yml up -d

## restart: restart containers
.PHONY: restart
restart: stop start

## shell: open webapp shell
.PHONY: shell
shell:
	sudo docker compose -f docker/dev/docker-compose.yml exec web sh

## console: open rails console
.PHONY: console
console:
	sudo docker compose -f docker/dev/docker-compose.yml exec web rails c

## logs: tail container logs
.PHONY: logs
logs:
	sudo docker compose -f docker/dev/docker-compose.yml logs -f --tail=100

## clear-redis: clear redis (rails cache)
.PHONY: clear-redis
clear-redis:
	sudo docker compose -f docker/dev/docker-compose.yml exec redis redis-cli flushdb