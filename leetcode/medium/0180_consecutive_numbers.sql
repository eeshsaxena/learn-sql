-- ============================================================================
-- LeetCode 180 — Consecutive Numbers  (Medium)
-- https://leetcode.com/problems/consecutive-numbers/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Logs(id, num), where id increases. Return every number
-- that appears at least THREE times in a row (in consecutive id order).
-- Output column: ConsecutiveNums.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Logs (id INT PRIMARY KEY, num INT);
INSERT INTO Logs VALUES (1,1),(2,1),(3,1),(4,2),(5,1),(6,2),(7,2);

-- ----------------------------------------------------------------------------
-- Solution — compare each row with the two rows before it using LAG().
-- ----------------------------------------------------------------------------
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT
        num,
        LAG(num, 1) OVER (ORDER BY id) AS prev1,   -- the value one row back
        LAG(num, 2) OVER (ORDER BY id) AS prev2    -- two rows back
    FROM Logs
) AS w
WHERE num = prev1 AND num = prev2;

-- Approach: LAG(col, k) looks k rows back in the ordering. If the current row
-- equals the previous two, that's a run of 3+. DISTINCT dedupes numbers with
-- multiple qualifying runs. (Classic alternative: self-join Logs three times on
-- id, id+1, id+2.)
