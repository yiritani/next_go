package api

import (
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"net/http"
	"time"
	"tutorial.sqlc.dev/app/src/sqlc"
)

type Server struct {
	router  *gin.Engine
	Queries *sqlc.Queries
	conn    *pgx.Conn
}

// func NewServer(pool *pgxpool.Pool, conn *pgx.Conn) *Server {
func NewServer() *Server {
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

	//set CORS header

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})
	//r.GET("/list-systems", server.listSystems)
	//r.POST("/create-system", server.createSystem)

	server.router = r
	return server
}

func (server *Server) Run() error {
	return server.router.Run()
}

func errorResponse(c *gin.Context, code int, message string) {
	c.JSON(code, gin.H{
		"error": message,
	})
}
