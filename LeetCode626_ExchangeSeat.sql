CREATE TABLE #seat(
id int,
student varchar(20)
)

INSERT INTO #seat
SELECT 1,'Abbot' UNION ALL
SELECT 2,'Doris' UNION ALL
SELECT 3,'Emerson' UNION ALL
SELECT 4,'Green' UNION ALL
SELECT 5,'Jeames'

select id,
	case when id%2=1 then ISNULL(PostVal,student) else Preval end as NewStudent
from (
select *, lead(student,1) over(order by id) as PostVal, lag(student,1) over(order by id) as PreVal
from #seat
) as a

SELECT id,
(CASE
WHEN id % 2 = 1 THEN LEAD(student,1,student) OVER(ORDER BY id)
ELSE LAG(student) OVER(ORDER BY id)
END) AS student
FROM #seat