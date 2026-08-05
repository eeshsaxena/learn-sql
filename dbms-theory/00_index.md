# DBMS Theory — from scratch (placement prep)

Complete, from-the-basics DBMS notes for interviews and college placements. Read
top to bottom, or jump to a topic. Every file is self-contained with definitions,
examples, and the points interviewers actually ask about.

## Contents

1. [Introduction to DBMS](01_introduction.md) — what/why, DBMS vs file system, RDBMS, users
2. [Architecture & Data Models](02_architecture_and_data_models.md) — 3-level schema, data abstraction, data independence, data models
3. [ER Model & Diagrams](03_er_model.md) — entities, attributes, relationships, cardinality, ER → tables (with diagrams)
4. [Relational Model & Keys](04_relational_model_and_keys.md) — relations, tuples, all the key types, integrity constraints
5. [Relational Algebra](05_relational_algebra.md) — the operators SQL is built on
6. [Normalization](06_normalization.md) — functional dependencies, anomalies, 1NF → BCNF → 4NF
7. [SQL Overview](07_sql_overview.md) — DDL/DML/DCL/TCL, joins, subqueries, aggregates (theory side)
8. [Transactions & ACID](08_transactions_and_acid.md) — transaction states, ACID, schedules, serializability
9. [Concurrency Control](09_concurrency_control.md) — locks, 2PL, deadlocks, isolation levels
10. [Indexing & Storage](10_indexing_and_storage.md) — indexes, B/B+ trees, hashing, file organization
11. [One-page Cheat Sheet](11_cheatsheet.md) — rapid revision before an interview

## How this fits the rest of the repo
- Practice the **queries** these concepts describe in [`../lessons/`](../lessons/).
- Grind [`../leetcode/`](../leetcode/) for query problems.
- Rehearse Q&A in [`../interview/`](../interview/).
- See [`../resources.md`](../resources.md) for recommended videos/books (CodeWithHarry,
  Striver / takeUforward, Love Babbar, GeeksforGeeks, and the standard textbooks).

> These are original notes covering the standard DBMS syllabus. Use the linked
> resources for video explanations and extra practice.
