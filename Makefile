.PHONY: interactive i update_production upgrade_production help 
.DEFAULT_GOAL := help

interactive: ## Start Vigil in interactive mode
	@iex -S mix

i: interactive

update_production: ## Deploy from the latest commit and restart the production
	aa mix edeliver update production --start-deploy

upgrade_production: ## Hot upgrade to the laster commit the production
	aa mix edeliver upgrade production

help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'