.PHONY: init plan clean

ACCOUNT_ID = $(shell aws sts get-caller-identity | jq -r '.Account')
TERRAFORM_STATE_BUCKET_NAME = mfreccia-tfstate-$(ACCOUNT_ID)

ENVS = $(sort $(foreach dir,$(shell find env -type d ! -path env -maxdepth 1),$(subst env/,,$(dir))))
DEFAULT_ENV = prd

ifeq ($(ENV),)
ENV := $(DEFAULT_ENV)
endif

ifeq ($(filter $(ENV),$(ENVS)),)
  $(error Invalid env "$(ENV)". Available envs are $(ENVS))
endif

REGIONS = $(sort $(foreach dir,$(shell find env/$(ENV) -type d ! -path env/$(ENV)),$(subst env/$(ENV)/,,$(dir))))
DEFAULT_REGION = eu-central-1

ifeq ($(REGION),)
 REGION := $(DEFAULT_REGION)
endif

init:
	terraform init -backend-config=./env/$(ENV)/$(REGION)/backend.conf -reconfigure
	@echo $(ENVS)
	@echo $(dir)


plan:
	terraform plan --var-file=./env/$(ENV)/$(REGION)/variables.tfvars




apply: plan		## Applies plan
	terraform apply --auto-approve  -var-file=./env/$(ENV)/$(REGION)/variables.tfvars