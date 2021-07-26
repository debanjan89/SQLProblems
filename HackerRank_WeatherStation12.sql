/*  Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
Your result cannot contain duplicates.  */

select DISTINCT City 
from STATION 
where LEFT(City,1) not in ('a','e','i','o','u')
and RIGHT(City,1) not in ('a','e','i','o','u')