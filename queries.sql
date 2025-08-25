-- Tech stack used in a repo
select distinct (file_extenstion) 
from files 
where files.belongs_to = 2;

-- Git log (main branch)
select cmit.commit_id, users.username, cmit.commit_message, cmit.commit_time
from (
    select * from commits 
    where repo_id = 2 and branch_name = 'main' 
    order by commit_time desc
) cmit
join users on users.user_id = cmit.made_by;

-- Git log of non-main branch
select * from (
    (select * from commits where branch_name = 'invitation' and repo_id = 1 order by commit_time desc)
    union
    (select * from commits 
     where (repo_id,branch_name) = (
        select repo_id,branch_name from commits
        where commit_id = (select originates_from from branch
                           where branch_name='invitation' and repo_id = 1))
     and commit_time < (select commit_time from commits
                        where commit_id = (select originates_from from branch 
                                           where branch_name='invitation' and repo_id = 1))
     order by commit_time desc)
);

-- Contributor stats
select username, coalesce(cmits,0) 
from (
    select users.user_id, username 
    from (select * from contributor c where c.repo_id = 1) con
    join users on con.user_id = users.user_id
) f
left join (
    select made_by, count(*) cmits 
    from commits c where repo_id = 1 group by made_by
) s
on f.user_id = s.made_by;

-- Contents in root of latest commit
select folder_id as "name", item_id 
from folder_instance fo 
where item_id in (
    select i.item_id from items i 
    where i.item_id in (
        select cc.item_id from commit_contains cc 
        where cc.commit_id = (
            select commit_id from commits 
            where commits.repo_id = 2 
            order by commit_time desc limit 1
        )
    ) and item_type = 'folder'
)
union
select file_id as "name", item_id 
from file_instance fi 
where item_id in (
    select i.item_id from items i 
    where i.item_id in (
        select cc.item_id from commit_contains cc 
        where cc.commit_id = (
            select commit_id from commits 
            where commits.repo_id = 2 
            order by commit_time desc limit 1
        )
    ) and item_type = 'file'
);

-- History of a file
select commit_id, commit_message, file_content 
from (
    select * from commits c 
    where repo_id = 2 and branch_name ='main'
) cmits
join (
    select made_by, file_content 
    from items 
    join (select * from file_instance where file_id = '2|index.html') fi 
    on fi.item_id = items.item_id
) fi
on cmits.commit_id = fi.made_by
order by commit_time desc;
