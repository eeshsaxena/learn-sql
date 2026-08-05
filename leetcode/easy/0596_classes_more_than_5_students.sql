-- ============================================================================
-- LeetCode 596 — Classes With At Least 5 Students  (Easy)
-- https://leetcode.com/problems/classes-more-than-5-students/
-- ----------------------------------------------------------------------------
-- Task (paraphrased): Courses(student, class). Return every class that has at
-- least 5 students. Output column: class.
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS lc; CREATE DATABASE lc; USE lc;

CREATE TABLE Courses (
    student VARCHAR(50),
    class   VARCHAR(50),
    PRIMARY KEY (student, class)   -- a student takes a class at most once
);
INSERT INTO Courses VALUES
    ('A','Math'),('B','Math'),('C','Math'),('D','Math'),('E','Math'),
    ('F','Biology'),('G','Biology');

-- ----------------------------------------------------------------------------
-- Solution — count students per class, keep classes with >= 5.
-- ----------------------------------------------------------------------------
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;

-- Approach: COUNT(DISTINCT student) guards against the same student being
-- counted twice; HAVING filters the grouped result (WHERE runs before grouping).
