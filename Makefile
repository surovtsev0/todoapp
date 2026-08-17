include .env
export

export PROJECT_ROOT=$(shell pwd)

env-up:
	@docker compose up -d todoapp-postgres 

env-down:
	@docker compose down todoapp-postgres 
	
env-cleanup:
	@read -p "Clean all volume data files [y/n]: " ans; \
	if [ "$$ans" = "y" ]; then \
		docker compose down todoapp-postgres && \
		rm -rf out/data && \
		echo "pgdata removed successfully"; \
	else \
		echo "pgdata removal aborted"; \
	fi