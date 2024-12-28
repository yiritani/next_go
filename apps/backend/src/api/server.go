package api

import (
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"time"
	"tutorial.sqlc.dev/app/src/sqlc"
)

type Server struct {
	Router  *gin.Engine
	Queries *sqlc.Queries
}

func NewServer(queries *sqlc.Queries) *Server {
	server := &Server{}

	r := gin.Default()
	r.Use(cors.New(cors.Config{
		// TODO: 環境変数
		AllowOrigins: []string{"http://localhost:3000", "http://localhost:3001", "*"},
		AllowMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders: []string{
			"Access-Control-Allow-Credentials",
			"Access-Control-Allow-Headers",
			"Content-Type",
			"Content-Length",
			"Accept-Encoding",
			"Authorization",
		},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	server.Router = r
	server.Queries = queries

	return server
}

func (server *Server) Run(port string) error {
	return server.Router.Run(port)
}

func errorResponse(c *gin.Context, code int, message string) {
	c.JSON(code, gin.H{
		"error": message,
	})
}
