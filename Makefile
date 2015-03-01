DOCKER_COMPOSE ?= docker-compose
define DOCKER_COMPOSE_CONFIG
www:
  build: .
  ports:
    - "4000:4000"
  volumes:
    - $(PWD):/blog
endef
export DOCKER_COMPOSE_CONFIG

all: docker-compose.yml
	$(DOCKER_COMPOSE) up -d

stop: docker-compose.yml
	$(DOCKER_COMPOSE) stop

docker-compose.yml:
	echo "$$DOCKER_COMPOSE_CONFIG" > $@

clean:
	$(RM) docker-compose.yml
