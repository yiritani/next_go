package main

import (
	"connectrpc.com/connect"
	connectcors "connectrpc.com/cors"
	"context"
	"example/gen/proto"
	"example/gen/proto/protoconnect"
	"github.com/rs/cors"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"log"
	"net/http"
)

type PingServer struct{}

func (p *PingServer) Ping(
	ctx context.Context,
	req *connect.Request[proto.PingRequest],
) (*connect.Response[proto.PingResponse], error) {
	log.Println("Ping")
	res := connect.NewResponse(&proto.PingResponse{
		Message: "Pong",
	})
	res.Header().Set("Content-Type", "application/json")
	return res, nil
}

func main() {
	ping := &PingServer{}
	mux := http.NewServeMux()
	path, handler := protoconnect.NewPingServiceHandler(ping)
	mux.Handle(path, handler)
	corsHandler := withCORS(h2c.NewHandler(mux, &http2.Server{}))

	if err := http.ListenAndServe("localhost:8080", corsHandler); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}

func withCORS(h http.Handler) http.Handler {
	middleware := cors.New(cors.Options{
		AllowedOrigins: []string{"*"},
		AllowedMethods: connectcors.AllowedMethods(),
		AllowedHeaders: connectcors.AllowedHeaders(),
		ExposedHeaders: connectcors.ExposedHeaders(),
	})
	return middleware.Handler(h)
}
