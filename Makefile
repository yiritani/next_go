postgres:
	docker run --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:latest


createdb:
	createdb -U postgres -h localhost -p 5432 -e -O postgres -T template0 -E UTF8 -l en_US.UTF-8

migrate_up:
	cd apps/backend/src && migrate -path db/migration -database "postgresql://postgres:password@localhost:5432/postgres?sslmode=disable" -verbose up

migrate_down:
	cd apps/backend/src && migrate -path db/migration -database "postgresql://postgres:password@localhost:5432/postgres?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	cd apps/backend && air -c .air.toml

protoc_go:
	protoc -I. --go_out=./apps/job/src/ --go-grpc_out=./apps/job/src/ proto/*.proto && protoc -I. --go_out=./apps/backend/src/ --go-grpc_out=./apps/backend/src/ proto/*.proto
