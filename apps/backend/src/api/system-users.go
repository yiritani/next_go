package api

import (
	"context"
	"github.com/gin-gonic/gin"
	"net/http"
	"tutorial.sqlc.dev/app/src/lib"
)

func (server *Server) getSystemUsers(c *gin.Context) {
	lib.Msging("getSystemUsers")
	resultSet, err := server.Queries.GetSystemUsers(context.Background())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, resultSet)
}
