-- ============================================================================
-- Lesson 05 — Joining tables
-- ----------------------------------------------------------------------------
-- Data is split across tables to avoid repetition. JOIN stitches rows back
-- together by matching a key. This is the heart of relational databases.
-- ============================================================================

USE bookstore;

-- INNER JOIN: keep only rows that have a match on BOTH sides.
-- Each book has an author_id; we match it to authors.author_id to get the name.
-- `b` and `a` are table aliases so we don't have to type the full name each time.
SELECT b.title, a.name AS author
FROM books AS b
INNER JOIN authors AS a ON b.author_id = a.author_id;

-- When a column name exists in both tables (author_id here), qualify it with the
-- table alias (b.author_id) so it's unambiguous.

-- LEFT JOIN: keep EVERY row from the left table, even if there's no match on the
-- right. Unmatched right-side columns come back as NULL.
-- "Every customer and their orders" — Farah has no orders, so her order_id is NULL.
SELECT c.name, o.order_id, o.order_date
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
ORDER BY c.name;

-- A LEFT JOIN + IS NULL is the classic way to find "rows with no match":
-- customers who have never ordered.
SELECT c.name
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Join THREE tables by chaining JOINs. Follow the key path:
-- orders -> order_items (which books) -> books (their titles).
SELECT o.order_id, b.title, oi.quantity, oi.unit_price
FROM orders AS o
INNER JOIN order_items AS oi ON o.order_id  = oi.order_id
INNER JOIN books       AS b  ON oi.book_id  = b.book_id
ORDER BY o.order_id;

-- Joins combine happily with GROUP BY. Here we compute each order's total
-- value = sum of (quantity * unit_price) across its items.
SELECT
    o.order_id,
    c.name AS customer,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders AS o
INNER JOIN customers   AS c  ON o.customer_id = c.customer_id
INNER JOIN order_items AS oi ON o.order_id    = oi.order_id
GROUP BY o.order_id, c.name
ORDER BY order_total DESC;

-- ----------------------------------------------------------------------------
-- Try it yourself:
--   1. List every book title next to its author's country.
--   2. Show each order's id, the customer's name, and the order status.
--   3. Find authors who have NO books in stock right now
--      (hint: join books, then think about SUM(stock) per author with HAVING).
-- ----------------------------------------------------------------------------
