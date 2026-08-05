-- ============================================================================
-- LeetCode 178 — Rank Scores  (Medium)
-- https://leetcode.com/problems/rank-scores/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Scores(id, score). Rank the scores highest first. Equal
-- scores get the SAME rank, and the next rank has NO gap (1,1,2,3 — not 1,1,3).
-- Return score and rank, ordered by score descending. Output columns: score, rank.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Scores (id INT PRIMARY KEY, score DECIMAL(3,2));
INSERT INTO Scores VALUES (1,3.50),(2,3.65),(3,4.00),(4,3.85),(5,4.00),(6,3.65);

-- ----------------------------------------------------------------------------
-- Solution — DENSE_RANK() is exactly "same value = same rank, no gaps".
-- `rank` is a reserved word in MySQL 8, so it must be quoted with backticks.
-- ----------------------------------------------------------------------------
SELECT
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS `rank`
FROM Scores
ORDER BY score DESC;

-- Approach: three "ranking" window functions differ in ties:
--   ROW_NUMBER() -> 1,2,3,4 (no ties, arbitrary tiebreak)
--   RANK()       -> 1,1,3,4 (ties share, then a GAP)
--   DENSE_RANK() -> 1,1,2,3 (ties share, NO gap)  <-- what this problem wants.
