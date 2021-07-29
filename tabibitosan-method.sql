/*
As you can see from that data, there's a range of numbers from 1-3, 5-7, 10-12 and 20-21, 
and we can determine those ranges by seeing where there are 'gaps' in sequence.
But how can we group these sequences together into their ranges using SQL? That's our basic problem.
*/

--create table #myvals(val int)

--insert into #myvals
--select 1 as val union all
--select 2 union all
--select 3 union all
--select 5 union all
--select 6 union all
--select 7 union all
--select 10 union all
--select 11 union all
--select 12 union all
--select 20 union all
--select 21 

select min(val) as range_start
      ,max(val) as range_end
      ,count(*) as range_count
from (
select val
      ,row_number() over (order by val) as rn
      ,val-row_number() over (order by val) as grp
from   #myvals
) as A
group by grp
order by 1
-------------------------------
-- create table #mydates(dt date)

-- insert into #mydates
-- select '2015-04-01' as dt union all
-- select '2015-04-02' union all
-- select '2015-04-03' union all
-- select '2015-04-04' union all
-- select '2015-04-07' union all
-- select '2015-04-08' union all
-- select '2015-04-10' union all
-- select '2015-04-12' union all
-- select '2015-04-13' union all
-- select '2015-04-14'

select min(dt) as range_start
      ,max(dt) as range_end
      ,count(*) as range_count
from (
select dt
      ,row_number() over (order by dt) as rn
      --,dt-row_number() over (order by dt) as grp
	  , DATEADD(D,-row_number() over (order by dt),dt) as grp
from #mydates
) as A
group by grp