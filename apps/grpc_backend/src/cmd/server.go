package cmd

import (
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"grpc_backend/src/_generated/proto/v1/proto_v1connect"
	"grpc_backend/src/sqlc"
	"log"
	"net/http"

	connectcors "connectrpc.com/cors"
	"github.com/rs/cors"
)

type Server struct {
	Mux     *http.ServeMux
	Queries *sqlc.Queries
}

func NewServer(queries *sqlc.Queries) *Server {
	server := &Server{}

	mux := http.NewServeMux()

	server.Mux = mux
	server.Queries = queries

	ping := &PingServer{}
	path, handler := proto_v1connect.NewPingServiceHandler(ping)
	mux.Handle(path, handler)
	user := &UserServer{
		Queries: queries,
	}
	path, handler = proto_v1connect.NewUserServiceHandler(user)
	mux.Handle(path, handler)
	order := &OrderServer{
		Queries: queries,
	}
	path, handler = proto_v1connect.NewOrdersServiceHandler(order)
	mux.Handle(path, handler)

	corsHandler := withCORS(h2c.NewHandler(mux, &http2.Server{}))

	if err := http.ListenAndServe(":8080", corsHandler); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
	return server
}

func withCORS(h http.Handler) http.Handler {
	middleware := cors.New(cors.Options{
		// TODO: 言わずもがな
		AllowedOrigins: []string{"*"},
		AllowedMethods: connectcors.AllowedMethods(),
		AllowedHeaders: connectcors.AllowedHeaders(),
		ExposedHeaders: connectcors.ExposedHeaders(),
	})
	return middleware.Handler(h)
}
