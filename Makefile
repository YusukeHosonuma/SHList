EFAULT_GOAL := help
HELP_INDENT := "20"

# ref: https://postd.cc/auto-documented-makefile/
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-$(HELP_INDENT)s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## Install requirement development tools to system and setup (not include Xcode 11.3)
	brew bundle
	pre-commit install

.PHONY: open
open: ## Open Xcode 11.3
	open "/Applications/Xcode-11.3.app" SHList.xcodeproj

.PHONY: build
build: ## Run build
	echo "" > Sources/SHList/SHList.swift
	swift build

.PHONY: generate
generate: build ## Generate source
	.build/debug/SHListGen

.PHONY: test
test: ## Run tests
	swift test --enable-test-discovery

.PHONY: xcode
xcode: ## swift - generate xcode project
	swift package generate-xcodeproj

.PHONY: lint
lint: ## cocoapods - lint podspec
	bundle exec pod lib lint

.PHONY: release
release: ## cocoapods - release
	bundle exec pod trunk push SHList.podspec

.PHONY: info
info: ## cocoapods - show trunk information
	bundle exec pod trunk info SHList

.PHONY: integration-test
integration-test: ## Integration test by Example app
	cd ./Example && \
	rm Podfile && \
	mv Podfile_IntegrationTest Podfile && \
	bundle exec pod update && \
	bundle exec fastlane test

#
# Development for Linux
#

.PHONY: linux
linux: ## Run and login docker container
	docker run --rm -it \
		--volume "$(CURDIR):/src" \
		--workdir "/src" \
		swift:5.1

.PHONY: linux-test
linux-test: ## Run tests on linux in docker
	docker run --rm \
		--volume "$(CURDIR):/src" \
		--workdir "/src" \
		swift:5.1 \
		swift test --enable-test-discovery
