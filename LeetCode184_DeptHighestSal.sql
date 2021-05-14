
CREATE TABLE #Employee (
ID int,
Name VARCHAR(20),
Salary int,
DepartmentID int
)

INSERT INTO #Employee
SELECT 1,'Joe',70000,1 UNION ALL
SELECT 2,'Jim',90000,1 UNION ALL
SELECT 3,'Henry',80000,2 UNION ALL
SELECT 4,'Sam',60000,2 UNION ALL
SELECT 5,'Max',90000,1

CREATE TABLE #Department (
ID int,
Name varchar(10)
)

INSERT INTO #Department
SELECT 1,'IT' UNION ALL
SELECT 2,'Sales'

SELECT Department, Employee, Salary
FROM (
SELECT d.Name as Department, e.Name AS Employee, Salary, DENSE_RANK() OVER(PARTITION BY d.Name ORDER BY Salary desc) AS Rnk
FROM #Department as d
LEFT JOIN #Employee as e
ON d.ID=e.DepartmentID
) AS A
WHERE Rnk=1