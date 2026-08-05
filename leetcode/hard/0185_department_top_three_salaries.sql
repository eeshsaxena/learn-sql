-- ============================================================================
-- LeetCode 185 — Department Top Three Salaries  (Hard)
-- https://leetcode.com/problems/department-top-three-salaries/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Employee(id, name, salary, departmentId) and
-- Department(id, name). A "high earner" is someone in the top THREE DISTINCT
-- salaries of their department. Return every high earner. Output columns:
-- Department, Employee, Salary.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Department (id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE Employee (
    id INT PRIMARY KEY, name VARCHAR(50), salary INT, departmentId INT
);
INSERT INTO Department VALUES (1,'IT'), (2,'Sales');
INSERT INTO Employee VALUES
    (1,'Joe',85000,1),(2,'Henry',80000,2),(3,'Sam',60000,2),(4,'Max',90000,1),
    (5,'Janet',69000,1),(6,'Randy',85000,1),(7,'Will',70000,1);

-- ----------------------------------------------------------------------------
-- Solution — DENSE_RANK per department, keep ranks 1..3.
-- ----------------------------------------------------------------------------
SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary
FROM (
    SELECT name, salary, departmentId,
           DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rk
    FROM Employee
) AS e
JOIN Department AS d ON e.departmentId = d.id
WHERE e.rk <= 3;

-- Approach: same shape as 184, but keep rank <= 3 instead of = 1. DENSE_RANK is
-- essential: "top three DISTINCT salaries" means two people on the same salary
-- share a rank and don't use up two of the three slots.
