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
