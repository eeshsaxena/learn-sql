-- ============================================================================
-- LeetCode 197 — Rising Temperature  (Medium)
-- https://leetcode.com/problems/rising-temperature/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Weather(id, recordDate, temperature). Return the id of any
-- day whose temperature is higher than the day EXACTLY one calendar day before.
-- Output column: id.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Weather (
    id INT PRIMARY KEY,
    recordDate DATE,
    temperature INT
);
INSERT INTO Weather VALUES
    (1,'2015-01-01',10),(2,'2015-01-02',25),(3,'2015-01-03',20),(4,'2015-01-04',30);

-- ----------------------------------------------------------------------------
-- Solution — join each day to "yesterday" and compare temperatures.
-- ----------------------------------------------------------------------------
SELECT today.id AS id
FROM Weather AS today
JOIN Weather AS yday
    ON today.recordDate = DATE_ADD(yday.recordDate, INTERVAL 1 DAY)
WHERE today.temperature > yday.temperature;

-- Approach: match a row to the row one day earlier via DATE_ADD(..., INTERVAL 1
-- DAY). Compare on the DATE — do NOT use id-1, because ids may skip missing days.
-- Equivalent: ON DATEDIFF(today.recordDate, yday.recordDate) = 1.
