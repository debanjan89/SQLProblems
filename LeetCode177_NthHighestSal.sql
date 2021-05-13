CREATE TABLE #Employee(
ID int,
Salary int
)

INSERT INTO #Employee
SELECT 4,100 UNION ALL
SELECT 2,200 UNION ALL
SELECT 3,300 

select salary
from (
select *,Rank() OVER(ORDER BY Salary) as Rnk from #Employee
) as A
WHERE Rnk=2

CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        select distinct Salary
		from (
		select *,RANK() OVER(ORDER BY Salary) as Rnk from #Employee
		) as A
		WHERE Rnk=@N   
    );
END