.PHONY: build
build:
	@echo "Building image..."
	@docker build --network host --tag dc-base:latest .

.PHONY: start-dev
start-dev:
	@echo "Start base image"
	@docker run --network host -dit --name dc-base dc-base:latest

.PHONY: run-init-script
run-init-script:
	@docker exec -it dc-base /scripts/initialize-tooling.sh

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
	@sudo docker run --network none -it -v ./:/home/dev/dev -w /home/dev/dev --rm -e PUID=622838456 -e PGID=622800513 --name dc dc /scripts/entrypoint.sh

.PHONY: cleanup
cleanup:
	@docker rm -f dc
	@docker rm -f dc-base

.PHONY: rm-images
rm-images:
	@docker image rm -q dc-base:latest dc:latest
