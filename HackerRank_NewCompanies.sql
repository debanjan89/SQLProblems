/*  Given the table schemas below, write a query to print the 
company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, 
and total number of employees. 
Order your output by ascending company_code.*/

SELECT c.company_code, founder, COUNT(DISTINCT L.Lead_Manager_code), COUNT(DISTINCT S.Senior_Manager_code), COUNT(DISTINCT M.Manager_code), COUNT(DISTINCT employee_code)
FROM Company as C
INNER JOIN Lead_Manager as L
ON C.company_code=L.company_code
INNER JOIN Senior_Manager AS S
ON C.company_code=S.company_code
INNER JOIN Manager AS M
ON C.company_code=M.company_code
INNER JOIN Employee AS E
ON C.company_code=E.company_code
GROUP BY c.company_code, founder
ORDER BY c.company_code;