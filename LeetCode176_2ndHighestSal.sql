CREATE TABLE #employee (
ID int,
Salary int)

INSERT INTO #employee
SELECT 1, 100 UNION ALL
SELECT 2, 200 UNION ALL
SELECT 3, 300 

select top 1 Salary
from (
select Salary 
from (
SELECT Salary, dense_rank() OVER(order by salary desc) as Rnk
FROM #employee 
) as A
where Rnk=2
union all
select null
) as B
order by 1 desc

SELECT DISTINCT Salary AS SecondHighestSalary
FROM 
(SELECT 'dummy' AS Col1) AS A
LEFT JOIN
( select * from (
SELECT *,'dummy' AS Col1, RANK() OVER(ORDER BY Salary DESC) AS Rnk
FROM #Employee
) as a where Rnk=2
    ) AS B
ON A.Col1=B.Col1

SELECT MAX(Salary) AS SecondHighestSalary 
FROM Employee 
WHERE Salary < (SELECT MAX(Salary) FROM Employee);