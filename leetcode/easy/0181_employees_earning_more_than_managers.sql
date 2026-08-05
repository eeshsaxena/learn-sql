-- ============================================================================
-- LeetCode 181 — Employees Earning More Than Their Managers  (Easy)
-- https://leetcode.com/problems/employees-earning-more-than-their-managers/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Employee(id, name, salary, managerId). managerId points at
-- another row's id. Return the names of employees who earn strictly more than
-- their own manager. Output column name: Employee.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Employee (
    id        INT PRIMARY KEY,
    name      VARCHAR(50),
    salary    INT,
    managerId INT
);
INSERT INTO Employee VALUES
    (1,'Joe',70000,3), (2,'Henry',80000,4), (3,'Sam',60000,NULL), (4,'Max',90000,NULL);

-- ----------------------------------------------------------------------------
-- Solution — self-join: the same table twice, once as employee, once as manager.
-- ----------------------------------------------------------------------------
SELECT e.name AS Employee
FROM Employee AS e
JOIN Employee AS m ON e.managerId = m.id
WHERE e.salary > m.salary;

-- Approach: a "manager" is just another Employee row, so we join the table to
-- itself. The INNER JOIN also conveniently drops top-level bosses (managerId NULL).
