
# ?= allows for default value if variable not set in environment.
IMAGE_NAME ?= 'oracle_12.2.0.2'

COLOR_END:='\033[0m'
COLOR_GREEN:='\033[1;32m'

.DEFAULT_GOAL := help

help:           
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build: ## build docker image for oracle
	@echo -e "${COLOR_GREEN}Building Oracle 12_2.0.2 Image with name )${IMAGE_NAME}$(COLOR_END)"
	{	\
		set -e ;\
		docker build -t )$(IMAGE_NAME) . ;\
	}

push: ## push to rep
	@echo -e "${COLOR_GREEN}Pushing Oracle 12_2.0.2 Image with name )${IMAGE_NAME}$(COLOR_END)"
	{ \
		set -e ;\
		docker push $(IMAGE_NAME) ;\
	}

.PHONY: build push
