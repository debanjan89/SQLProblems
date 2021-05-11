--CREATE TABLE #Employee (
--ID INT IDENTITY(1,1),
--Name VARCHAR(10),
--Salary INT,
--DepartmentID INT
--)

CREATE TABLE #Department (
ID INT,
Name VARCHAR(10))

INSERT INTO #Employee
SELECT 'Joe',85000,1 UNION ALL
SELECT 'Henry',80000 ,2 UNION ALL
SELECT 'Sam',60000 ,2 UNION ALL
SELECT 'Max',90000 ,1 UNION ALL
SELECT 'Janet',69000 ,1 UNION ALL
SELECT 'Randy',85000 ,1 UNION ALL
SELECT 'Will',70000 ,1

INSERT INTO #Department
SELECT 1,'IT' UNION ALL
SELECT 2,'Sales'

SELECT Department,Employee,Salary
FROM (
SELECT d.Name AS Department,e.Name AS Employee,e.Salary AS Salary, DENSE_RANK() OVER(PARTITION BY d.name ORDER BY e.Salary desc) AS Rnk
FROM #Employee as e
INNER JOIN #Department as d
ON e.DepartmentID=d.ID
) AS A
WHERE Rnk<=3

SELECT d.Name AS Department,Employee,Salary
FROM (
SELECT DepartmentID,e.Name AS Employee,e.Salary AS Salary, DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY e.Salary desc) AS Rnk
FROM #Employee as e
) AS A
INNER JOIN #Department as d
ON a.DepartmentID=d.ID
WHERE Rnk<=3