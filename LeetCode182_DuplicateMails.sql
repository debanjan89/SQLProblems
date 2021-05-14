CREATE TABLE #Person (
ID int,
Email VARCHAR(20)
)

INSERT INTO #Person
SELECT 1,'a@b.com' UNION ALL
SELECT 2,'c@d.com' UNION ALL
SELECT 3,'a@b.com'

select Email
from (
select * , ROW_NUMBER() OVER(PARTITION BY Email ORDER BY ID) as Rno
from #Person
) AS A
WHERE Rno <> 1

SELECT Email
FROM #Person
GROUP BY Email
HAVING COUNT(1)>1