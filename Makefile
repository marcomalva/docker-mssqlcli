# Makefile to build mssqlcli docker image
# The **current version** is defined in Dockerfile as LABEL version=
#
# Usage:
#
#    # local build current VERSION as set in Dockerfile
#    make build
#
#    # local build but force using docker even if podman is installed
#    DOCKER=docker make build
#
#    # print version as set in Dockerfile
#    make print-version
#
ifndef TAG
	# previously: was using a version file for current version
	# TAG=$(shell cat VERSION)
	#
	# now tracking VERSION in Dockerfile LABEL version="..."
	TAG := $(shell grep '^LABEL version=' Dockerfile | awk -F\= '{print $$2}' | head -n 1 | tr -d '"')
endif

# switch between docker and podman executable, use podman if installed and DOCKER env var not set
PODMAN_VERSION := $(shell podman -v 2>/dev/null)
ifdef PODMAN_VERSION
	DOCKER ?= podman
else
	DOCKER ?= docker
endif


# build local docker image (e.g. testing)
.PHONY: build
build: verify print-version
	$(DOCKER) build -t mssqlcli:$(TAG) .

.PHONY: print-version
print-version: Dockerfile
	echo -n "Dockerfile version: "; grep '^LABEL version=' Dockerfile | awk -F\= '{print $$2}' | tr -d '"'

.PHONY: verify
verify:
	echo "TAG=$(TAG)"
	@test -n "$(TAG)" || (echo "TAG is required" && false)

