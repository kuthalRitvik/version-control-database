-- Users Table
create table users (
    user_id int primary key,
    username varchar(40) unique,
    email text,
    password_hash text
);

-- Repository Table
create table repo (
    repo_name varchar(40),
    repo_id int primary key,
    owned_by int,
    foreign key(owned_by) references users
);

-- Contributor Table
create table contributor (
    user_id int,
    repo_id int,
    foreign key (user_id) references users(user_id),
    foreign key (repo_id) references repo(repo_id),
    primary key(user_id,repo_id)
);

-- Branch Table
create table branch (
    repo_id int references repo(repo_id),
    branch_name varchar(40),
    primary key(repo_id, branch_name)
);

-- Commits Table
create table commits (
    commit_id varchar(75) primary key,
    repo_id int,
    branch_name varchar(40),
    made_by int,
    commit_time timestamp,
    commit_message text,
    foreign key (repo_id, branch_name) references branch(repo_id,branch_name),
    foreign key (repo_id,made_by) references contributor(repo_id,user_id)
);

-- Merges Table
create table merges (
    commit_id varchar(75) references commits(commit_id) primary key,
    incoming_commit varchar(75) references commits(commit_id),
    approved_by int references users(user_id)
);

-- Items Table
create table items (
    item_id varchar(75) primary key,
    item_type varchar(10),
    made_by varchar(75),
    foreign key (made_by) references commits(commit_id)
);

-- Files Table
create table files (
    file_id text primary key,
    file_name varchar(40),
    file_extenstion varchar(75),
    belongs_to int,
    foreign key (belongs_to) references repo(repo_id)
);

-- Folders Table
create table folders (
    folder_id text primary key,
    folder_name varchar(40),
    belongs_to int,
    foreign key (belongs_to) references repo(repo_id)
);

-- File Instance
create table file_instance (
    item_id varchar(75) primary key,
    file_content text,
    file_id text,
    foreign key (file_id) references files(file_id),
    foreign key (item_id) references items(item_id)
);

-- Folder Instance
create table folder_instance (
    item_id varchar(75) primary key,
    folder_id text,
    foreign key (item_id) references items(item_id),
    foreign key (folder_id) references folders(folder_id)
);

-- Commit Contains
create table commit_contains (
    commit_id varchar(75) references commits(commit_id),
    item_id varchar(75) references items(item_id),
    primary key(commit_id,item_id)
);

-- Folder Contains
create table folder_contains (
    parent_item_id varchar(75),
    child_item_id varchar(75),
    foreign key (parent_item_id) references folder_instance(item_id),
    foreign key (child_item_id) references items(item_id),
    primary key(parent_item_id,child_item_id)
);
