package controllers

import (
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"tutorial.sqlc.dev/app/src/services"
	"tutorial.sqlc.dev/app/src/sqlc"
)

func ControllerListUsers(queries sqlc.Queries, ctx *gin.Context) {
	users, err := services.ServiceGetAllUsers(queries, ctx)
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
