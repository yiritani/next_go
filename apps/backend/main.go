package main

import (
	"context"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5/pgxpool"
	"net/http"
	"os"
	"time"
	db "tutorial.sqlc.dev/app/src/sqlc"
)

var pool *pgxpool.Pool

func dbSel(c *gin.Context) {
	q := db.New(pool)
	resultSet, err := q.GetSystemUsers(context.Background())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, resultSet)
}

func main() {
	connString := "user=postgres password=password host=db port=5432 dbname=postgres sslmode=disable"
	var err error
	pool, err = pgxpool.New(context.Background(), connString)
	if err != nil {
		panic(err)
		os.Exit(1)
	}
	defer pool.Close()

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
	err = r.Run()
	if err != nil {
		return
	}
}
