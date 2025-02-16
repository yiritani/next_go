postgres:
	docker run --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:latest


createdb:
	createdb -U postgres -h localhost -p 5432 -e -O postgres -T template0 -E UTF8 -l en_US.UTF-8

migrate_up:
	#cd apps/backend/src && migrate -path db/migration -database "postgresql://postgres:password@localhost:5432/postgres?sslmode=disable" -verbose up
	cd apps/backend && migrate -database "sqlite://db.sqlite" -path src/db/migration up

migrate_down:
	#cd apps/backend/src && migrate -path db/migration -database "postgresql://postgres:password@localhost:5432/postgres?sslmode=disable" -verbose down
	cd apps/backend && migrate -database "sqlite://db.sqlite" -path src/db/migration down

sqlc:
	cd apps/backend && sqlc generate

sqlc_grpc:
	cd apps/grpc_backend && sqlc generate

test:
	go test -v -cover ./...

server:
	cd apps/backend && air -c .air.toml

protoc_frontend:
	cd apps/frontend && sh buf_gen.sh
protoc_go:
	cd apps/grpc_backend && buf generate
protoc_job:
	protoc -I. --go_out=./apps/job/src/ --go-grpc_out=./apps/job/src/ proto/*.proto

pull_protos:
	git subtree pull --prefix=protos git@github.com:yiritani/next_go_proto.git main --squash
