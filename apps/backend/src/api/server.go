package api

import (
	"net/http"
	"os"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5/pgxpool"
	"tutorial.sqlc.dev/app/src/sqlc"
	"tutorial.sqlc.dev/app/src/token"
)

type Server struct {
	router  *gin.Engine
	Queries *sqlc.Queries
	tokenMaker token.Maker
}

func NewServer(pool *pgxpool.Pool) *Server {
	tokenMaker, err := token.NewPasetoMaker(os.Getenv("TOKEN_SYMMETRIC_KEY"))
	if err != nil {
		panic(err)
	}

	server := &Server{
		tokenMaker: tokenMaker,
	}

	r := gin.Default()
	r.Use(cors.New(cors.Config{
		// TODO: 環境変数
		AllowOrigins:     []string{"http://localhost:3000", "http://localhost:3001"},
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})
	r.POST("/accounts", server.createAccount)
	r.GET("/accounts/:id", server.getAccount)
	r.GET("/accounts", server.listAccount)

	server.router = r
	server.Queries = sqlc.New(pool)
	return server
}

func (server *Server) Run() error {
	return server.router.Run()
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}

