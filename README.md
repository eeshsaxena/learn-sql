# learn-sql — SQL & DBMS for placement prep

A complete, from-scratch resource to learn **SQL** hands-on and master **DBMS
theory** for interviews and campus placements. Everything runs on **MySQL**.

Beginner-friendly and practical: you learn SQL by running real queries against a
small **bookstore** database, then build up the DBMS theory that interviews test.

## What's inside

| Folder | What it is |
|---|---|
| [`STUDY_GUIDE.md`](STUDY_GUIDE.md) | **Start here** — a day-by-day plan from zero to interview-ready |
| [`schema/`](schema/) | The bookstore database: tables (`01_schema.sql`) + sample data (`02_seed.sql`) |
| [`lessons/`](lessons/) | 8 commented, progressive SQL lessons (SELECT → views/indexes) |
| [`exercises/`](exercises/) | 12 practice questions + worked solutions |
| [`leetcode/`](leetcode/README.md) | 14 LeetCode SQL problems (easy → hard) with solutions |
| [`dbms-theory/`](dbms-theory/00_index.md) | A-to-Z DBMS notes (ER, keys, normalization, ACID, indexing…) |
| [`practice/`](practice/word_problems.md) | Scenario/"word problem" questions: design, normalize, query |
| [`interview/`](interview/infosys.md) | Infosys + common DBMS/SQL interview Q&A |
| [`resources.md`](resources.md) | Recommended videos, platforms, and books |

## The database
Five tables model a tiny online bookstore:

```
authors ──< books ──< order_items >── orders >── customers
```

`──<` = one-to-many. See the [ER diagram](dbms-theory/03_er_model.md) and
[`schema/01_schema.sql`](schema/01_schema.sql).

## Setup (2 minutes)
You need a running **MySQL** server (8.0+) and the `mysql` client
(https://dev.mysql.com/downloads/, or `brew install mysql` / `sudo apt install mysql-server`).

```bash
# Create the database and load tables + sample data (safe to re-run for a clean slate)
mysql -u root -p < schema/01_schema.sql
mysql -u root -p < schema/02_seed.sql

# Open an interactive session
mysql -u root -p bookstore
```

Inside the `mysql>` prompt: `SHOW TABLES;`, `DESCRIBE books;`,
`SOURCE lessons/01_select_basics.sql;`, `\q` to quit. Run a whole file from the
shell with `mysql -u root -p bookstore < lessons/01_select_basics.sql`.

> Examples use `-u root -p` for simplicity. In real projects, create a dedicated
> user with only the privileges it needs.

## Learning path (SQL lessons)

| # | Lesson | You'll learn |
|---|--------|--------------|
| 01 | [SELECT basics](lessons/01_select_basics.sql) | columns, aliases, `DISTINCT`, calculated columns |
| 02 | [Filtering with WHERE](lessons/02_filtering_where.sql) | `=`, `AND`/`OR`, `BETWEEN`, `IN`, `LIKE`, `IS NULL` |
| 03 | [Sorting & limiting](lessons/03_sorting_limiting.sql) | `ORDER BY`, `LIMIT`, `OFFSET` |
| 04 | [Aggregates & GROUP BY](lessons/04_aggregates_group_by.sql) | `COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING` |
| 05 | [Joining tables](lessons/05_joins.sql) | `INNER`/`LEFT JOIN`, three-table joins |
| 06 | [Subqueries](lessons/06_subqueries.sql) | scalar subqueries, `IN (SELECT …)`, `EXISTS` |
| 07 | [Changing data](lessons/07_modifying_data.sql) | `INSERT`, `UPDATE`, `DELETE` (safely) |
| 08 | [Views & indexes](lessons/08_views_indexes.sql) | `CREATE VIEW`, `CREATE INDEX`, and why they help |

Then test yourself with the [exercises](exercises/exercises.sql), grind the
[LeetCode set](leetcode/README.md), and study the [DBMS theory](dbms-theory/00_index.md).

## Reset the data anytime
`schema/01_schema.sql` drops and recreates the database, so if you make a mess
(e.g., after Lesson 07), just re-run the two setup commands above.

---
Made for learning. Contributions/typos welcome. Happy querying!
