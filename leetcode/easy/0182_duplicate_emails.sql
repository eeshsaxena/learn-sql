-- ============================================================================
-- LeetCode 182 — Duplicate Emails  (Easy)
-- https://leetcode.com/problems/duplicate-emails/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Person(id, email). Return every email address that
-- appears more than once. Output column name: Email.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Person (
    id    INT PRIMARY KEY,
    email VARCHAR(100)
);
INSERT INTO Person VALUES (1,'a@b.com'), (2,'c@d.com'), (3,'a@b.com');

-- ----------------------------------------------------------------------------
-- Solution — group by the value, keep groups with more than one row.
-- ----------------------------------------------------------------------------
SELECT email AS Email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

-- Approach: GROUP BY collapses identical emails into one group; HAVING filters
-- those groups (WHERE can't, because the count only exists after grouping).
