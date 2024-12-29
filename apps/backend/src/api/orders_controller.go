package api

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"strconv"
	"tutorial.sqlc.dev/app/src/services"
	"tutorial.sqlc.dev/app/src/sqlc"
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

func (server *Server) ControllerCreateOrder(ctx *gin.Context) {
	var order sqlc.InsertOrderParams
	if err := ctx.ShouldBindJSON(&order); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		fmt.Println("Bind Error: ", err)
		return
	}

	newOrder, err := services.ServiceCreateOrder(*server.Queries, ctx, order)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusCreated, gin.H{"order": newOrder})
}
