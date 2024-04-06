SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.PHONY: all
all:

.PHONY: venv
venv:
	source ./venv/bin/activate

.PHONY: mksite
mksite: venv site
	mkdocs build -d site
	cp CNAME site/

site:
	git clone git@github.com:tnosse/tnosse.github.io.git site
	git -C site switch site

.PHONY: publish
publish: mksite
	git -C site add .
	git -C site commit -m "Publish"
	git -C site push
