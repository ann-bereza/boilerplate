CURRENT_DIRECTORY := $(shell pwd)
APP = boilerplate #specify your app name here

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "-----------------------"
	@echo "  start           builds the images and starts the containers"
	@echo "  stop 			 stops all containers"
	@echo "  restart         restarts all containers"
	@echo "  build           builds the images"
	@echo "  check            runs the test suite"
	@echo "  migrate         runs makemigrations and migrate commands"
	@echo "  clean           when you really need to start over"
	@echo "  status			 shows running containers"
	@echo "  tails			 shows logs"


start:
	@docker-compose up -d
	@echo "Started development server at http://0.0.0.0:8080/"

stop:
	@docker-compose stop

status:
	@docker-compose ps

restart: stop start

check:
	@docker-compose exec $(APP) python ./manage.py test

clean: stop
	@docker-compose rm --force

makemigrations:
	@docker-compose exec $(APP) python ./manage.py makemigrations

migrate: makemigrations
	@docker-compose exec $(APP) python ./manage.py migrate

build:
	@docker-compose build $(APP)

tail:
	@docker-compose logs -f

.PHONY: help start stop status restart check clean build migrate tail

