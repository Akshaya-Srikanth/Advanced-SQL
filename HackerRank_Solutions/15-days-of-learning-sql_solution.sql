DECLARE @startDate DATE = '03/01/2016'
;WITH ConsistentHackers AS (
    SELECT
        s.submission_date
        ,s.hacker_id
    FROM Submissions s
    WHERE s.submission_date = @startDate
    UNION ALL
    SELECT
        DATEADD(dd, 1, ch.submission_date) AS submission_date
        ,s.hacker_id
    FROM Submissions s
    JOIN ConsistentHackers ch
        ON s.hacker_id = ch.hacker_id
        AND s.submission_date = DATEADD(dd, 1, ch.submission_date) 
), ConsistencyCounts AS (
    SELECT
        ch.submission_date
        ,COUNT(DISTINCT ch.hacker_id) AS ConsistentHackers
    FROM ConsistentHackers ch
    GROUP BY ch.submission_date
), SubmissionsSummary AS (
    SELECT
        s.submission_date
        ,s.hacker_id
        ,ROW_NUMBER() OVER (
            PARTITION BY s.submission_date
            ORDER BY COUNT(*) DESC, s.hacker_id ASC
        ) AS ranking
    FROM Submissions s
    GROUP BY
        s.submission_date
        ,s.hacker_id
)
SELECT
    ss.submission_date
    ,cc.ConsistentHackers
    ,h.hacker_id
    ,h.name
FROM SubmissionsSummary ss
JOIN ConsistencyCounts cc
    ON ss.submission_date = cc.submission_date
    AND ss.ranking = 1
JOIN Hackers h
    ON ss.hacker_id = h.hacker_id
ORDER BY ss.submission_date ASC