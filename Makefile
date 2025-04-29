.PHONY: build
build:
	@docker build --tag nvim-dev-base:latest .

.PHONY: start-dev
start-dev:
	@docker run -dit --name nvim-dev nvim-dev-base:latest

.PHONY: run-init-script
run-init-script:
	@docker exec -it nvim-dev /scripts/initialize-tooling.sh

.PHONY: commit-dev
commit-dev:
	@docker commit nvim-dev nvim-dev-final:latest

.PHONY: cleanup-dev
cleanup-dev:
	@docker rm -f nvim-dev

.PHONY: run-final
run-final:
	@docker run -it --rm --network none --name nvim-dev-final nvim-dev-final:latest /scripts/entrypoint.sh

.PHONY: create-final
create-final: build start-dev run-init-script commit-dev cleanup-dev run-final 

.PHONY: shell
shell:
	@docker exec -it nvim-dev-final /scripts/entrypoint.sh

.PHONY: cleanup
cleanup:
	@docker rm -f nvim-dev
	@docker rm -f nvim-dev-final