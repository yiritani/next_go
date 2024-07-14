postgres:
	docker run --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:latest

createdb:
	createdb -U postgres -h localhost -p 5432 -e -O postgres -T template0 -E UTF8 -l en_US.UTF-8

# コマンドに環境変数が必要だが、ここにコマンドを定義するとローカルマシンの環境変数を見に行ってしまう。故にshellをコンテナにcopyしてそのshellを実行している
#migrate_up:
#	docker compose exec backend migrate -path src/db/migration -database "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:5432/postgres?sslmode=disable" -verbose up
migrate_up:
	docker compose exec backend sh scripts/migrate.sh -u
migrate_down:
	docker compose exec backend sh scripts/migrate.sh -d
migrate_up_test:
	docker compose exec backend sh scripts/migrate.sh -u -t
migrate_down_test:
	docker compose exec backend sh scripts/migrate.sh -d -t

sqlc:
	docker compose exec backend sqlc generate

test:
	cd apps/backend && go test -v -cover ./...
