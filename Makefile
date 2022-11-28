RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
ARCH := $(shell uname -m)

ifeq ($(ARCH),arm64)
BASE_DOCKERFILE := docker-compose.silicon_base.yml
else
BASE_DOCKERFILE := docker-compose.base.yml
endif

SHARED_COMPOSE := docker compose -f docker-compose.yml
CONTRACTOR_APP_COMPOSE := docker compose -f contractor_app/docker-compose.yml -f contractor_app/$(BASE_DOCKERFILE)
MANAGER_APP_COMPOSE := docker compose -f manager_app/docker-compose.yml -f manager_app/$(BASE_DOCKERFILE)

build:
	$(CONTRACTOR_APP_COMPOSE) build & $(MANAGER_APP_COMPOSE) build

contractor_app_bash:
	$(CONTRACTOR_APP_COMPOSE) run --rm contractor_app /bin/bash

manager_app_bash:
	$(MANAGER_APP_COMPOSE) run --rm manager_app /bin/bash

dev_environment:
	$(SHARED_COMPOSE) create && $(CONTRACTOR_APP_COMPOSE) run --rm contractor_app /bin/sh -c "rails db:create" && $(MANAGER_APP_COMPOSE) run --rm manager_app /bin/sh -c "rails db:create"

test:
	$(CONTRACTOR_APP_COMPOSE) run --rm contractor_app /bin/sh -c "rspec"; $(MANAGER_APP_COMPOSE) run --rm manager_app /bin/sh -c "rspec"

up:
	$(SHARED_COMPOSE) up & $(CONTRACTOR_APP_COMPOSE) up & $(MANAGER_APP_COMPOSE) up

down:
	$(SHARED_COMPOSE) down & $(CONTRACTOR_APP_COMPOSE) down & $(MANAGER_APP_COMPOSE) down
