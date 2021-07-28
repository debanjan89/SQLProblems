/*
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
Exclude all hackers with a total score of  from your result.
*/
WITH CTE AS (
SELECT hacker_id,challenge_id,MAX(score) AS Score
FROM Submissions
GROUP BY hacker_id,challenge_id
HAVING MAX(score)>0
)

SELECT s.hacker_id,h.name,SUM(s.score)
FROM CTE as s
INNER JOIN Hackers as h
ON s.hacker_id=h.hacker_id
GROUP BY s.hacker_id,h.name
ORDER BY SUM(s.score) DESC, s.hacker_id