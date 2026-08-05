-- ============================================================================
-- LeetCode 177 — Nth Highest Salary  (Medium)
-- https://leetcode.com/problems/nth-highest-salary/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Employee(id, salary). Write a function that returns the
-- Nth highest DISTINCT salary, or NULL if there is no Nth salary.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Employee (id INT PRIMARY KEY, salary INT);
INSERT INTO Employee VALUES (1,100),(2,200),(3,300);

-- ----------------------------------------------------------------------------
-- Solution — a stored function, exactly as LeetCode asks. LIMIT wants a
-- non-negative literal/variable, so compute the offset (N-1) into a variable.
-- ----------------------------------------------------------------------------
DELIMITER //
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE offset_n INT;
    SET offset_n = N - 1;
    RETURN (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET offset_n     -- skip N-1 salaries, take the next
    );
END //
DELIMITER ;

-- Use it:
SELECT getNthHighestSalary(2) AS getNthHighestSalary;   -- -> 200 for the sample

-- Approach: same DISTINCT + ORDER BY DESC + OFFSET idea as problem 176, but the
-- offset is N-1 for a general N. Returning a scalar subquery yields NULL when
-- the Nth salary doesn't exist. (Window-function alternative: DENSE_RANK() and
-- pick rank = N.)
