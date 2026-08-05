-- ============================================================================
-- LeetCode 175 — Combine Two Tables  (Easy)
-- https://leetcode.com/problems/combine-two-tables/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): You have a Person table and an Address table. Return
-- firstName, lastName, city and state for every person. If a person has no
-- matching address row, still list them, with city and state as NULL.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Person (
    personId  INT PRIMARY KEY,
    lastName  VARCHAR(50),
    firstName VARCHAR(50)
);
CREATE TABLE Address (
    addressId INT PRIMARY KEY,
    personId  INT,
    city      VARCHAR(50),
    state     VARCHAR(50)
);

INSERT INTO Person VALUES (1,'Wang','Allen'), (2,'Alice','Bob');
INSERT INTO Address VALUES (1,2,'New York City','New York'), (2,3,'Leetcode','California');

-- ----------------------------------------------------------------------------
-- Solution — LEFT JOIN keeps every Person even without an address.
-- ----------------------------------------------------------------------------
SELECT p.firstName, p.lastName, a.city, a.state
FROM Person AS p
LEFT JOIN Address AS a ON p.personId = a.personId;

-- Approach: The "still list them even with no address" requirement is the tell
-- for a LEFT JOIN (an INNER JOIN would drop Allen, who has no address).
