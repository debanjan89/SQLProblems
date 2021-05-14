CREATE TABLE #logs (
Id int,
num int
)

INSERT INTO #logs
SELECT 1,1 UNION ALL
SELECT 2,1 UNION ALL
SELECT 3,1 UNION ALL
SELECT 4,2 UNION ALL
SELECT 5,1 UNION ALL
SELECT 6,2 UNION ALL
SELECT 7,2 

select a.num
from #logs as a
inner join #logs as b
on a.id=b.id+1
and a.num=b.num
inner join #logs as c
on a.id=c.id+2
and a.num=c.num

select num
from (
select num, lead(num,1) over(order by id) as num1, lead(num,2) over(order by id) as num2
from #logs
) as A
where num=num1
and num=num2