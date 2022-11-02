RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
ARCH := $(shell uname -m)

ifeq ($(ARCH),arm64)
BASE_DOCKERFILE := docker-compose.silicon_base.yml
else
BASE_DOCKERFILE := docker-compose.base.yml
endif

CONTRACTOR_APP_FILES := -f contractor_app/docker-compose.yml -f contractor_app/$(BASE_DOCKERFILE)
MANAGER_APP_FILES := -f manager_app/docker-compose.yml -f manager_app/$(BASE_DOCKERFILE)
COMPOSE := docker compose $(CONTRACTOR_APP_FILES) $(MANAGER_APP_FILES)

build:
	$(COMPOSE) build

contractor_app_ash:
	docker compose $(CONTRACTOR_APP_FILES) run --rm contractor_app /bin/ash

manager_app_ash:
	docker compose $(MANAGER_APP_FILES) run --rm manager_app /bin/ash

up:
	$(COMPOSE) up
