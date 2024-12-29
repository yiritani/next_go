package api

import (
	"github.com/gin-gonic/gin"
	"net/http"
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
	server.orderRoutes(apiRouteV1)
}

func (server *Server) userRoutes(route *gin.RouterGroup) {
	userRoute := route.Group("/user")

	userRoute.GET("/list", server.ControllerListUsers)
}

func (server *Server) orderRoutes(route *gin.RouterGroup) {
	orderRoute := route.Group("/order")

	orderRoute.GET("/user/:userId", server.ControllerGetOrdersByUserId)
	orderRoute.POST("/create", server.ControllerCreateOrder)
}
