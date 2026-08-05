# learn-sql

A hands-on, beginner-friendly introduction to SQL using **MySQL**.

You learn by running real queries against a small **bookstore** database and reading
the comments that explain *why* each query works.

## The database

Five tables model a tiny online bookstore:

```
authors ──< books ──< order_items >── orders >── customers
```

- `authors` — people who write books
- `books` — each book has one author, a genre, a price, and a stock count
- `customers` — people who buy books
- `orders` — one row per placed order (belongs to a customer)
- `order_items` — the books inside an order (an order can have many books)

`──<` means "one to many": one author has many books; one order has many items.
See [`schema/01_schema.sql`](schema/01_schema.sql) for the exact columns and keys.

## Setup (2 minutes)

You need a running **MySQL** server (8.0+) and the `mysql` command-line client.
Install MySQL Community Server from https://dev.mysql.com/downloads/ (or `brew install mysql`,
`sudo apt install mysql-server`).

```bash
# Create the database and load the tables + sample data.
# The schema file creates a database named `bookstore` and switches into it.
mysql -u root -p < schema/01_schema.sql
mysql -u root -p < schema/02_seed.sql

# Open an interactive session already pointed at the bookstore database
mysql -u root -p bookstore
```

Handy things to type once you're inside the `mysql>` prompt:

```sql
SHOW TABLES;          -- list the tables
DESCRIBE books;       -- show the columns of one table
SOURCE lessons/01_select_basics.sql;   -- run a whole lesson file
\q                    -- quit
```

To run a whole lesson file from your shell instead:

```bash
mysql -u root -p bookstore < lessons/01_select_basics.sql
```

> **Note:** examples use `-u root -p` for simplicity. In real projects, create a
> dedicated user with only the privileges it needs rather than using `root`.

## Learning path

Work through the lessons in order — each builds on the last.

| # | Lesson | You'll learn |
|---|--------|--------------|
| 01 | [SELECT basics](lessons/01_select_basics.sql) | reading columns, aliases, `DISTINCT`, calculated columns |
| 02 | [Filtering with WHERE](lessons/02_filtering_where.sql) | `=`, `<`, `AND`/`OR`, `BETWEEN`, `IN`, `LIKE`, `IS NULL` |
| 03 | [Sorting & limiting](lessons/03_sorting_limiting.sql) | `ORDER BY`, `LIMIT`, `OFFSET` |
| 04 | [Aggregates & GROUP BY](lessons/04_aggregates_group_by.sql) | `COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING` |
| 05 | [Joining tables](lessons/05_joins.sql) | `INNER JOIN`, `LEFT JOIN`, joining three tables |
| 06 | [Subqueries](lessons/06_subqueries.sql) | scalar subqueries, `IN (SELECT …)`, `EXISTS` |
| 07 | [Changing data](lessons/07_modifying_data.sql) | `INSERT`, `UPDATE`, `DELETE` (safely) |
| 08 | [Views & indexes](lessons/08_views_indexes.sql) | `CREATE VIEW`, `CREATE INDEX`, and why they help |

Then test yourself: [`exercises/exercises.sql`](exercises/exercises.sql) has 12 questions.
Try each one before peeking at [`exercises/solutions.sql`](exercises/solutions.sql).

## Tip

If you make a mess of the data (say, after Lesson 07), just rebuild from scratch —
`schema/01_schema.sql` drops and recreates the database:

```bash
mysql -u root -p < schema/01_schema.sql
mysql -u root -p < schema/02_seed.sql
```

Happy querying!
