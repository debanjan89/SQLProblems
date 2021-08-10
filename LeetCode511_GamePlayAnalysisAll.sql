/*
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) 
before logging out on some day using some device.

Write an SQL query that reports the first login date for each player.

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
*/

SELECT player_id, MIN(event_date)
FROM Activity
GROUP BY player_id

/*
Write a SQL query that reports the device that is first logged in for each player.

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+
*/
WITH CTE AS (
    SELECT player_id, MIN(event_date)
    FROM Activity
    GROUP BY player_id
)

SELECT a.player_id, a.device_id
FROM Activity AS a
INNER JOIN CTE AS b
ON a.player_id=b.player_id
AND a.event_date=b.event_date

/*
Write an SQL query that reports for each player and date, how many games played so far by the player. 
That is, the total number of games played by the player until that date. Check the example for clarity.

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 1         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+------------+---------------------+
| player_id | event_date | games_played_so_far |
+-----------+------------+---------------------+
| 1         | 2016-03-01 | 5                   |
| 1         | 2016-05-02 | 11                  |
| 1         | 2017-06-25 | 12                  |
| 3         | 2016-03-02 | 0                   |
| 3         | 2018-07-03 | 5                   |
+-----------+------------+---------------------+
For the player with id 1, 5 + 6 = 11 games played by 2016-05-02, and 5 + 6 + 1 = 12 games played by 2017-06-25.
For the player with id 3, 0 + 5 = 5 games played by 2018-07-03.
Note that for each player we only care about the days when the player logged in.
*/

SELECT player_id, event_date, SUM(games_played) OVER(PARTITION BY player_id ORDER BY event_date) AS games_played_so_far
FROM Activity

select t1.player_id, t1.event_date, sum(t2.games_played) as games_played_so_far
from Activity as t1 inner join Activity as t2
on t1.player_id = t2.player_id
where t1.event_date >= t2.event_date
group by t1.player_id, t1.event_date

/*
Write an SQL query that reports 
the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, 
then divide that number by the total number of players.

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
*/
CREATE TABLE #Activity(player_id int, device_id int, event_date date, games_played int)

INSERT INTO #Activity
SELECT 1,2,'2016-03-01',5 UNION ALL
SELECT 1,2,'2016-03-02',6 UNION ALL
SELECT 2,3,'2017-06-25',1 UNION ALL
SELECT 3,1,'2016-03-02',0 UNION ALL
SELECT 3,4,'2018-07-03',5 

WITH CTE AS (
SELECT *,
	CASE WHEN LoginDay>1 and event_date=DATEADD(D,LoginDay-1,FirstLogin) THEN 1 ELSE 0 END AS RepeatedGamer
FROM (
	SELECT * 
	, RANK() OVER(PARTITION BY player_id ORDER BY event_date) AS LoginDay
	, MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS FirstLogin
	FROM #Activity
) AS A
)

SELECT CAST(SUM(RepeatedGamer) AS DECIMAL(5,2))/COUNT(DISTINCT player_id) AS fraction
FROM CTE

