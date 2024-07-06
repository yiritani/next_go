package api

import (
	"context"
	"github.com/gin-gonic/gin"
	"net/http"
	"tutorial.sqlc.dev/app/src/lib"
)

type CreateSystemParams struct {
	SystemName string `json:"system_name"`
}

func (server *Server) createSystem(c *gin.Context) {
	lib.Msging("createSystem")
	result, err := server.Queries.CreateSystem(context.Background(), "aaa")
	if err != nil {
		errorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, result)
}
