/*
Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) 
each day between "2013-10-01" and "2013-10-03".

The cancellation rate is computed by dividing the number of canceled (by client or driver) requests 
with unbanned users by the total number of requests with unbanned users on that day.
*/

--CREATE TABLE #Trips (
--ID INT Identity(1,1),
--Client_ID INT,
--Driver_ID INT,
--City_ID INT,
--Status VARCHAR(20),
--Request_At DATE
--)

--DROP TABLE #Users
--CREATE TABLE #Users(
--UserID INT,
--Banned VARCHAR(5),
--Role VARCHAR(10)
--)

INSERT INTO #Trips (Client_ID,Driver_ID,City_ID,Status,Request_At)
--SELECT 1,10,1,'completed','2013-10-01' UNION ALL
--SELECT 2,11,1,'cancelled_by_driver','2013-10-01' UNION ALL
--SELECT 3,12,6,'completed','2013-10-01' UNION ALL
--SELECT 4,13,6,'cancelled_by_client','2013-10-01' UNION ALL
--SELECT 1,10,1,'completed','2013-10-02' UNION ALL
--SELECT 2,11,6,'completed','2013-10-02' UNION ALL
--SELECT 3,12,6,'completed','2013-10-02'
SELECT 1,10,1,'cancelled_by_client','2013-10-04'

--INSERT INTO #Users
--SELECT 1,'No','client' UNION ALL
--SELECT 2,'Yes','client' UNION ALL
--SELECT 3,'No','client' UNION ALL
--SELECT 4,'No','client' UNION ALL
--SELECT 10,'No','driver' UNION ALL
--SELECT 11,'No','driver' UNION ALL
--SELECT 12,'No','driver' UNION ALL
--SELECT 13,'No','driver'

select * from #Trips
select * from #Users

--["1", "1", "10", "1", "cancelled_by_client", "2013-10-04"]], "Users": [["1", "No", "client"], ["10", "No", "driver"]]}}


select Request_At AS Day, CAST(SUM(CASE WHEN Status like 'cancelled%' THEN 1.0 ELSE 0.0 END)/count(*) AS decimal(3,2)) AS 'Cancellation Rate'
from #Trips as t
inner join #Users as uD
on t.Driver_ID=uD.UserID
inner join #Users as uC
on t.client_ID=uC.UserID
WHERE uD.Banned='No' and uC.Banned='No'
group by Request_At

select Request_At AS Day, CAST(SUM(CASE WHEN ( Status = 'cancelled_by_driver' or status ='cancelled_by_client') THEN 1.0 ELSE 0.0 END)/count(*) AS decimal(3,2)) AS 'Cancellation Rate'
from Trips as t
inner join Users as uD
on t.Driver_ID=uD.Users_ID
and uD.Banned='No' and uD.Role='driver'
inner join Users as uC
on t.client_ID=uC.Users_ID
and uC.Banned='No' and uC.Role='client'
WHERE Request_At between '2013-10-01' and '2013-10-03'
group by Request_At

SELECT Request_At AS [Day],CAST((CAST(CancelledReq AS DECIMAL(3,2))/TotReq) AS DECIMAL(3,2)) AS [Cancellation Rate]
FROM (
SELECT T.Request_At,SUM(CASE WHEN Status='Completed' THEN 0 ELSE 1 END) AS CancelledReq,COUNT(1) AS TotReq
FROM Trips AS T
INNER JOIN Users AS D
ON T.Driver_ID=D.Users_Id
INNER JOIN Users AS C
ON T.Client_Id=C.Users_Id
WHERE D.Banned='No'
AND C.Banned='No'
AND T.Request_At BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY T.Request_At
) AS A
