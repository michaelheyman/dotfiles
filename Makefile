IMAGE_NAME=dotfiles

.PHONY: docker-build
docker-build: ## Build docker image
	docker build -t ${IMAGE_NAME} .

.PHONY: docker-clean
docker-clean: ## Clean docker image
	docker rmi -f ${IMAGE_NAME} .

.PHONY: docker-build
docker-run: docker-build ## Run docker image
	docker run -it --entrypoint sh ${IMAGE_NAME}

.DEFAULT_GOAL := help
help:
	@grep -E '^[^: ]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
