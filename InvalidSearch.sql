--what is the percentage of invalid search result, and the total number of searches for each country?

DROP TABLE IF EXISTS #SearchCategory;
CREATE TABLE #SearchCategory (
  country varchar(10) NOT NULL,
  search_cat varchar(10) NOT NULL,
  num_search int DEFAULT NULL,
  zero_result_pct decimal(10,0) DEFAULT NULL
) 

-- Dumping data for table SearchCategory

INSERT INTO #SearchCategory (country, search_cat, num_search, zero_result_pct) VALUES
('CN', 'dog', 9700000, NULL),
('CN', 'home', 1200000, '13'),
('CN', 'tax', 1200, '99'),
('CN', 'travel', 980000, '11'),
('UAE', 'home', NULL, NULL),
('UAE', 'travel', NULL, NULL),
('UK', 'home', NULL, NULL),
('UK', 'tax', 98000, '1'),
('UK', 'travel', 100000, '3'),
('US', 'home', 190000, '1'),
('US', 'tax', 12000, NULL),
('US', 'travel', 9500, '3');

select * from #SearchCategory

select country, sum(num_search) as totalSearch, sum(num_search*zero_result_pct) as sum_zero
from #SearchCategory
group by country

;WITH tmp AS (
SELECT
    country
    ,SUM(CASE WHEN zero_result_pct IS NOT NULL THEN num_search ELSE NULL END) AS num_search
    ,SUM(num_search * zero_result_pct) AS sum_zero_result
  FROM #SearchCategory
  GROUP BY country
)
SELECT
  country, 
  num_search,
  ROUND(sum_zero_result / num_search, 2) AS zero_result_pct
FROM tmp;