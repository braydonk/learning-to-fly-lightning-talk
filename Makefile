IMAGE_NAME=otel_scenarios

.PHONY: build
build:
	docker build -t ${IMAGE_NAME} .

.PHONY: run
run:
	docker run -ti --init ${IMAGE_NAME}

.PHONY: build_random_server
build_random_server:
	cd random_server && go build random_server.go

