/*
Write a query that identifies users who share similar tastes on music, 
e.g. listening to at least three songs on the same day, and recommend them to be connected as friends.
*/

DROP TABLE IF EXISTS #Song;
CREATE TABLE #Song (
  id int NOT NULL,
  user_id varchar(10) NOT NULL,
  song varchar(20) NOT NULL,
  ts date NOT NULL
) 

-- Dumping data for table Song

INSERT INTO #Song (id, user_id, song, ts) VALUES
(1, 'Alex', 'Kiroro', '2019-03-17'),
(2, 'Alex', 'Shape of My Heart', '2019-03-17'),
(3, 'Alex', 'Clair de Lune', '2019-03-17'),
(4, 'Alex', 'The Fall', '2019-03-17'),
(5, 'Alex', 'Forever Young', '2019-03-17'),
(6, 'Bill', 'Shape of My Heart', '2019-03-17'),
(7, 'Bill', 'Clair de Lune', '2019-03-17'),
(8, 'Bill', 'The Fall', '2019-03-17'),
(9, 'Bill', 'Forever Young', '2019-03-17'),
(10, 'Bill', 'My Love', '2019-03-14'),
(11, 'Alex', 'Kiroro', '2019-03-17'),
(12, 'Alex', 'Shape of My Heart', '2019-03-17'),
(13, 'Alex', 'Shape of My Heart', '2019-03-17'),
(14, 'Bill', 'Shape of My Heart', '2019-03-17'),
(15, 'Bill', 'Shape of My Heart', '2019-03-17'),
(16, 'Bill', 'Shape of My Heart', '2019-03-17'),
(17, 'Cindy', 'Kiroro', '2019-03-17'),
(18, 'Cindy', 'Clair de Lune', '2019-03-17'),
(19, 'Cindy', 'My Love', '2019-03-14'),
(20, 'Cindy', 'Clair de Lune', '2019-03-14'),
(21, 'Cindy', 'Lemon Tree', '2019-03-14'),
(22, 'Cindy', 'Mad World', '2019-03-14'),
(23, 'Bill', 'Lemon Tree', '2019-03-14'),
(24, 'Bill', 'Mad World', '2019-03-14'),
(25, 'Bill', 'My Love', '2019-03-14');

-- Table structure for table User

DROP TABLE IF EXISTS #User;
CREATE TABLE #User (
  id int NOT NULL,
  user_id varchar(10) NOT NULL,
  friend_id varchar(10) NOT NULL
) 

-- Dumping data for table User

INSERT INTO #User (id, user_id, friend_id) VALUES
(1, 'Cindy', 'Bill');

select * from #Song
select * from #User

select a.user_id,b.user_id, a.ts, count(distinct a.song) as cnt
from #Song as a
inner join #Song as b
on a.user_id<>b.user_id
and a.song=b.song
and a.ts=b.ts
group by a.user_id,b.user_id, a.ts
having count(distinct a.song)>3