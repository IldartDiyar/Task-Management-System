package entity

import (
	"github.com/dgrijalva/jwt-go"
)

type UserRole string

const (
	TeamMember     UserRole = "team_member"
	ProjectManager UserRole = "project_manager"
)

type User struct {
	ID        string   `gorm:"primaryKey" json:"id"`
	Name      string   `gorm:"size:100;not null" json:"name"`
	Email     string   `gorm:"unique;not null" json:"email"`
	Password  string   `gorm:"not null" json:"-"`
	Role      UserRole `gorm:"type:text;not null" json:"role"`
	CreatedAt string   `json:"created_at"`
	UpdatedAt string   `json:"updated_at"`
}

type Claims struct {
	UserID string `json:"user_id"`
	Role   string `json:"role"`
	jwt.StandardClaims
}
