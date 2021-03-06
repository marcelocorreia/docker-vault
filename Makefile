REPOSITORY=docker-vault
CONTAINER=vault
NAMESPACE=marcelocorreia
VERSION=$(shell cat version)
PIPELINE_NAME=$(REPOSITORY)-release
CI_TARGET=dev

update-version:
	cat Dockerfile | sed  's/ARG version=".*"/ARG version="$(VERSION)"/' > /tmp/Dockerfile.tmp
	cat /tmp/Dockerfile.tmp > Dockerfile
	rm /tmp/Dockerfile.tmp
.PHONY: update-version

build:
	docker build -t $(NAMESPACE)/$(CONTAINER):latest .
.PHONY: build

git-push:
	git add .; git commit -m "Pipeline WIP"; git push

set-pipeline: git-push
	fly -t $(CI_TARGET) set-pipeline \
		-n -p $(PIPELINE_NAME) \
		-c pipeline.yml \
		-l $(HOME)/.ssh/ci-credentials.yml \
		-v git_repo_url=git@github.com:$(NAMESPACE)/$(REPOSITORY).git \
        -v container_fullname=$(NAMESPACE)/$(CONTAINER) \
        -v container_name=$(CONTAINER) \
		-v git_repo=$(REPOSITORY) \
        -v git_branch=master \
        -v release_version=$(VERSION)

	fly -t $(CI_TARGET) unpause-pipeline -p $(PIPELINE_NAME)
	fly -t $(CI_TARGET) trigger-job -j $(PIPELINE_NAME)/$(PIPELINE_NAME)
	fly -t $(CI_TARGET) watch -j $(PIPELINE_NAME)/$(PIPELINE_NAME)
.PHONY: set-pipeline


watch-pipeline:
	fly -t $(CI_TARGET) watch -j $(PIPELINE_NAME)/$(PIPELINE_NAME)
.PHONY: watch-pipeline

destroy-pipeline:
	fly -t $(CI_TARGET) destroy-pipeline -p $(PIPELINE_NAME)
.PHONY: destroy-pipeline

docs:
	grip -b




