-- ============================================================================
-- Lesson 06 — Subqueries
-- ----------------------------------------------------------------------------
-- A subquery is a SELECT nested inside another query, wrapped in ( ).
-- It runs first and its result feeds the outer query. Great for questions that
-- reference the data twice ("books priced above the average").
-- ============================================================================

USE bookstore;

-- Scalar subquery: returns a SINGLE value, usable anywhere a value fits.
-- "Books priced above the overall average price."
-- The inner query computes one number (the average); the outer compares to it.
SELECT title, price
FROM books
WHERE price > (SELECT AVG(price) FROM books);

-- A scalar subquery can also appear in the SELECT list.
-- Show each book's price and how far it is from the average.
SELECT
    title,
    price,
    price - (SELECT AVG(price) FROM books) AS diff_from_avg
FROM books;

-- Subquery with IN: the inner query returns a LIST of values; the outer keeps
-- rows whose column is in that list.
-- "Books written by authors from the USA."
SELECT title
FROM books
WHERE author_id IN (SELECT author_id FROM authors WHERE country = 'USA');

-- The same idea to find which customers have ever ordered:
-- "Customers who appear in the orders table."
SELECT name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

-- ... and NOT IN to invert it: customers who have never ordered.
SELECT name
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- EXISTS: true if the subquery returns at least one row. Often used with a
-- CORRELATED subquery — one that refers to the outer row (see c.customer_id).
-- "Customers who have at least one shipped order."
SELECT c.name
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id      -- refers to the outer row
      AND o.status = 'shipped'
);

-- Note: the same questions can often be answered with a JOIN (Lesson 05).
-- Subqueries read more like the plain-English question; joins are usually
-- faster and let you return columns from both tables. Learn both.

-- ----------------------------------------------------------------------------
-- Try it yourself:
--   1. Find books cheaper than the average price (flip the > example).
--   2. Find authors who have at least one book (use IN with a subquery on books).
--   3. Find books that have never been ordered
--      (book_id NOT IN the order_items table).
-- ----------------------------------------------------------------------------
