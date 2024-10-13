package entity

type TaskStatus string

const (
	StatusToDo       TaskStatus = "To Do"
	StatusInProgress TaskStatus = "In Progress"
	StatusBlocked    TaskStatus = "Blocked"
	StatusCompleted  TaskStatus = "Completed"
)

type Task struct {
	ID          string     `gorm:"primaryKey" json:"id"`
	Title       string     `gorm:"size:255;not null" json:"title"`
	Description string     `gorm:"type:text" json:"description"`
	Deadline    string     `json:"deadline"`
	AssigneeID  string     `gorm:"not null" json:"assignee_id"`
	Assignee    User       `gorm:"foreignKey:AssigneeID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"assignee"`
	Status      TaskStatus `gorm:"type:text;default:'To Do'" json:"status"`
	Files       []File     `gorm:"foreignKey:TaskID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"files"`
	CreatedAt   string     `json:"created_at"`
	UpdatedAt   string     `json:"updated_at"`
}
