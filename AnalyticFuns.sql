--create table #totalSales(Name varchar(20), sales int)

--insert into #totalSales
--select 'john',10 UNION ALL
--select 'Jennifer',15 UNION ALL
--select 'Stella',20 UNION ALL
--select 'Sophia',40 UNION ALL
--select 'Greg',50 UNION ALL
--select 'Jeff',20

select * from #totalSales
-- Median
SELECT Sales Median FROM
(SELECT a1.Name, a1.Sales, COUNT(a1.Sales) Rank
FROM #TotalSales a1, #TotalSales a2
WHERE a1.Sales < a2.Sales OR (a1.Sales=a2.Sales AND a1.Name <= a2.Name)
group by a1.Name, a1.Sales
) a3
WHERE Rank = (SELECT (COUNT(*)+1)/2 FROM #TotalSales);

-- Rank
SELECT a1.Name, a1.Sales, COUNT (a2.Sales) Sales_Rank
FROM #TotalSales a1 
INNER JOIN #TotalSales a2
ON a1.Sales < a2.Sales OR (a1.Sales=a2.Sales AND a1.Name = a2.Name)
GROUP BY a1.Name, a1.Sales
ORDER BY a1.Sales DESC, a1.Name DESC;

-- Running Total
SELECT a1.Name, a1.Sales, SUM(a2.Sales) Running_Total
FROM #TotalSales a1, #TotalSales a2
WHERE a1.Sales <= a2.sales or (a1.Sales=a2.Sales and a1.Name = a2.Name)
GROUP BY a1.Name, a1.Sales
ORDER BY a1.Sales DESC, a1.Name DESC;

-- % to Total
SELECT a1.Name, a1.Sales, CAST(a1.Sales AS decimal(5,2))/(SELECT SUM(Sales) FROM #TotalSales) Pct_To_Total
FROM #TotalSales a1, #TotalSales a2
WHERE a1.Sales <= a2.sales or (a1.Sales=a2.Sales and a1.Name = a2.Name)
GROUP BY a1.Name, a1.Sales
ORDER BY a1.Sales DESC, a1.Name DESC;

-- Cummulative % to Total
SELECT a1.Name, a1.Sales, SUM(a2.Sales)/(SELECT SUM(Sales) FROM Total_Sales) Pct_To_Total
FROM Total_Sales a1, Total_Sales a2
WHERE a1.Sales <= a2.sales or (a1.Sales=a2.Sales and a1.Name = a2.Name)
GROUP BY a1.Name, a1.Sales
ORDER BY a1.Sales DESC, a1.Name DESC;c