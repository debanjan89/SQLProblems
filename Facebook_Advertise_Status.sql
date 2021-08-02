mysql> SELECT * FROM Advertiser;
+----+---------+-----------+
| id | user_id | status    |
+----+---------+-----------+
|  1 | bing    | NEW       |
|  2 | yahoo   | NEW       |
|  3 | alibaba | EXISTING  |
|  4 | baidu   | EXISTING  |
|  5 | target  | CHURN     |
|  6 | tesla   | CHURN     |
|  7 | morgan  | RESURRECT |
|  8 | chase   | RESURRECT |
+----+---------+-----------+
8 rows in set (0.00 sec)

mysql> SELECT * FROM DailyPay;
+----+---------+------+
| id | user_id | paid |
+----+---------+------+
|  1 | yahoo   |   45 |
|  2 | alibaba |  100 |
|  3 | target  |   13 |
|  4 | morgan  |  600 |
|  5 | fitdata |    1 |
+----+---------+------+
5 rows in set (0.00 sec)

--create table #Advertiser (id int, user_id varchar(20),status varchar(20))

--INSERT INTO #Advertiser
--SELECT 1, 'bing', 'New' UNION ALL
--SELECT 2, 'yahoo', 'New' UNION ALL
--SELECT 3, 'alibaba', 'Existing' UNION ALL
--SELECT 4, 'baidu', 'Existing' UNION ALL
--SELECT 5, 'target', 'Churn' UNION ALL
--SELECT 6, 'tesla', 'Churn' UNION ALL
--SELECT 7, 'morgan', 'RESURRECT' UNION ALL
--SELECT 8, 'chase', 'RESURRECT'

--create table #DailyPay (id int, user_id varchar(20), paid int)

--INSERT INTO #DailyPay
--SELECT 1,'yahoo',45 UNION ALL
--SELECT 2,'alibaba',100 UNION ALL
--SELECT 3,'target',13 UNION ALL
--SELECT 4,'morgan',600 UNION ALL
--SELECT 5,'fitdata',1

select * from #Advertiser
select * from #DailyPay

UPDATE TRGT
SET TRGT.Status=Ref.NewStatus
FROM #Advertiser AS TRGT
INNER JOIN (
	select A.User_ID,
	CASE WHEN D.User_id IS NULL THEN 'Churn'
		WHEN A.Status='Churn' AND D.paid IS NOT NULL THEN 'Resurrect'
		WHEN A.Status<>'Churn' AND D.paid IS NOT NULL THEN 'Existing'
		END AS NewStatus
	from #Advertiser as A
	LEFT JOIN #DailyPay as D
	ON A.user_id=D.user_id
) AS Ref
ON Ref.User_id=TRGT.User_ID

INSERT INTO #Advertiser
SELECT 9,D.User_ID,'New'
FROM #DailyPay AS D
LEFT JOIN #Advertiser AS A
ON D.User_ID=A.User_ID
WHERE A.User_ID IS NULL

SELECT * FROM #Advertiser