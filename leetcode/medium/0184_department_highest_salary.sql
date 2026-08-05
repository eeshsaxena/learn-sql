-- ============================================================================
-- LeetCode 184 — Department Highest Salary  (Medium)
-- https://leetcode.com/problems/department-highest-salary/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Employee(id, name, salary, departmentId) and
-- Department(id, name). For each department, return the employee(s) with the
-- highest salary. If several tie for the top, return all of them.
-- Output columns: Department, Employee, Salary.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Department (id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE Employee (
    id INT PRIMARY KEY, name VARCHAR(50), salary INT, departmentId INT
);
INSERT INTO Department VALUES (1,'IT'), (2,'Sales');
INSERT INTO Employee VALUES
    (1,'Joe',85000,1),(2,'Henry',80000,2),(3,'Sam',60000,2),
    (4,'Max',90000,1),(5,'Janet',69000,1),(6,'Randy',85000,1);

-- ----------------------------------------------------------------------------
-- Solution — rank salaries within each department, keep rank 1 (ties included).
-- ----------------------------------------------------------------------------
SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary
FROM (
    SELECT name, salary, departmentId,
           DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rk
    FROM Employee
) AS e
JOIN Department AS d ON e.departmentId = d.id
WHERE e.rk = 1;

-- Approach: PARTITION BY departmentId restarts the ranking for each department;
-- ORDER BY salary DESC makes rank 1 the top salary. DENSE_RANK keeps ties, so
-- two people sharing the department max both come back.
