package api

import (
	"context"
	"github.com/gin-gonic/gin"
	"net/http"
	"tutorial.sqlc.dev/app/src/lib"
	"tutorial.sqlc.dev/app/src/sqlc"
)

func (server *Server) listSystems(c *gin.Context) {
	lib.Msging("getSystemUsers")
	resultSet, err := server.Queries.ListSystems(context.Background(), sqlc.ListSystemsParams{
		Limit:  10,
		Offset: 0,
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, resultSet)
}
