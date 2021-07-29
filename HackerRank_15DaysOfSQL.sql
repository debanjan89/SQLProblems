/*
Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest),
and find the hacker_id and name of the hacker who made maximum number of submissions each day. 
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
The query should print this information for each day of the contest, sorted by the date.
*/

--CREATE TABLE #submissions (submission_date date, submission_id integer, hacker_id integer, score integer);
--INSERT INTO #submissions VALUES('2016-03-01',8494,20703,0);
--INSERT INTO #submissions VALUES('2016-03-01',22403,53473,15);
--INSERT INTO #submissions VALUES('2016-03-01',23965,79722,60);
--INSERT INTO #submissions VALUES('2016-03-01',30173,36396,70);
--INSERT INTO #submissions VALUES('2016-03-02',34928,20703,0);
--INSERT INTO #submissions VALUES('2016-03-02',38740,15758,60);
--INSERT INTO #submissions VALUES('2016-03-02',42769,79722,60);
--INSERT INTO #submissions VALUES('2016-03-02',44364,79722,60);
--INSERT INTO #submissions VALUES('2016-03-03',45440,20703,0);
--INSERT INTO #submissions VALUES('2016-03-03',49050,36396,70);
--INSERT INTO #submissions VALUES('2016-03-03',50273,79722,5);
--INSERT INTO #submissions VALUES('2016-03-04',50344,20703,0);
--INSERT INTO #submissions VALUES('2016-03-04',51360,44065,90);
--INSERT INTO #submissions VALUES('2016-03-04',54404,53473,65);
--INSERT INTO #submissions VALUES('2016-03-04',61533,79722,45);
--INSERT INTO #submissions VALUES('2016-03-05',72852,20703,0);
--INSERT INTO #submissions VALUES('2016-03-05',74546,38289,0);
--INSERT INTO #submissions VALUES('2016-03-05',76487,62529,0);
--INSERT INTO #submissions VALUES('2016-03-05',82439,36396,10);
--INSERT INTO #submissions VALUES('2016-03-05',9006,36396,40);
--INSERT INTO #submissions VALUES('2016-03-06',90404,20703,0);

--CREATE TABLE #hackers (hacker_id integer, name varchar(20));
--INSERT INTO #hackers VALUES(15758,'Rose');
--INSERT INTO #hackers VALUES(20703,'Angela');
--INSERT INTO #hackers VALUES(36396,'Frank');
--INSERT INTO #hackers VALUES(38289,'Patrick');
--INSERT INTO #hackers VALUES(44065,'Lisa');
--INSERT INTO #hackers VALUES(53473,'Kimberly');
--INSERT INTO #hackers VALUES(62529,'Bonnie');
--INSERT INTO #hackers VALUES(79722,'Michael');

select * from #submissions

;WITH cteData AS ( 
SELECT * , Ranking = DENSE_RANK() OVER(ORDER BY Submission_date ASC) , Hackers = COUNT(1) OVER(PARTITION BY Submission_date, hacker_id) 
FROM #Submissions AS s 
CROSS APPLY ( SELECT StartDate = MIN(Submission_date), End_Date = MAX(Submission_date) FROM #Submissions ) ms 
OUTER APPLY ( SELECT PastCount = COUNT(DISTINCT s1.Submission_date) FROM #Submissions AS s1 WHERE s1.hacker_id = s.hacker_id AND s1.Submission_date BETWEEN ms.StartDate AND s.Submission_date ) sc 
OUTER APPLY ( SELECT TotalCount = COUNT(DISTINCT s1.Submission_date) FROM #Submissions AS s1 WHERE s1.hacker_id = s.hacker_id
) sc1 WHERE 1 = 1 ) 
, 
cteResult AS ( SELECT * , RID = ROW_NUMBER() OVER(PARTITIOn BY Submission_date ORDER BY Hackers DESC, TotalCount DESC)
FROM cteData WHERE 1 = 1 --AND PastCoount = Ranking
) 
select * from cteResult

SELECT a.Submission_date, a.Cnt , a.Hacker_ID , h.name 
FROM ( 
SELECT r.Submission_date , Cnt = COUNT( DISTINCT IIF(PastCount = Ranking, r.hacker_id,NULL)) , Hacker_ID = MAX(IIF(RID = 1, r.hacker_id,NULL)) 
FROM cteResult AS r GROUP BY r.Submission_date )a 
INNER JOIN #Hackers AS h 
ON h.Hacker_Id = a.Hacker_ID 
ORDER BY Submission_date