ifneq (,$(findstring xterm,${TERM}))
	BLACK        := $(shell tput -Txterm setaf 0)
	RED          := $(shell tput -Txterm setaf 1)
	GREEN        := $(shell tput -Txterm setaf 2)
	YELLOW       := $(shell tput -Txterm setaf 3)
	LIGHTPURPLE  := $(shell tput -Txterm setaf 4)
	PURPLE       := $(shell tput -Txterm setaf 5)
	BLUE         := $(shell tput -Txterm setaf 6)
	WHITE        := $(shell tput -Txterm setaf 7)
	RESET := $(shell tput -Txterm sgr0)
else
	BLACK        := ""
	RED          := ""
	GREEN        := ""
	YELLOW       := ""
	LIGHTPURPLE  := ""
	PURPLE       := ""
	BLUE         := ""
	WHITE        := ""
	RESET        := ""
endif

install_confirmed:
	sudo rm -R docker/db_data -f;
	sudo chmod 777 -R docker/*.sh;
	sudo chmod 777 -R docker/*.py;
	cp .env.example .env;
	python3 docker/override-env-variables.py `pwd`;
	docker/./stop-containers.sh;
	docker-compose up -d;
	docker exec -it $$(docker ps --filter name=app* -q) composer install;
	docker exec -it $$(docker ps --filter name=app* -q) npm install;
	docker exec -it $$(docker ps --filter name=app* -q) npm run dev;
	docker exec -it $$(docker ps --filter name=app* -q) php artisan 	key:generate;
	docker/./check-mysql.sh
	docker exec -it $$(docker ps --filter name=app* -q) php artisan migrate:fresh --seed
	sudo chown -R $$USER:www-data storage;
	sudo chown -R $$USER:www-data bootstrap/cache;
	chmod -R 775 storage;
	chmod -R 775 bootstrap/cache;
	echo /db_data >> docker/.gitignore

install:
	@echo -n "$(YELLOW) This command will erase all data from the database. Are you sure? [y/N] $(RESET)" && read ans && [ $${ans:-N} = y ] && make install_confirmed

up:
	cd docker; docker-compose up -d

stop:
	docker stop $$(docker ps -a -q);

restart:
	docker stop $$(docker ps -a -q);
	cd docker; docker-compose up -d --build

app_bash:
	docker exec -it $$(docker ps --filter name=app* -q) bash

permissions:
	@sudo chown -R $$USER:www-data storage;sudo chown -R $$USER:www-data bootstrap/cache;chmod -R 775 storage;chmod -R 775 bootstrap/cache

