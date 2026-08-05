-- ============================================================================
-- LeetCode 262 — Trips and Users  (Hard)
-- https://leetcode.com/problems/trips-and-users/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Trips(id, client_id, driver_id, city_id, status,
-- request_at) and Users(users_id, banned, role). For each day from 2013-10-01
-- to 2013-10-03, compute the CANCELLATION RATE among trips where NEITHER the
-- client nor the driver is banned. Rate = cancelled such trips / all such trips,
-- rounded to 2 decimals. Output columns: Day, Cancellation Rate.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Users (
    users_id INT PRIMARY KEY,
    banned   ENUM('No','Yes'),
    role     ENUM('client','driver','partner')
);
CREATE TABLE Trips (
    id         INT PRIMARY KEY,
    client_id  INT,
    driver_id  INT,
    city_id    INT,
    status     ENUM('completed','cancelled_by_driver','cancelled_by_client'),
    request_at DATE
);
INSERT INTO Users VALUES
    (1,'No','client'),(2,'Yes','client'),(3,'No','client'),(4,'No','client'),
    (10,'No','driver'),(11,'No','driver'),(12,'No','driver'),(13,'No','driver');
INSERT INTO Trips VALUES
    (1,1,10,1,'completed','2013-10-01'),
    (2,2,11,1,'cancelled_by_driver','2013-10-01'),
    (3,3,12,6,'completed','2013-10-01'),
    (4,4,13,6,'cancelled_by_client','2013-10-01'),
    (5,1,10,1,'completed','2013-10-02'),
    (6,2,11,6,'completed','2013-10-02'),
    (7,3,12,6,'completed','2013-10-02'),
    (8,2,12,12,'completed','2013-10-03'),
    (9,3,10,12,'completed','2013-10-03'),
    (10,4,13,12,'cancelled_by_driver','2013-10-03');

-- ----------------------------------------------------------------------------
-- Solution — join both users, keep only unbanned pairs, aggregate per day.
-- ----------------------------------------------------------------------------
SELECT
    t.request_at AS Day,
    ROUND(SUM(t.status <> 'completed') / COUNT(*), 2) AS `Cancellation Rate`
FROM Trips AS t
JOIN Users AS c ON t.client_id = c.users_id AND c.banned = 'No'
JOIN Users AS d ON t.driver_id = d.users_id AND d.banned = 'No'
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at;

-- Approach: joining Users twice (once for client, once for driver) with
-- banned='No' in the JOIN condition drops any trip involving a banned party.
-- In MySQL a boolean like (status <> 'completed') evaluates to 1/0, so SUM(...)
-- counts cancellations; dividing by COUNT(*) gives the rate.
