-- https://www.nicksingh.com/posts/30-sql-and-database-design-questions-from-real-data-science-interviews

--Assume you are given the below tables for trades and users. 
--Write a query to list the top 3 cities which had the highest number of completed orders.

trades(order_id, user_id, status)
users(user_id,city)

SELECT TOP 3 City, COUNT(order_id) AS OrderCount
FROM trades as t
INNER JOIN users as u 
ON t.user_id=u.user_id
WHERE t.status='Completed'
GROUP BY City
ORDER BY OrderCount DESC

-- Assume you have the below events table on app analytics. 
-- Write a query to get the click-through rate per app in 2019.

events(app_id, event_id, timestamp)

SELECT app_id, count(event_id)
from events
WHERE YEAR(timestamp)=2019
AND event_id like '%Click%'

--Assume you are given the below table for spending activity by product type. 
--Write a query to calculate the cumulative spend for each product over time in chronological order.

total_trans(order_id, user_id, product_id, spend, date)

SELECT user_id, date, SUM(spend) OVER(PARTITION BY user_id ORDER BY date)
FROM total_trans