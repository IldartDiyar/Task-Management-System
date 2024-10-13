package entity

type File struct {
	ID             string `gorm:"primaryKey" json:"id"`
	TaskID         string `gorm:"not null" json:"task_id"`
	Task           Task   `gorm:"foreignKey:TaskID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"-"`
	Filename       string `gorm:"size:255;not null" json:"filename"`
	FilePath       string `gorm:"size:500;not null" json:"file_path"`
	UploadedBy     string `gorm:"not null" json:"uploaded_by"`
	UploadedByUser User   `gorm:"foreignKey:UploadedBy;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;" json:"uploaded_by_user"`
	CreatedAt      string `json:"created_at"`
}
