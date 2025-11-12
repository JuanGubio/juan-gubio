.PHONY: build run db deploy clean

IMAGE_NAME=juan-gubio
IMAGE_VERSION=1.0.1

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

run:
	docker run -p 8080:8080 $(IMAGE_NAME):$(IMAGE_VERSION)

db:
	docker-compose -f stack.yml up -d

stop-db:
	docker-compose -f stack.yml down

deploy:
	./deploy_all.sh

clean:
	docker rmi $(IMAGE_NAME):$(IMAGE_VERSION) || true
	docker-compose -f stack.yml down --volumes --remove-orphans || true