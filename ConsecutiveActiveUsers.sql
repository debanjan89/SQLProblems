/*
Given timestamps of logins, figure out how many people on Facebook were active ALL seven days of a week on a mobile phone.
*/

CREATE TABLE Login (
  id INT(11) NOT NULL
  ,user_id int(11)
  ,ts DATE
);

ALTER TABLE Login
  ADD PRIMARY KEY (id);

ALTER TABLE Login
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

INSERT INTO Login (user_id, ts) VALUES
(1, "2019-02-14"),
(1, "2019-02-13"),
(1, "2019-02-12"),
(1, "2019-02-11"),
(2, "2019-02-14"),
(2, "2019-02-12"),
(2, "2019-02-11"),
(2, "2019-02-10"),
(3, "2019-02-14"),
(3, "2019-02-12");

INSERT INTO Login (user_id, ts) VALUES
(4, "2019-02-09"),
(4, "2019-02-08"),
(4, "2019-02-08"),
(4, "2019-02-07");


select *
from (
select *,dense_rank() over(partition by user_id order by ts) as loginday, FIRST_VALUE(ts)  over(partition by user_id order by ts) as firstLogicDt from #Login 
--order by 2,3
) as a
where DATEADD(D,loginday-1,firstLogicDt)=ts
and loginday>=3

select * from #Login order by 2,3