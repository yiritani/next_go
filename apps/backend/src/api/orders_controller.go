package api

import (
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"strconv"
	"tutorial.sqlc.dev/app/src/services"
)

func (server *Server) ControllerGetOrdersByUserId(ctx *gin.Context) {
	userIdParam := ctx.Param("userId")
	userId, err := strconv.ParseInt(userIdParam, 10, 64)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": "Invalid user id",
		})
		log.Fatalln(err)
	}

	orders, err := services.ServiceGetOrdersByUserId(*server.Queries, ctx, userId)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		log.Fatalln(err)
	}

	ctx.JSON(http.StatusOK, gin.H{
		"orders": orders,
	})
}
