-- ============================================================================
-- Exercises — write a query for each question.
-- ----------------------------------------------------------------------------
-- Work against the seeded bookstore database. Try each one before checking
-- solutions.sql. They roughly follow the lesson order (easy -> harder).
-- ============================================================================

USE bookstore;

-- 01. (Lesson 01) List the title and price of every book.

-- 02. (Lesson 02) List books priced under 12.00.

-- 03. (Lesson 02) List customers who live in Bengaluru.

-- 04. (Lesson 03) Show the 3 newest books (by published_year), newest first.

-- 05. (Lesson 04) How many books are there in each genre?

-- 06. (Lesson 04) Which authors have written more than 2 books?
--     (Show author_id and the count.)

-- 07. (Lesson 05) List each book's title alongside its author's name.

-- 08. (Lesson 05) List every customer and how many orders they have placed,
--     including customers with zero orders.

-- 09. (Lesson 05) What is the total value (quantity * unit_price) of order #7?

-- 10. (Lesson 06) List books more expensive than the average book price.

-- 11. (Lesson 06) List customers who have never placed an order.

-- 12. (Lessons 04/05) Which genre has produced the most total revenue across all
--     order_items? (Join order_items -> books, group by genre, sum
--     quantity * unit_price, highest first.)
