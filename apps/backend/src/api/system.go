package api

import (
	"context"
	"github.com/gin-gonic/gin"
	"net/http"
	"tutorial.sqlc.dev/app/src/lib"
)

type createSystemParams struct {
	SystemName string `json:"system_name" binding:"required"`
}

func (server *Server) createSystem(c *gin.Context) {
	lib.Msging("createSystem")

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
