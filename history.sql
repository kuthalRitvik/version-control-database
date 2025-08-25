-- =======================================================
-- Version Control Database : History Queries
-- Author: Kuthal Ritvik
-- =======================================================

-- 1️⃣ Full Commit History of a Repository (like git log)
-- Replace repo_id = 1 with your repo id
SELECT c.commit_id,
       u.username,
       c.commit_message,
       c.commit_time
FROM commits c
JOIN users u ON u.user_id = c.made_by
WHERE c.repo_id = 1
ORDER BY c.commit_time DESC;

-- =======================================================

-- 2️⃣ Branch Commit History (like git log <branch>)
-- Replace repo_id = 1 and branch_name = 'main' as needed
SELECT c.commit_id,
       u.username,
       c.commit_message,
       c.commit_time
FROM commits c
JOIN users u ON c.made_by = u.user_id
WHERE c.repo_id = 1
  AND c.branch_name = 'main'
ORDER BY c.commit_time DESC;

-- =======================================================

-- 3️⃣ File History (like git log -p <file>)
-- Shows all versions of a file along with commit info
-- Replace '2|index.html' with your file_id
SELECT c.commit_id,
       c.commit_message,
       c.commit_time,
       fi.file_content
FROM commits c
JOIN items i ON c.commit_id = i.made_by
JOIN file_instance fi ON fi.item_id = i.item_id
WHERE fi.file_id = '2|index.html'
ORDER BY c.commit_time DESC;

-- =======================================================
-- END OF HISTORY QUERIES
