/*
 Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
 Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
 If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
*/

SELECT s.hacker_id,h.name
FROM Submissions as s
INNER JOIN Challenges as c
ON s.challenge_id=c.challenge_id
INNER JOIN Difficulty as d
ON c.difficulty_level=d.difficulty_level
INNER JOIN Hackers as h
ON s.hacker_id=h.hacker_id
WHERE s.score=d.score
GROUP BY s.hacker_id,h.name
HAVING COUNT(c.challenge_id)>1
order by count(s.score) desc, s.hacker_id