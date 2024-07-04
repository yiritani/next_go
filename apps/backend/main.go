package main

import (
	"context"
	"net/http"
	"time"

	"github.com/jackc/pgx/v5"
	"tutorial.sqlc.dev/app/src/sqlc"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func dbSel(c *gin.Context) {
	ctx := context.Background()

	conn, _ := pgx.Connect(ctx, "user=postgres dbname=public sslmode=verify-full")
	defer conn.Close(ctx)

	queries := sqlc.New(conn)

	system, _ := queries.ListSystems(ctx)
	println(system)

	c.JSON(http.StatusOK, gin.H{
		"message": "pong",
	})
}

func main() {
	r := gin.Default()
	r.Use(cors.New(cors.Config{
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
	r.GET("/db-sel", dbSel)
	r.Run()
}
