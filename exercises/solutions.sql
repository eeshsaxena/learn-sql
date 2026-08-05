-- ============================================================================
-- Solutions — one correct answer per exercise.
-- ----------------------------------------------------------------------------
-- SQL often has several valid answers; if yours returns the same rows, it's
-- fine even if it looks different.
-- ============================================================================

USE bookstore;

-- 01.
SELECT title, price FROM books;

-- 02.
SELECT title, price FROM books WHERE price < 12.00;

-- 03.
SELECT name, city FROM customers WHERE city = 'Bengaluru';

-- 04.
SELECT title, published_year
FROM books
ORDER BY published_year DESC
LIMIT 3;

-- 05.
SELECT genre, COUNT(*) AS num_books
FROM books
GROUP BY genre;

-- 06.
SELECT author_id, COUNT(*) AS book_count
FROM books
GROUP BY author_id
HAVING COUNT(*) > 2;

-- 07.
SELECT b.title, a.name AS author
FROM books AS b
JOIN authors AS a ON b.author_id = a.author_id;

-- 08. LEFT JOIN so customers with no orders still show (with a count of 0).
--     COUNT(o.order_id) counts only matched orders, so zero comes out as 0.
SELECT c.name, COUNT(o.order_id) AS num_orders
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY num_orders DESC;

-- 09.
SELECT SUM(quantity * unit_price) AS order_7_total
FROM order_items
WHERE order_id = 7;

-- 10.
SELECT title, price
FROM books
WHERE price > (SELECT AVG(price) FROM books);

-- 11.
SELECT name
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- 12.
SELECT b.genre, SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items AS oi
JOIN books AS b ON oi.book_id = b.book_id
GROUP BY b.genre
ORDER BY revenue DESC;
