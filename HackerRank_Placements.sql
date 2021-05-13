
CREATE TABLE #students (
ID int,
Name varchar(30)
)

CREATE TABLE #Friends (
ID int,
Friend_ID int
)

CREATE TABLE #packages (
ID int,
Salary decimal(5,2)
)

INSERT INTO #students
SELECT 1,'Ashley' UNION ALL
SELECT 2,'Samantha' UNION ALL
SELECT 3,'Julia' UNION ALL
SELECT 4,'Scarlet' 

INSERT INTO #Friends
SELECT 1,2 UNION ALL
SELECT 2,3 UNION ALL
SELECT 3,4 UNION ALL
SELECT 4,1

INSERT INTO #packages
SELECT 1,15.2 UNION ALL
SELECT 2,10.06 UNION ALL
SELECT 3,11.55 UNION ALL
SELECT 4,12.12 

select s.Name
from #Students as s
inner join #packages as p
on s.ID=p.ID
inner join #friends as f
on s.ID=f.ID
inner join #packages as pf
on f.Friend_ID=pf.ID
where pf.Salary>p.Salary
order by pf.Salary