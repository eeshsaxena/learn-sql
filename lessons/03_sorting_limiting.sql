-- ============================================================================
-- Lesson 03 — Sorting & limiting
-- ----------------------------------------------------------------------------
-- ORDER BY sorts the result. LIMIT keeps only the first N rows. Together they
-- answer "top N" questions ("the 3 most expensive books", etc.).
-- ============================================================================

USE bookstore;

-- Sort ascending (ASC) is the default; you can leave it out.
SELECT title, price FROM books ORDER BY price;         -- cheapest first
SELECT title, price FROM books ORDER BY price ASC;     -- identical

-- Sort descending (DESC) for biggest first.
SELECT title, price FROM books ORDER BY price DESC;    -- most expensive first

-- Sort by more than one column. Here: genre A→Z, then within each genre,
-- price high→low. The second column breaks ties from the first.
SELECT genre, title, price
FROM books
ORDER BY genre ASC, price DESC;

-- You can sort by something you didn't select, or by an alias/expression.
SELECT title, price, price * stock AS inventory_value
FROM books
ORDER BY inventory_value DESC;

-- LIMIT keeps the first N rows AFTER sorting.
-- "The 3 most expensive books":
SELECT title, price
FROM books
ORDER BY price DESC
LIMIT 3;

-- OFFSET skips rows first — useful for "pages" of results.
-- Skip the top 3, then show the next 3 (books ranked 4th–6th by price):
SELECT title, price
FROM books
ORDER BY price DESC
LIMIT 3 OFFSET 3;

-- MySQL also allows the short form  LIMIT offset, count  (note the order!):
SELECT title, price
FROM books
ORDER BY price DESC
LIMIT 3, 3;                      -- same as LIMIT 3 OFFSET 3

-- WHERE + ORDER BY + LIMIT combine in that logical order:
-- filter, then sort what's left, then cut to N.
SELECT title, price
FROM books
WHERE genre = 'Science Fiction'
ORDER BY price ASC
LIMIT 2;

-- ----------------------------------------------------------------------------
-- Try it yourself:
--   1. List all customers ordered by join date, newest first.
--   2. Find the single cheapest book.
--   3. Show books sorted by stock (lowest first); of those, show only the
--      first 5.
-- ----------------------------------------------------------------------------
