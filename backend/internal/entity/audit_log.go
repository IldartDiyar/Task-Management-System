package entity

type AuditLog struct {
	ID        uint   `gorm:"primaryKey;autoIncrement" json:"id"`
	UserID    string `gorm:"not null" json:"user_id"`
	Action    string `gorm:"size:50;not null" json:"action"`
	Entity    string `gorm:"size:50;not null" json:"entity"`
	EntityID  string `gorm:"not null" json:"entity_id"`
	Timestamp string `json:"timestamp"`
	Details   string `gorm:"type:text" json:"details"`
}
