stop:
	docker-compose down --remove-orphans

prod: stop
	STAGE=prod docker-compose up --build

dev: stop
	STAGE=dev docker-compose up --build

devd: stop
	STAGE=dev docker-compose up --build -d

devtest:
	docker-compose exec pento mix test

local:
	MAILGUN_BASE_URL=https://api.eu.mailgun.net/v3 \
	MAILGUN_DOMAIN=mg.playconcepts.co.uk \
	MAILGUN_API_KEY=key-8948f4bdd570d8d04bb3b836e1cfabfc \
	iex -S mix phx.server

format:
	docker-compose exec pento mix format

mix:
	docker-compose exec pento mix ${COMMAND}

console:
	echo "iex --sname console --cookie monster --remsh dev@docker_id"
	docker-compose exec pento bash

psql:
	docker-compose exec db psql -U postgres -d pento
