/*
Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.
*/

select Name+'('+LEFT(Occupation,1)+')' from #Occupation order by Name;

select 'There are total '+cast(count(*) as varchar) +' no of '+occupation
from #Occupation 
group by occupation
order by count(*)