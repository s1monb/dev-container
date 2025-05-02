.PHONY: build
build:
	@echo "Building image..."
	@docker build --tag dc-base:latest .

.PHONY: start-dev
start-dev:
	@echo "Start base image"
	@docker run -dit --name dc-base dc-base:latest

.PHONY: run-init-script
run-init-script:
	@echo "Run init-script to install dependencies"
	@docker exec -it -t dc-base /scripts/initialize-tooling.sh

.PHONY: commit-dev
commit-dev:
	@echo "Commit the image"
	@docker commit dc-base dc:latest

.PHONY: cleanup-dev
cleanup-dev:
	@docker rm -f dc-base

.PHONY: create-final
create-final: build start-dev run-init-script commit-dev cleanup-dev 

.PHONY: shell
shell:
	@sudo docker run --network none -it -v ./:/home/ubuntu/dev --rm -e PUID=1000 -e PGID=1000 --name dc dc /scripts/entrypoint.sh

.PHONY: cleanup
cleanup:
	@docker rm -f dc
	@docker rm -f dc-base
