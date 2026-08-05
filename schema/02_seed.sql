-- ============================================================================
-- 02_seed.sql — sample data for the bookstore database
-- ----------------------------------------------------------------------------
-- Run this AFTER 01_schema.sql:   mysql -u root -p < schema/02_seed.sql
-- We set the ids explicitly here so the foreign keys below line up and the
-- lesson results are predictable.
-- ============================================================================

USE bookstore;

-- Authors -------------------------------------------------------------------
INSERT INTO authors (author_id, name, country) VALUES
    (1, 'Ursula K. Le Guin', 'USA'),
    (2, 'Chinua Achebe',     'Nigeria'),
    (3, 'Haruki Murakami',   'Japan'),
    (4, 'Octavia E. Butler', 'USA'),
    (5, 'Jorge Luis Borges', 'Argentina');

-- Books ---------------------------------------------------------------------
INSERT INTO books (book_id, title, author_id, genre, price, published_year, stock) VALUES
    (1,  'A Wizard of Earthsea',      1, 'Fantasy',        12.99, 1968, 20),
    (2,  'The Left Hand of Darkness', 1, 'Science Fiction',14.50, 1969,  8),
    (3,  'The Dispossessed',          1, 'Science Fiction',15.00, 1974,  0),
    (4,  'Things Fall Apart',         2, 'Literary',       11.25, 1958, 35),
    (5,  'No Longer at Ease',         2, 'Literary',       10.75, 1960,  5),
    (6,  'Norwegian Wood',            3, 'Literary',       13.40, 1987, 12),
    (7,  'Kafka on the Shore',        3, 'Magical Realism',16.20, 2002, 18),
    (8,  '1Q84',                      3, 'Magical Realism',19.99, 2009,  3),
    (9,  'Kindred',                   4, 'Science Fiction',13.00, 1979, 25),
    (10, 'Parable of the Sower',      4, 'Science Fiction',14.75, 1993,  9),
    (11, 'Ficciones',                 5, 'Magical Realism',12.10, 1944,  7),
    (12, 'The Aleph',                 5, 'Magical Realism',12.60, 1949,  0);

-- Customers -----------------------------------------------------------------
INSERT INTO customers (customer_id, name, email, city, joined_date) VALUES
    (1, 'Aisha Khan',     'aisha@example.com',   'Bengaluru', '2023-01-15'),
    (2, 'Ben Carter',     'ben@example.com',     'London',    '2023-03-02'),
    (3, 'Chen Wei',       'chen@example.com',    'Singapore', '2023-06-20'),
    (4, 'Diego Alvarez',  'diego@example.com',   'Madrid',    '2024-02-11'),
    (5, 'Emma Schmidt',   'emma@example.com',    'Berlin',    '2024-05-30'),
    (6, 'Farah Ahmed',    'farah@example.com',   'Bengaluru', '2024-09-05');

-- Orders --------------------------------------------------------------------
INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
    (1, 1, '2024-03-01', 'shipped'),
    (2, 1, '2024-07-18', 'paid'),
    (3, 2, '2024-04-22', 'shipped'),
    (4, 3, '2024-08-09', 'cancelled'),
    (5, 3, '2024-10-01', 'paid'),
    (6, 4, '2024-11-14', 'pending'),
    (7, 5, '2025-01-07', 'shipped');
-- (Customer 6, Farah, has not placed an order yet — useful for LEFT JOIN examples.)

-- Order items ---------------------------------------------------------------
INSERT INTO order_items (order_id, book_id, quantity, unit_price) VALUES
    (1, 1,  1, 12.99),
    (1, 4,  2, 11.25),
    (2, 7,  1, 16.20),
    (2, 8,  1, 19.99),
    (3, 2,  1, 14.50),
    (3, 9,  3, 13.00),
    (4, 6,  1, 13.40),   -- this order was later cancelled
    (5, 10, 2, 14.75),
    (5, 11, 1, 12.10),
    (6, 1,  1, 12.99),
    (7, 4,  1, 11.25),
    (7, 5,  2, 10.75),
    (7, 9,  1, 13.00);
