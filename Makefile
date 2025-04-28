.PHONY: build
build:
	@docker build --tag nvim-dev-base:latest .

.PHONY: run
run:
	@docker run -dit --name nvim-dev nvim-dev-base:latest

.PHONY: init-nvim
init-nvim:
	@docker exec -it nvim-dev /scripts/init-nvim.sh

.PHONY: shell
shell:
	@docker exec -it nvim-dev /scripts/entrypoint.sh

.PHONY: start
start: build run init-nvim

.PHONY: commit
commit:
	@docker commit nvim-dev nvim-dev-final:latest

.PHONY: run-final
run-final:
	@docker run -it --rm --network none --name nvim-dev-final nvim-dev-final:latest /scripts/entrypoint.sh

.PHONY: destroy
destroy:
	@docker rm -f nvim-dev