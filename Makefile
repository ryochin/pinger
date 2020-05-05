PROJECT = pinger

check: format credo dialyzer  ## Check sources

compile: format  ## Compile sources
	@mix compile

clean:  ## Cleanup generated files
	@mix clean

format:  ## Format sources
	@mix format

credo:  ## Run credo check
	@mix credo --all --format=oneline

dialyzer: compile  ## Run dialyzer
	@mix dialyzer

test::  ## Run test suites
	@mix test --trace --stale

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-32s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
