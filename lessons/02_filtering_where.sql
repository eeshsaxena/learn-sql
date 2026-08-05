-- ============================================================================
-- Lesson 02 — Filtering with WHERE
-- ----------------------------------------------------------------------------
-- WHERE keeps only the rows that match a condition. It runs BEFORE the columns
-- are chosen, so you can filter on columns you don't even SELECT.
-- ============================================================================

USE bookstore;

-- Comparison operators: =  <>  <  <=  >  >=
-- Note: SQL uses a single = for equality (not == like many languages).
SELECT title, price FROM books WHERE price < 13.00;

SELECT title, genre FROM books WHERE genre = 'Science Fiction';

-- Combine conditions with AND (both must be true) / OR (either can be true).
-- AND binds tighter than OR, so use parentheses when you mix them.
SELECT title, genre, price
FROM books
WHERE genre = 'Magical Realism' AND price < 13.00;

SELECT title, published_year
FROM books
WHERE published_year < 1960 OR published_year >= 2000;

-- NOT flips a condition.
SELECT title, stock FROM books WHERE NOT stock = 0;   -- same as stock <> 0

-- BETWEEN a AND b is an inclusive range (a and b are both included).
SELECT title, price FROM books WHERE price BETWEEN 12.00 AND 15.00;

-- IN (...) matches any value in a list — cleaner than lots of OR conditions.
SELECT title, genre
FROM books
WHERE genre IN ('Fantasy', 'Literary');

-- LIKE does pattern matching on text:
--   %  = any run of characters (including none)
--   _  = exactly one character
SELECT title FROM books WHERE title LIKE 'The %';   -- titles starting with "The "
SELECT name  FROM customers WHERE name LIKE '%a';   -- names ending in "a"

-- NULL means "unknown / no value". You CANNOT test it with = ; use IS NULL.
-- (No books have a NULL genre in the seed data, so this returns nothing —
--  that's the point: IS NULL is how you'd find them if they existed.)
SELECT title FROM books WHERE genre IS NULL;
SELECT title FROM books WHERE genre IS NOT NULL;

-- ----------------------------------------------------------------------------
-- Try it yourself:
--   1. Find books published in the 1970s (1970–1979 inclusive).
--   2. Find customers who are NOT in Bengaluru.
--   3. Find books whose title contains the word "the" anywhere (any case).
-- ----------------------------------------------------------------------------
