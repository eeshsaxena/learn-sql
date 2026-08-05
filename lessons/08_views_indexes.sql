-- ============================================================================
-- Lesson 08 — Views & indexes
-- ----------------------------------------------------------------------------
-- Two everyday tools:
--   VIEW  = a saved query you can treat like a table (for convenience/clarity).
--   INDEX = a lookup structure that makes filtering/joining a column faster.
-- ============================================================================

USE bookstore;

-- A VIEW gives a name to a query. It stores no data of its own — every time you
-- select from it, the underlying query runs against the current data.
-- Here we package the "order totals" join from Lesson 05.
CREATE OR REPLACE VIEW order_totals AS
SELECT
    o.order_id,
    o.customer_id,
    o.status,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.customer_id, o.status;

-- Now query the view as if it were a table — much easier to read.
SELECT * FROM order_totals ORDER BY order_total DESC;

-- Views compose: build on the view instead of repeating the join.
-- "Total revenue from orders that were actually paid or shipped."
SELECT SUM(order_total) AS realized_revenue
FROM order_totals
WHERE status IN ('paid', 'shipped');

-- Remove a view when you no longer need it.
-- DROP VIEW order_totals;

-- ----------------------------------------------------------------------------
-- INDEXES
-- ----------------------------------------------------------------------------
-- Without an index, filtering a column means scanning every row. An index lets
-- MySQL jump straight to matching rows — like a book's index vs. reading cover
-- to cover. PRIMARY KEY and UNIQUE columns are indexed automatically.
--
-- Index columns you frequently FILTER or JOIN on. Here we often look up books
-- by genre and join orders by customer_id:
CREATE INDEX idx_books_genre       ON books(genre);
CREATE INDEX idx_orders_customer   ON orders(customer_id);

-- See the indexes on a table.
SHOW INDEX FROM books;

-- EXPLAIN shows MySQL's plan for a query — how it will find the rows. After the
-- index above, filtering by genre can use `idx_books_genre` instead of a full
-- table scan (look for the index name in the `key` column of the output).
EXPLAIN SELECT title FROM books WHERE genre = 'Fantasy';

-- The trade-off: indexes speed up reads but slightly slow down writes (each
-- INSERT/UPDATE must also update the index) and use disk space. Index the
-- columns your queries actually search on — not every column.

-- Remove an index you no longer need.
-- DROP INDEX idx_books_genre ON books;

-- ----------------------------------------------------------------------------
-- Try it yourself:
--   1. Create a view `customer_spend` that shows each customer's name and their
--      total spend across all orders (join customers -> order_totals).
--   2. Add an index on customers(city) and EXPLAIN a query that filters by city.
-- ----------------------------------------------------------------------------
