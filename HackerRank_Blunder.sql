--CREATE TABLE #Employees(ID int, Name VARCHAR(20), Salary INT)

INSERT INTO #Employees
SELECT 1,'kirsten',1420 UNION ALL
SELECT 1,'Ashley',2006 UNION ALL
SELECT 1,'Julia',2210 UNION ALL
SELECT 1,'Maria',3000

select AVG(Salary)-AVG(cast(replace(cast(Salary AS VARCHAR),'0','') AS INT))
FROM #Employees