-- ============================================================================
-- LeetCode 601 — Human Traffic of Stadium  (Hard)
-- https://leetcode.com/problems/human-traffic-of-stadium/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Stadium(id, visit_date, people), id increasing. Return
-- rows that are part of a run of THREE OR MORE consecutive ids where every one
-- of those days had people >= 100. Order the result by visit_date.
-- Output columns: id, visit_date, people.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Stadium (id INT PRIMARY KEY, visit_date DATE, people INT);
INSERT INTO Stadium VALUES
    (1,'2017-01-01',10),(2,'2017-01-02',109),(3,'2017-01-03',150),
    (4,'2017-01-04',99),(5,'2017-01-05',145),(6,'2017-01-06',1455),
    (7,'2017-01-07',199),(8,'2017-01-09',188);

-- ----------------------------------------------------------------------------
-- Solution — "gaps and islands": group consecutive qualifying ids together.
-- ----------------------------------------------------------------------------
WITH busy AS (                                   -- only days that meet the threshold
    SELECT id, visit_date, people,
           id - ROW_NUMBER() OVER (ORDER BY id) AS grp   -- constant within a run
    FROM Stadium
    WHERE people >= 100
)
SELECT id, visit_date, people
FROM busy
WHERE grp IN (SELECT grp FROM busy GROUP BY grp HAVING COUNT(*) >= 3)
ORDER BY visit_date;

-- Approach: after filtering to people >= 100, consecutive ids still increase by
-- 1, but ROW_NUMBER() also increases by 1 — so (id - row_number) stays CONSTANT
-- across a consecutive run and changes when there's a gap. Group by that
-- constant, keep runs of length >= 3.
