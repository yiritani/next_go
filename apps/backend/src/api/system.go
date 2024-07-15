package api

import (
	"context"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
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

type listSystemsParams struct {
	Limit  int64 `json:"limit"`
	Offset int64 `json:"offset"`
}

func (server *Server) listSystems(c *gin.Context) {
	var req listSystemsParams
	if err := c.ShouldBindQuery(&req); err != nil {
		errorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	limit, err := strconv.ParseInt(c.DefaultQuery("limit", "10"), 10, 64)
	offset, err := strconv.ParseInt(c.DefaultQuery("offset", "1"), 10, 64)

	resultSet, err := server.Queries.ListSystems(context.Background(), sqlc.ListSystemsParams{
		Limit:  limit,
		Offset: offset,
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, resultSet)
}
