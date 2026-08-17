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
		rm -rf out/pgdata && \
		echo "pgdata removed successfully"; \
	else \
		echo "pgdata removal aborted"; \
	fi

migrate-create:
	@if [ -z "$(seq)" ]; then \
		echo "SEQ is not set. Cannot run migrations. Example: make migrate-create seq=init"; \
		exit 1; \
	fi

	docker compose run --rm todoapp-postgres-migrate \
		create \
		-ext sql \
		-dir /migrations \
		-seq "$(seq)"