INSERT INTO users (user_id, username, email, password_hash) VALUES
(1, 'NikeshNikki', 'nikesh.tadela@gmail.com', 'asdoif34r0q93i4r0q93iqweif923rqwej');

INSERT INTO repo (repo_name, repo_id, owned_by) VALUES
('lichesslite', 1, 1);

INSERT INTO contributor (user_id, repo_id) VALUES (1, 1);

INSERT INTO branch (repo_id, branch_name) VALUES
(1, 'main'),
(1, 'invitation');

INSERT INTO commits (commit_id, repo_id, branch_name, made_by, commit_time, commit_message) VALUES
('76ef2a5680485ede3da047ee03b4a81110ebf4c6', 1, 'main', 1, '2024-03-20 19:39:53.375', 'started out with the boilerplate html code');

INSERT INTO merges (commit_id, incoming_commit, approved_by) VALUES
('c1e5ed6e7051e2837e9eb135b2fd206aca386919', '00f94bb2ae98bbed40cb42d276c947b485542c0b', 1);

INSERT INTO commit_contains (commit_id, item_id) VALUES
('c1e5ed6e7051e2837e9eb135b2fd206aca386919', 'f49499a979ea6c4489fb05b53c77e74cb6e7596f04def4cd09efca806e47140e');

INSERT INTO file_instance (item_id, file_content, file_id) VALUES
('f49499a979ea6c4489fb05b53c77e74cb6e7596f04def4cd09efca806e47140e',
'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lichess</title>
</head>
<body>
<h1>Welcome to Lichess !!</h1>
<button>Enter the game</button>
<form action="/login">
<label for="uname">Username</label>
<input type="text" id="uname">
<label for="pwd">Password</label>
<input type="password" id="pwd">
</form>
<p>Hello all !!! You are being invited to participate in this contest</p>
</body>
</html>', '1|index.html');

INSERT INTO files (file_id, file_name, file_extenstion, belongs_to) VALUES
('1|index.html', 'index', 'html', 1);

INSERT INTO folders (folder_id, folder_name, belongs_to) VALUES
('2|styles', 'styles', 2);

INSERT INTO folder_instance (item_id, folder_id) VALUES
('a2982424c72723ef8d2de1a99ec3a138f8633dfee0febd77b8c2e62aa7abfc7a', '2|styles');

INSERT INTO folder_contains (parent_item_id, child_item_id) VALUES
('a2982424c72723ef8d2de1a99ec3a138f8633dfee0febd77b8c2e62aa7abfc7a', '5c81eb00ebfb32f6c8841b12eaffb20d5993d8d5166ebe57b6470ba910f8a8c3');

INSERT INTO items (item_id, item_type, made_by) VALUES
('373a67541721668c7ba1bcbf884abc56f610eadf9f7073a75e43b88c3f0fbbb6', 'file', '76ef2a5680485ede3da047ee03b4a81110ebf4c6');
