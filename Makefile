network:
	docker network create escola-network

postgres:
	docker run --name postgres-db -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret --rm -d postgres:14-alpine

postgress:
	docker run --name postgres-db2 -p 5433:5433 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:13

mysql:
	docker run --name mysql8 -p 3306:3306  -e MYSQL_ROOT_PASSWORD=secret -d mysql:8

createdb:
	docker exec -it postgres-db  createdb --username=root --owner=root projeto_escola

dropdb:
	docker exec -it postgres-db dropdb projeto_escola

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/projeto_escola?sslmode=disable" -verbose up

migrateup2:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/projeto_escola?sslmode=disable" -verbose up 2

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/projeto_escola?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1

db_docs:
	dbdocs build doc/db.dbml

db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/techschool/simplebank/db/sqlc Store

proto:
	rm -f pb/*.go
	rm -f doc/swagger/*.swagger.json
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
	--go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	--grpc-gateway_out=pb --grpc-gateway_opt=paths=source_relative \
	--openapiv2_out=doc/swagger --openapiv2_opt=allow_merge=true,merge_file_name=simple_bank \
	proto/*.proto
	statik -src=./doc/swagger -dest=./doc

evans:
	evans --host localhost --port 9090 -r repl

initschema:
	migrate create -ext sql -dir db/migration -seq init_schema

.PHONY: network postgres createdb dropdb migrateup migratedown migrateup2 migratedown1 db_docs db_schema sqlc test server mock proto evans initschema
