-- ============================================================================
-- Lesson 07 — Changing data: INSERT, UPDATE, DELETE
-- ----------------------------------------------------------------------------
-- These statements CHANGE the database. The golden rule:
--   *** UPDATE and DELETE without a WHERE clause hit EVERY row. ***
-- Always write (and mentally check) the WHERE first.
--
-- Everything here is reversible: rebuild the clean database any time with
--   mysql -u root -p < schema/01_schema.sql
--   mysql -u root -p < schema/02_seed.sql
-- ============================================================================

USE bookstore;

-- INSERT: add new rows. List the columns, then the matching values.
-- We omit author_id so AUTO_INCREMENT assigns the next one automatically.
INSERT INTO authors (name, country) VALUES ('N. K. Jemisin', 'USA');

-- Insert several rows at once with comma-separated value lists.
INSERT INTO customers (name, email, city, joined_date) VALUES
    ('Grace Lee',   'grace@example.com', 'Seoul',  '2025-02-01'),
    ('Hassan Ali',  'hassan@example.com','Cairo',  '2025-02-15');

-- LAST_INSERT_ID() returns the id AUTO_INCREMENT just generated — handy when
-- you need the new author's id to insert their book.
INSERT INTO books (title, author_id, genre, price, published_year, stock)
VALUES ('The Fifth Season', LAST_INSERT_ID(), 'Fantasy', 15.99, 2015, 10);
-- (LAST_INSERT_ID() here refers to the customers insert above, so in practice
--  you'd capture the author's id right after inserting the author. Rebuild and
--  try it in that order to see it work cleanly.)

-- UPDATE: change existing rows. SET the new values; WHERE picks which rows.
-- Give book 3 some stock.
UPDATE books SET stock = 6 WHERE book_id = 3;

-- Update using the existing value: raise the price of all Fantasy books by 1.00.
UPDATE books SET price = price + 1.00 WHERE genre = 'Fantasy';

-- Change one order's status.
UPDATE orders SET status = 'shipped' WHERE order_id = 6;

-- DELETE: remove rows. WHERE decides which. (No WHERE = delete them all!)
-- Remove a specific line item.
DELETE FROM order_items WHERE order_id = 4 AND book_id = 6;

-- Because of the FOREIGN KEY, MySQL won't let you delete a row that other rows
-- still reference. This DELETE fails if order 1 still has order_items pointing
-- at it — delete the children first, or set up ON DELETE rules. Try it:
-- DELETE FROM orders WHERE order_id = 1;   -- errors while items 1/4 exist

-- A safe cleanup: remove all cancelled orders' items, then the orders.
DELETE FROM order_items
WHERE order_id IN (SELECT order_id FROM orders WHERE status = 'cancelled');
DELETE FROM orders WHERE status = 'cancelled';

-- ----------------------------------------------------------------------------
-- Try it yourself (then rebuild the DB to reset):
--   1. Insert yourself as a customer.
--   2. Mark every 'pending' order as 'cancelled'.
--   3. Delete the customer you just added (make sure they have no orders first).
-- ----------------------------------------------------------------------------
