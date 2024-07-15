package api

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5/pgtype"
	"net/http"
	"tutorial.sqlc.dev/app/src/sqlc"
)

type joinSystemParams struct {
	SystemID   pgtype.UUID     `json:"system_id" binding:"required"`
	UserID     pgtype.UUID     `json:"user_id" binding:"required"`
	SystemRole sqlc.SystemRole `json:"system_role" binding:"required"`
}

func (server *Server) joinSystem(c *gin.Context) {
	var req joinSystemParams
	if err := c.ShouldBindJSON(&req); err != nil {
		errorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	_, err := server.Queries.InsertSystemUserRelation(context.Background(), sqlc.InsertSystemUserRelationParams{
		SystemID:   req.SystemID,
		UserID:     req.UserID,
		SystemRole: req.SystemRole,
	})
	if err != nil {
		errorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"message": "User joined system successfully",
	})
}

type createJoinSystemParams struct {
	SystemID   pgtype.UUID     `json:"system_id" binding:"required"`
	User       sqlc.User       `json:"user" binding:"required"`
	SystemRole sqlc.SystemRole `json:"system_role" binding:"required"`
}

func (server *Server) createJoinSystemUser(c *gin.Context) {
	var req createJoinSystemParams
	if err := c.ShouldBindJSON(&req); err != nil {
		errorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
}
