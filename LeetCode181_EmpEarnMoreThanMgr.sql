CREATE TABLE #Employee (
ID int,
Name VARCHAR(20),
Salary int,
ManagerID int
)

INSERT INTO #Employee
SELECT 1,'Joe',70000 ,3 UNION ALL
SELECT 2,'Henry,',80000,4 UNION ALL
SELECT 3,'Sam',60000,NULL UNION ALL
SELECT 4,'Max',90000,NULL

select e.Name as Employee
from #Employee as e
inner join #Employee as m
on e.ManagerID=m.ID
where e.Salary>m.Salary