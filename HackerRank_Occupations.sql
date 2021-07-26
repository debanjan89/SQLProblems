SELECT
    [Doctor], [Professor], [Singer], [Actor]
FROM
(
    SELECT ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY NAME) [RowNumber], * FROM OCCUPATIONS
) AS tempTable
PIVOT
(
    MAX(NAME) FOR OCCUPATION IN ([Doctor], [Professor], [Singer], [Actor])
) AS pivotTable


---------------
with cte as ( select RANK() OVER (PARTITION BY Occupation ORDER BY Name) as Rank
, case when Occupation='Doctor' then Name else null end as doctor
, case when Occupation='Professor' then Name else null end as prof
, case when Occupation='Singer' then Name else null end as singer
, case when Occupation='Actor' then Name else null end as actor 
from Occupations) select min(doctor), min(prof), min(singer), min(actor) from cte group by Rank