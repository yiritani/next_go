package controller

import (
	connectcors "connectrpc.com/cors"
	"github.com/rs/cors"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"grpc_backend/src/_generated/proto/protoconnect"
	"grpc_backend/src/sqlc"
	"log"
	"net/http"
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
	path, handler := protoconnect.NewPingServiceHandler(ping)
	mux.Handle(path, handler)
	user := &UserServer{
		Queries: queries,
	}
	path, handler = protoconnect.NewUserServiceHandler(user)
	mux.Handle(path, handler)
	order := &OrderServer{
		Queries: queries,
	}
	path, handler = protoconnect.NewOrdersServiceHandler(order)
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
