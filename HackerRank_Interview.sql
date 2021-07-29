/*
Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, 
and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are .
*/

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
WITH SUM_View_Stats AS (
SELECT challenge_id
    , total_views = sum(total_views)
    , total_unique_views = sum(total_unique_views)
FROM View_Stats 
GROUP BY challenge_id
)
,SUM_Submission_Stats AS (
SELECT challenge_id
    , total_submissions = sum(total_submissions)
    , total_accepted_submissions = sum(total_accepted_submissions)
FROM Submission_Stats 
GROUP BY challenge_id
)

SELECT    con.contest_id
        , con.hacker_id
        , con.name
        , SUM(total_submissions)
        , sum(total_accepted_submissions)
        , sum(total_views)
        , sum(total_unique_views)
FROM Contests con
INNER JOIN Colleges col
    ON con.contest_id = col.contest_id
INNER JOIN Challenges cha
    ON cha.college_id = col.college_id
LEFT JOIN SUM_View_Stats vs
    ON vs.challenge_id = cha.challenge_id
LEFT JOIN SUM_Submission_Stats ss
    ON ss.challenge_id = cha.challenge_id
GROUP BY con.contest_id,con.hacker_id,con.name
HAVING (SUM(total_submissions)
        +sum(total_accepted_submissions)
        +sum(total_views)
        +sum(total_unique_views)) <> 0
ORDER BY con.contest_ID