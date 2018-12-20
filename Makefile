.PHONY: deps
deps: mix.exs mix.lock
	@mix deps.get

.PHONY: interactive
interactive: deps docker_up ## Start Vigil in interactive mode
	@iex -S mix

.PHONY: i
i: interactive

.PHONY: docker_up
docker_up:
	@docker-compose up -d

.PHONY: update_production
update_production: docker_up deps ## Deploy from the latest commit and restart the production
	aa mix edeliver update production --start-deploy

.PHONY: upgrade_production
upgrade_production: docker_up deps ## Hot upgrade to the laster commit the production
	aa mix edeliver upgrade production

.PHONY: help
.DEFAULT_GOAL := help
help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'