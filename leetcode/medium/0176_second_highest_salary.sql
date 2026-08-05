-- ============================================================================
-- LeetCode 176 — Second Highest Salary  (Medium)
-- https://leetcode.com/problems/second-highest-salary/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Employee(id, salary). Return the second highest DISTINCT
-- salary. If it doesn't exist (fewer than 2 distinct salaries), return NULL.
-- Output column: SecondHighestSalary.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Employee (id INT PRIMARY KEY, salary INT);
INSERT INTO Employee VALUES (1,100), (2,200), (3,300);

-- ----------------------------------------------------------------------------
-- Solution — wrap the ordered/offset lookup in an outer SELECT so a missing
-- row comes back as NULL instead of "no rows".
-- ----------------------------------------------------------------------------
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1        -- skip the highest, take the next
) AS SecondHighestSalary;

-- Approach: DISTINCT + ORDER BY DESC + OFFSET 1 gives the 2nd-highest salary.
-- The key trick is the OUTER SELECT: if the inner query returns nothing, the
-- outer scalar subquery yields NULL, satisfying the "return NULL" requirement.
-- (A plain query with LIMIT would return an empty set instead of a NULL row.)
