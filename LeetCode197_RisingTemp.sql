SELECT ID
FROM (
SELECT *, LAG(Temperature,1) OVER(ORDER BY RecordDate) AS PrevTemp
    , LAG(RecordDate,1) OVER(ORDER BY RecordDate) AS PrevDate
FROM Weather 
    ) AS A
WHERE Temperature>PrevTemp
AND DATEDIFF(DD,PrevDate,RecordDate)=1

select id
from (
select a.id, a.recordDate,(a.temperature-b.temperature) as diff
from Weather as a
inner join Weather as b
on a.recordDate=dateadd(day,1,b.recordDate)
) as a
where diff>0