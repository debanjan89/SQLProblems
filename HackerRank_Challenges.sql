CREATE TABLE #Hacker (
hacker_id int,
name varchar(20)
)

INSERT INTO #Hacker
SELECT 12299,'Rose' UNION ALL
SELECT 34856,'Angela' UNION ALL
SELECT 79345,'Frank' UNION ALL
SELECT 80491,'Patrick' UNION ALL
SELECT 81041,'Lisa'

select * from #Hacker

CREATE TABLE #Challenges (
challenge_id int,
hacker_id int
)

INSERT INTO #Challenges
SELECT 1,12299 union all
SELECT 2,12299 union all
SELECT 3,12299 union all
SELECT 4,12299 union all
SELECT 5,12299 union all
SELECT 6,12299 union all
SELECT 7,34856 union all
SELECT 8,34856 union all
SELECT 9,34856 union all
SELECT 10,34856 union all
SELECT 11,34856 union all
SELECT 12,34856 union all
SELECT 13,79345 union all
SELECT 14,79345 union all
SELECT 15,79345 union all
SELECT 16,79345 union all
SELECT 17,80491 union all
SELECT 18,80491 union all
SELECT 19,80491 union all
SELECT 20, 81041 


WITH data
AS
(
SELECT c.hacker_id as id, h.name as name, count(c.hacker_id) as counter
FROM #Hacker h
JOIN #Challenges c on c.hacker_id = h.hacker_id
GROUP BY c.hacker_id, h.name
)
/* select records from above */
SELECT id,name,counter
FROM data
WHERE
counter=(SELECT max(counter) FROM data) /*select user that has max count submission*/
OR
counter in (SELECT counter FROM data
GROUP BY counter
HAVING count(counter)=1 ) /*filter out the submission count which is unique*/
ORDER BY counter desc, id