.SILENT:
.PHONY: convert test

help:
	{ grep --extended-regexp '^[a-zA-Z_-]+:.*#[[:space:]].*$$' $(MAKEFILE_LIST) || true; } \
	| awk 'BEGIN { FS = ":.*#[[:space:]]*" } { printf "\033[1;32m%-22s\033[0m%s\n", $$1, $$2 }'

env-create: # 1) create .env file
	./make.sh env-create

terraform-init: # 2) terraform init (updgrade) + validate
	./make.sh terraform-init

terraform-create: # 2) terraform create ecr repo + setup .env file
	./make.sh terraform-create

convert: # 3) run convert server using npm - dev mode
	./make.sh convert

test: # 3) test convert
	./make.sh test

dev-build: # 4) build convert-dev image
	./make.sh dev-build

dev-run: # 4) run convert-dev image
	./make.sh dev-run

dev-stop: # 4) stop convert-dev container
	./make.sh dev-stop

prod-build: # 4) build convert image
	./make.sh prod-build

prod-run: # 4) run convert image
	./make.sh prod-run

prod-stop: # 4) stop convert container
	./make.sh prod-stop

update-patch: # 4) update patch version
	./make.sh update-patch

ecr-push: # 5) push convert image to ecr
	./make.sh ecr-push

ecr-run: # 5) run latest image pushed to ecr
	./make.sh ecr-run

increase-build-push: # 5) update-patch + ecr-push
	./make.sh increase-build-push

terraform-destroy: # 6) terraform destroy ecr repo + setup .env file
	./make.sh terraform-destroy

clear: # 6) clear docker images
	./make.sh clear
