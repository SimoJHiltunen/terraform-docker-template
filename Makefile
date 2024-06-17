.PHONY: build apply

###############################################
##     VARIABLES                             ##
###############################################
# Read project specific environment variables from .env file
include .env
export
# Makefile specific enviroment variables
dckr=docker
tf=terraform

build:	
ifeq ($(strip $(env)),local)
	@echo "== running $@ command in $(env) environment =="
	@$(dckr) build ./service -t ${application}:latest
else ifeq ($(strip $(env)),staging)
else ifeq ($(strip $(env)),prod)
endif

init:
ifeq ($(strip $(env)),local)
	@$(tf) -chdir=infra/local init
else ifeq ($(strip $(env)),staging)
else ifeq ($(strip $(env)),prod)
endif

apply:
ifeq ($(strip $(env)),local)
	@$(tf) -chdir=infra/local apply -auto-approve
else ifeq ($(strip $(env)),staging)
else ifeq ($(strip $(env)),prod)
endif

destroy:
ifeq ($(strip $(env)),local)
	@$(tf) -chdir=infra/local destroy -auto-approve
else ifeq ($(strip $(env)),staging)
else ifeq ($(strip $(env)),prod)
endif

logs:
ifeq ($(strip $(env)),local)
	@$(dckr) logs -f $$($(dckr) ps -aqf "name=${application}")
else ifeq ($(strip $(env)),staging)
else ifeq ($(strip $(env)),prod)
endif

	