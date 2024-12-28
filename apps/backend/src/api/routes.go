package api

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"tutorial.sqlc.dev/app/src/controllers"
)

func (server *Server) Routes() {
	route := server.Router
	route.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})

	apiRouteV1 := route.Group("/api/v1")
	server.userRoutes(apiRouteV1)
}

func (server *Server) userRoutes(route *gin.RouterGroup) {
	userRoute := route.Group("/user")

	userRoute.GET("/list", func(c *gin.Context) {
		controllers.ControllerListUsers(*server.Queries, c)
	})
}
