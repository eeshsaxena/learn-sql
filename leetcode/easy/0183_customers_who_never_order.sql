-- ============================================================================
-- LeetCode 183 — Customers Who Never Order  (Easy)
-- https://leetcode.com/problems/customers-who-never-order/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Customers(id, name) and Orders(id, customerId). Return the
-- names of customers who have never placed an order. Output column: Customers.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Customers (id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE Orders    (id INT PRIMARY KEY, customerId INT);

INSERT INTO Customers VALUES (1,'Joe'), (2,'Henry'), (3,'Sam'), (4,'Max');
INSERT INTO Orders    VALUES (1,3), (2,1);

-- ----------------------------------------------------------------------------
-- Solution A — anti-join with NOT IN.
-- ----------------------------------------------------------------------------
SELECT name AS Customers
FROM Customers
WHERE id NOT IN (SELECT customerId FROM Orders);

-- Solution B — LEFT JOIN then keep the rows that found no match (o.id IS NULL).
-- SELECT c.name AS Customers
-- FROM Customers c
-- LEFT JOIN Orders o ON c.id = o.customerId
-- WHERE o.id IS NULL;

-- Approach: "never order" = a customer with no matching row in Orders. Both the
-- NOT IN anti-join and the LEFT JOIN + IS NULL express that. (With NOT IN,
-- beware NULLs in the subquery list; here customerId is never NULL.)
