.PHONY: build run clean test monitor
YAML ?= docker-compose.yml

build:
	docker build -t app -f Dockerfile .

run: build
	docker-compose -f $(YAML) up -d

clean:
	docker-compose -f $(YAML) down
	docker-compose rm -f
	docker rmi app:latest

test: run
	sleep 10
	curl http://localhost:5000/healthcheck; echo
	curl -X POST http://127.0.0.1:5000/message -H "Content-Type: application/json" --data '{"message": "hi"}'; echo
	curl http://127.0.0.1:5000/message/1; echo
	docker-compose down

default: build
