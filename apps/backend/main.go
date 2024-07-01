package main

import (
	"context"
	"github.com/jackc/pgx/v5"
	"net/http"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

type SelectedData struct {
	id   int
	name string
}

const (
	dbDriver = "postgres"
	dbSource = "postgresql://postgres:password@localhost:5432/db?sslmode=disable"
)

func (s *SelectedData) SelectAll() (SelectedData, error) {
	conn, err := pgx.Connect(context.Background(), dbSource)
	if err != nil {
		return SelectedData{}, err
	}

	dst := SelectedData{}
	err = conn.QueryRow(context.Background(), "SELECT id, name FROM initial_table WHERE id=1").Scan(&dst.id, &dst.name)

	return dst, nil
}

func dbSel(c *gin.Context) {
	s := SelectedData{}
	dst, err := s.SelectAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"message": err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"id":   dst.id,
		"name": dst.name,
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
