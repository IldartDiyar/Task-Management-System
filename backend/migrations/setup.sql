PRAGMA foreign_keys = ON;

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('team_member', 'project_manager')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Index on users.email for quick lookups
CREATE UNIQUE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- 2. Tasks Table
CREATE TABLE IF NOT EXISTS tasks (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    deadline DATETIME NOT NULL,
    assignee_id TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'To Do' CHECK (status IN ('To Do', 'In Progress', 'Blocked', 'Completed')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assignee_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Index on tasks.assignee_id to speed up assignment queries
CREATE INDEX IF NOT EXISTS idx_tasks_assignee_id ON tasks(assignee_id);

-- 3. Files Table
CREATE TABLE IF NOT EXISTS files (
    id TEXT PRIMARY KEY,
    task_id TEXT NOT NULL,
    filename TEXT NOT NULL,
    file_path TEXT NOT NULL,
    uploaded_by TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Index on files.task_id to optimize file retrieval per task
CREATE INDEX IF NOT EXISTS idx_files_task_id ON files(task_id);

-- 4. Audit Logs Table
CREATE TABLE IF NOT EXISTS audit_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT NOT NULL,
    action TEXT NOT NULL,
    entity TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    details TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Index on audit_logs.entity_id for fast auditing queries
CREATE INDEX IF NOT EXISTS idx_audit_logs_entity_id ON audit_logs(entity_id);

-- Composite index on audit_logs.user_id and timestamp for user-specific audit trails
CREATE INDEX IF NOT EXISTS idx_audit_logs_user_id_timestamp ON audit_logs(user_id, timestamp);
