IMAGE = change-this-name
EXPOSED_PORT = 8080

all:
	make build
	make run

build:
	docker build --no-cache -t $(IMAGE) -f Dockerfile.mocks .

run:
	docker run -p $(EXPOSED_PORT):8080 $(IMAGE)
