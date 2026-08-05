-- ============================================================================
-- 01_schema.sql — the bookstore database structure (MySQL 8.0+)
-- ----------------------------------------------------------------------------
-- Run this first:   mysql -u root -p < schema/01_schema.sql
-- It DROPS and recreates the `bookstore` database, so it's safe to re-run
-- whenever you want a clean slate.
-- ============================================================================

DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bookstore;

-- ----------------------------------------------------------------------------
-- authors: one row per author.
-- ----------------------------------------------------------------------------
CREATE TABLE authors (
    author_id   INT AUTO_INCREMENT PRIMARY KEY,   -- unique id, filled in automatically
    name        VARCHAR(100) NOT NULL,            -- NOT NULL = a value is required
    country     VARCHAR(60)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- books: each book is written by exactly one author.
--   author_id is a FOREIGN KEY -> it must match an authors.author_id.
-- ----------------------------------------------------------------------------
CREATE TABLE books (
    book_id         INT AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(200) NOT NULL,
    author_id       INT NOT NULL,
    genre           VARCHAR(40),
    price           DECIMAL(6,2) NOT NULL,        -- money: exact, up to 9999.99
    published_year  SMALLINT,
    stock           INT NOT NULL DEFAULT 0,       -- copies on hand (default 0)
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- customers: people who place orders.
-- ----------------------------------------------------------------------------
CREATE TABLE customers (
    customer_id  INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    email        VARCHAR(120) NOT NULL UNIQUE,     -- UNIQUE = no two customers share an email
    city         VARCHAR(60),
    joined_date  DATE NOT NULL
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- orders: one row per placed order. Belongs to one customer.
--   status can only be one of the listed values (ENUM enforces that).
-- ----------------------------------------------------------------------------
CREATE TABLE orders (
    order_id     INT AUTO_INCREMENT PRIMARY KEY,
    customer_id  INT NOT NULL,
    order_date   DATE NOT NULL,
    status       ENUM('pending','paid','shipped','cancelled') NOT NULL DEFAULT 'pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- order_items: the line items of an order (which books, how many).
--   The primary key is the PAIR (order_id, book_id): the same book appears
--   at most once per order. This is a "composite" primary key.
--   unit_price is stored per row so historical orders keep the price the
--   customer actually paid, even if books.price changes later.
-- ----------------------------------------------------------------------------
CREATE TABLE order_items (
    order_id    INT NOT NULL,
    book_id     INT NOT NULL,
    quantity    INT NOT NULL,
    unit_price  DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id)  REFERENCES books(book_id)
) ENGINE=InnoDB;
