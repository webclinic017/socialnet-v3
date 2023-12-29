ifneq (,$(wildcard ./.env))
include .env
export 
ENV_FILE_PARAM = --env-file .env

endif

build:
	docker-compose up --build -d --remove-orphans

up:
	docker-compose up -d

down:
	docker-compose down

show-logs:
	docker-compose logs

serv:
	uvicorn app.main:app --reload

mmig: ## Run migrations. Use "make mmig app='app'" or "make mmig app='app' message='App migrated'"
	piccolo migrations new ${app} --auto ${if $(message),--desc=${message}}
	
mig:
	piccolo migrations forwards all

initial_data:
	python initials/initial_data.py

tests:
	pytest --disable-warnings -vv -x

reqm:
	pip install -r requirements.txt

ureqm:
	pip freeze > requirements.txt