package api

import (
	"context"
	"github.com/gin-gonic/gin"
	"net/http"
	"tutorial.sqlc.dev/app/src/sqlc"
)

type createSystemParams struct {
	SystemName string `json:"system_name" binding:"required"`
}

func (server *Server) createSystem(c *gin.Context) {
	var req createSystemParams
	if err := c.ShouldBindJSON(&req); err != nil {
		errorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	result, err := server.Queries.InsertSystem(context.Background(), req.SystemName)
	if err != nil {
		errorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, result)
}

func (server *Server) listSystems(c *gin.Context) {
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
