
CREATE TABLE #Students (
ID int,
Name VARCHAR(30),
Marks int
)

CREATE TABLE #Grades (
ID int,
Min_Mark INT,
MAX_Mark INT
)

INSERT INTO #Students
SELECT 1,'Julia',88 UNION ALL
SELECT 2,'Samantha',68 UNION ALL
SELECT 3,'Maria',99 UNION ALL
SELECT 4,'Scarlet',78 UNION ALL
SELECT 5,'Ashley',63 UNION ALL
SELECT 6,'Jane',81

INSERT INTO #Grades
SELECT 1,0,9 UNION ALL
SELECT 2,10,19 UNION ALL
SELECT 3,20,29 UNION ALL
SELECT 4,30,39 UNION ALL
SELECT 5,40,49 UNION ALL
SELECT 6,50,59 UNION ALL
SELECT 7,60,69 UNION ALL
SELECT 8,70,79 UNION ALL
SELECT 9,80,89 UNION ALL
SELECT 10,90,100

select case when g.ID<8 THEN 'NULL' ELSE s.Name end as Name
,g.ID as grade, s.Marks 
from #Students as s
inner join #Grades as g
on s.Marks between g.Min_Mark and g.Max_Mark
order by grade desc, s.name