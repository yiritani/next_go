package api

import (
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"tutorial.sqlc.dev/app/src/services"
)

func (server *Server) ControllerListUsers(ctx *gin.Context) {
	users, err := services.ServiceGetAllUsers(*server.Queries, ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		log.Fatalln(err)
	}

	ctx.JSON(http.StatusOK, gin.H{
		"users": users,
	})
}
