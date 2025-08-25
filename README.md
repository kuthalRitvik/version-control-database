# Version Control Database

A PostgreSQL database system that replicates Git-like version control operations including repositories, commits, branches, and file versioning.

## Features

- **Repository Management** - Create and manage multiple repositories
- **Branch Operations** - Support for branching and merging
- **Commit Tracking** - Complete commit history with metadata
- **File Versioning** - Track file changes over time with content storage
- **Folder Structure** - Handle complex directory hierarchies
- **Multi-user Support** - User authentication and contributor management

## Database Schema

**Core Tables:**
- `users` - System users and authentication
- `repo` - Project repositories
- `branch` - Development branches
- `commits` - Project snapshots
- `items` - Generalized files/folders
- `file_instance` / `folder_instance` - Specific content versions

## Quick Start

### Prerequisites
- PostgreSQL 12+

### Installation

1. **Setup Database**
   ```bash
   createdb version_control_db
   psql -d version_control_db -f schema.sql
   ```

2. **Sample Data (Optional)**
   ```bash
   psql -d version_control_db -f sample_data.sql
   ```

## Key Operations

### Git Log
```sql
SELECT commit_id, username, commit_message, commit_time
FROM commits JOIN users ON users.user_id = commits.made_by
WHERE repo_id = 1 AND branch_name = 'main'
ORDER BY commit_time DESC;
```

### File History
```sql
SELECT commit_id, commit_message, file_content
FROM commits c
JOIN items i ON c.commit_id = i.made_by
JOIN file_instance fi ON i.item_id = fi.item_id
WHERE fi.file_id = 'target_file_id'
ORDER BY commit_time DESC;
```

### Repository Contents
```sql
SELECT file_id as name FROM file_instance fi
JOIN items i ON fi.item_id = i.item_id
WHERE i.item_id IN (
    SELECT item_id FROM commit_contains
    WHERE commit_id = (
        SELECT commit_id FROM commits
        WHERE repo_id = 1 ORDER BY commit_time DESC LIMIT 1
    )
);
```

## Database Design

- **BCNF Normalized** - All tables in Boyce-Codd Normal Form
- **Item-based Architecture** - Files and folders treated as unified "items"
- **Version Control** - New instances created for file modifications
- **Referential Integrity** - Comprehensive foreign key constraints

## Author

**Kuthal Ritvik** (2023MCB1219) - IIT Ropar
