/* Triangle using SQL*/

With CTE_GEN AS (
select top 5 1 as Col1,ROW_NUMBER() OVER(ORDER BY table_name) as Col2
from INFORMATION_SCHEMA.tables
)
SELECT LEFT(b.col2,6-c.Col2)
FROM 
(select 1 as Col1, '*****' as col2) AS B
INNER JOIN CTE_GEN AS C
ON C.Col1=B.Col1
