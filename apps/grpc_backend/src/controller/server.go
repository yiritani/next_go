package controller

import (
	"google.golang.org/grpc"
	"grpc_backend/src/pb"
	"grpc_backend/src/sqlc"
	"log"
	"net"
)

type Server struct {
	Server  *grpc.Server
	Queries *sqlc.Queries
}

func NewServer(queries *sqlc.Queries) *Server {
	server := &Server{}

	s := grpc.NewServer()

	server.Server = s
	server.Queries = queries
	userSrv := &UsersServer{
		Queries: queries,
	}
	pb.RegisterUsersServiceServer(server.Server, userSrv)
	orderSrv := &OrdersServer{
		Queries: queries,
	}
	pb.RegisterOrdersServiceServer(server.Server, orderSrv)

	return server
}

func (server *Server) Run(port string) error {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	log.Println("Listening on " + port + "...")

	if err := server.Server.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}

	return nil
}
