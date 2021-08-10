-- Question 21
-- Table: ActorDirector

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | actor_id    | int     |
-- | director_id | int     |
-- | timestamp   | int     |
-- +-------------+---------+
-- timestamp is the primary key column for this table.
 

-- Write a SQL query for a report that provides the pairs (actor_id, director_id) where the actor have cooperated with the director at least 3 times.

-- Example:

-- ActorDirector table:
-- +-------------+-------------+-------------+
-- | actor_id    | director_id | timestamp   |
-- +-------------+-------------+-------------+
-- | 1           | 1           | 0           |
-- | 1           | 1           | 1           |
-- | 1           | 1           | 2           |
-- | 1           | 2           | 3           |
-- | 1           | 2           | 4           |
-- | 2           | 1           | 5           |
-- | 2           | 1           | 6           |
-- +-------------+-------------+-------------+

-- Result table:
-- +-------------+-------------+
-- | actor_id    | director_id |
-- +-------------+-------------+
-- | 1           | 1           |
-- +-------------+-------------+
-- The only pair is (1, 1) where they cooperated exactly 3 times.

CREATE TABLE #ActorDirector(actor_id int, director_id int , timestamp int)

INSERT INTO #ActorDirector
SELECT 1,1,0 UNION ALL
SELECT 1,1,1 UNION ALL
SELECT 1,1,2 UNION ALL
SELECT 1,2,3 UNION ALL
SELECT 1,2,4 UNION ALL
SELECT 2,1,5 UNION ALL
SELECT 2,1,6

SELECT actor_id, director_id FROM (
select *, RANK() OVER(PARTITION BY actor_id, director_id order by timestamp) AS Rnk 
from #ActorDirector ) AS A
WHERE Rnk>=3

Select actor_id, director_id
from #actordirector
group by actor_id, director_id
having count(*)>=3