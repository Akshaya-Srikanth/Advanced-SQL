WITH A AS (
SELECT challenge_id, COALESCE(SUM(total_submissions),0) AS total_challenge_submissions, COALESCE(SUM(total_accepted_submissions),0) AS total_challenge_accepted_submissions
FROM Submission_Stats
GROUP BY challenge_id),

B AS (
SELECT challenge_id, COALESCE(SUM(total_views),0)
AS total_challenge_views, COALESCE(SUM(total_unique_views),0) AS total_challenge_unique_views
FROM View_Stats
GROUP BY challenge_id)


SELECT  college.contest_id AS contest_id,
    hacker.hacker_id AS hacker_id, 
    hacker.name AS name,
    COALESCE(SUM(A.total_challenge_submissions),0), 
    COALESCE(SUM(A.total_challenge_accepted_submissions),0), 
    COALESCE(SUM(B.total_challenge_views),0), 
    COALESCE(SUM(B.total_challenge_unique_views),0)
FROM Contests AS hacker
JOIN Colleges college ON hacker.contest_id = college.contest_id
JOIN Challenges AS challenge ON college.college_id = challenge.college_id
LEFT JOIN B ON challenge.challenge_id = B.challenge_id
LEFT JOIN A ON A.challenge_id = challenge.challenge_id
GROUP BY college.contest_id,  hacker.hacker_id , hacker.name
HAVING 
     COALESCE(SUM(A.total_challenge_submissions),0)+
    COALESCE(SUM(A.total_challenge_accepted_submissions),0)+
    COALESCE(SUM(B.total_challenge_views),0)+
    COALESCE(SUM(B.total_challenge_unique_views),0) <> 0
ORDER BY college.contest_id; 