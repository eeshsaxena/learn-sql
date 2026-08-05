-- ============================================================================
-- Lesson 04 — Aggregates & GROUP BY
-- ----------------------------------------------------------------------------
-- Aggregate functions collapse MANY rows into ONE summary number:
--   COUNT  how many rows        SUM   total
--   AVG    average              MIN / MAX  smallest / largest
-- GROUP BY runs an aggregate once PER GROUP instead of once for the whole table.
-- ============================================================================

USE bookstore;

-- One number for the whole table.
SELECT COUNT(*) AS total_books FROM books;

-- COUNT(*) counts rows; COUNT(column) counts non-NULL values in that column.
-- AVG / SUM / MIN / MAX work on numeric columns.
SELECT
    COUNT(*)   AS num_books,
    AVG(price) AS avg_price,
    MIN(price) AS cheapest,
    MAX(price) AS priciest,
    SUM(stock) AS total_copies
FROM books;

-- GROUP BY splits rows into groups and gives one summary row per group.
-- "How many books, and average price, per genre?"
SELECT
    genre,
    COUNT(*)   AS num_books,
    AVG(price) AS avg_price
FROM books
GROUP BY genre;

-- Rule of thumb: every column in the SELECT is either INSIDE an aggregate
-- (COUNT/AVG/…) or listed in GROUP BY. Here `genre` is grouped; the rest are
-- aggregated.

-- You can sort the grouped result like any other query.
SELECT author_id, COUNT(*) AS book_count
FROM books
GROUP BY author_id
ORDER BY book_count DESC;

-- HAVING filters GROUPS, the way WHERE filters ROWS.
-- WHERE runs before grouping; HAVING runs after (so HAVING can use aggregates).
-- "Genres that have more than 2 books":
SELECT genre, COUNT(*) AS num_books
FROM books
GROUP BY genre
HAVING COUNT(*) > 2;

-- WHERE and HAVING together: filter rows first, then filter the groups.
-- "Among books priced under 16, which genres average over 12.50?"
SELECT genre, AVG(price) AS avg_price
FROM books
WHERE price < 16.00
GROUP BY genre
HAVING AVG(price) > 12.50;

-- ----------------------------------------------------------------------------
-- Try it yourself:
--   1. How many customers are there in total?
--   2. Count how many customers live in each city.
--   3. Show each genre's most expensive book price (MAX), highest first.
--   4. Find cities that have 2 or more customers (HAVING).
-- ----------------------------------------------------------------------------
