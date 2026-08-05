-- ============================================================================
-- Lesson 01 — SELECT basics
-- ----------------------------------------------------------------------------
-- SELECT reads rows from a table. It never changes data, so experiment freely.
-- Run a single query below by copying it into the mysql> prompt, or run the
-- whole file:  mysql -u root -p bookstore < lessons/01_select_basics.sql
-- ============================================================================

USE bookstore;

-- Every column of every row. The `*` means "all columns".
-- Great for exploring; avoid it in real apps (you usually want specific columns).
SELECT * FROM books;

-- Just the columns you care about, in the order you list them.
SELECT title, price FROM books;

-- Rename a column in the OUTPUT with AS (an "alias"). The table is unchanged.
-- Aliases are handy when a column name is cryptic or computed.
SELECT title AS book_title, price AS price_usd FROM books;

-- Columns can be CALCULATED. Here we work out the price with a 10% discount.
-- The result column has no natural name, so we alias it.
SELECT title, price, price * 0.90 AS sale_price FROM books;

-- DISTINCT removes duplicate rows from the result.
-- Many books share a genre, so this lists each genre only once.
SELECT DISTINCT genre FROM books;

-- You can concatenate text. CONCAT joins strings together.
SELECT CONCAT(name, ' (', country, ')') AS author_label FROM authors;

-- SELECT can also just evaluate an expression, with no table at all.
SELECT 2 + 3 AS sum_demo, UPPER('hello') AS shout;

-- ----------------------------------------------------------------------------
-- Try it yourself:
--   1. Show only the `name` and `city` columns from customers.
--   2. Show each book's title and its price increased by 2.00 (call it new_price).
--   3. List the distinct list of countries that authors come from.
-- ----------------------------------------------------------------------------
