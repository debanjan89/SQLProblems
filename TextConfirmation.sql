/*
New users sign up with their emails for our service. Each sign up requires text confirmation to activate account. 
We have two tables: Email and Text. Answer the following question: 
    (1) How many users signed up with their emails per day? 
    (2) What proportion of people who signed up confirmed with SMS text message? 
    (3) How many people did not confirm on the first day of sign up, but confirmed on the second day?
*/

DROP TABLE IF EXISTS #Email;
CREATE TABLE #Email (
  ts datetime NOT NULL,
  user_id varchar(10) NOT NULL,
  email varchar(20) NOT NULL
) 

-- Dumping data for table Email

INSERT INTO #Email (ts, user_id, email) VALUES
('2019-03-13 00:00:00', 'neo', 'anderson@matrix.com'),
('2019-03-17 12:15:00', 'Ross', 'ross@126.com'),
('2019-03-18 05:37:00', 'ali', 'ali@hotmail.com'),
('2019-03-18 06:00:00', 'shaw', 'shawlu95@gmail.com');

-- --------------------------------------------------------

-- Table structure for table Text

DROP TABLE IF EXISTS #Text;
CREATE TABLE #Text (
  id int NOT NULL,
  ts datetime NOT NULL,
  user_id varchar(10) NOT NULL,
  action varchar(10) 
) 
-- Dumping data for table Text

INSERT INTO #Text (id, ts, user_id, action) VALUES
(1, '2019-03-17 12:15:00', 'Ross', 'CONFIRMED'),
(2, '2019-03-18 05:37:00', 'Ali', NULL),
(3, '2019-03-18 14:00:00', 'Ali', 'CONFIRMED'),
(4, '2019-03-18 06:00:00', 'shaw', NULL),
(5, '2019-03-19 00:00:00', 'shaw', 'CONFIRMED');

select * from #Email
select * from #Text

SELECT CAST(ts as DATE) AS SignedUpDt, COUNT(*) AS Cnt
FROM #Email
GROUP BY CAST(ts as DATE)

SELECT ROUND((SELECT CAST(SUM(CASE WHEN action = 'CONFIRMED' THEN 1 ELSE 0 END) AS decimal(5,2)) FROM #text) / (SELECT COUNT(*) FROM #Email), 2) AS rate;


SELECT e.user_id
FROM #Email AS e
LEFT JOIN #Text as t
ON e.user_id=t.user_id
WHERE action='CONFIRMED'
AND DATEDIFF(DAY,e.ts,t.ts)=1