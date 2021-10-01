-- Given a Follow table, find the pair of instagram accounts which share highest number of common followers.

--CREATE TABLE #Follow (
--  user_id varchar(10) NOT NULL,
--  follower_id varchar(10) NOT NULL
--) 
----
---- Dumping data for table Follow
----

--INSERT INTO #Follow (user_id, follower_id) VALUES
--('bezos', 'david'),
--('bezos', 'james'),
--('bezos', 'join'),
--('bezos', 'mary'),
--('musk', 'david'),
--('musk', 'john'),
--('ronaldo', 'david'),
--('ronaldo', 'james'),
--('ronaldo', 'linda'),
--('ronaldo', 'mary'),
--('trump', 'melinda');

select * from #Follow

select a.user_id, b.user_id, count(*) as common
from 
(select distinct user_id from #Follow) as a
cross join (select distinct user_id from #Follow) as b
inner join #Follow as af
on a.user_id=af.user_id
inner join #Follow as bf
on b.user_id=bf.user_id
where a.user_id!=b.user_id
and af.follower_id=bf.follower_id
group by a.user_id, b.user_id
order by 3 desc