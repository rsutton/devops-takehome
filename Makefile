.PHONY: build run clean test monitor

build:
	docker build -t hello -f Dockerfile .

run: build
	docker-compose up -d

clean:
	docker-compose rm -f
	docker rmi hello:latest

test: run
	sleep 10
	curl http://localhost:5000/healthcheck; echo
	curl -X POST http://127.0.0.1:5000/message -H "Content-Type: application/json" --data '{"message": "hi"}'; echo
	curl http://127.0.0.1:5000/message/1; echo
	docker-compose down

monitor: clean
	docker-compose -f monitor.yml up -d

default: build
