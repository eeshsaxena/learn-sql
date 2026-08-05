# 7. SQL Overview (theory side)

SQL (Structured Query Language) is the standard **declarative** language for
relational databases — you say *what* you want, the engine figures out *how*.
For hands-on practice, work through [`../lessons/`](../lessons/); this file is the
conceptual map interviewers quiz on.

## The sub-languages
| Group | Purpose | Commands |
|---|---|---|
| **DDL** — Data Definition | define/modify structure | `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME` |
| **DML** — Data Manipulation | read/change data | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
| **DCL** — Data Control | permissions | `GRANT`, `REVOKE` |
| **TCL** — Transaction Control | group changes | `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

*(SELECT is sometimes called DQL — Data Query Language.)*

### DELETE vs TRUNCATE vs DROP (classic question)
| | DELETE | TRUNCATE | DROP |
|---|---|---|---|
| Type | DML | DDL | DDL |
| Removes | chosen rows (has `WHERE`) | all rows | the whole table |
| `WHERE`? | yes | no | no |
| Rollback? | yes (in a transaction) | no (auto-commit) | no |
| Resets auto-increment? | no | yes | n/a |
| Speed | slow (row by row, logged) | fast | fast |

## Constraints
`NOT NULL`, `UNIQUE`, `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `DEFAULT`.

## Order of evaluation of a SELECT (very important)
SQL is written `SELECT … FROM … WHERE …` but runs in a different logical order:

```
FROM / JOIN   → WHERE   → GROUP BY   → HAVING   → SELECT   → DISTINCT   → ORDER BY   → LIMIT
```

Consequences interviewers test:
- You **can't** use a `SELECT` alias in `WHERE` (WHERE runs before SELECT), but you
  **can** in `ORDER BY`.
- `WHERE` filters **rows**; `HAVING` filters **groups** (and can use aggregates).

## Joins (see also files 05 & the lessons)
`INNER`, `LEFT`, `RIGHT`, `FULL OUTER` (MySQL emulates FULL via `UNION`), `CROSS`,
and `SELF` join (a table joined to itself, e.g., employee→manager).

## Aggregates & grouping
`COUNT`, `SUM`, `AVG`, `MIN`, `MAX` collapse rows; `GROUP BY` applies them per
group; `HAVING` filters groups. `COUNT(*)` counts rows; `COUNT(col)` skips NULLs.

## Subqueries
- **Scalar** (returns one value), **row**, **table**, and **correlated** (the
  inner query references the outer row — runs per outer row).
- `IN`, `EXISTS`, `ANY`, `ALL` connect a subquery to the outer query.

## Views
A **view** is a stored named query (a virtual table). Benefits: simplify complex
queries, reuse, and security (expose only some columns). It stores no data itself.

## Window functions
Compute across a set of rows **without collapsing** them: `ROW_NUMBER()`,
`RANK()`, `DENSE_RANK()`, `LAG()`, `LEAD()`, running `SUM() OVER (...)`. Key for
"top-N per group" and "compare to previous row" problems (see the LeetCode set).

## NULL logic (gotcha)
NULL means "unknown". `NULL = NULL` is **not** true — use `IS NULL`. Aggregates
skip NULLs (except `COUNT(*)`). `x <> 5` does **not** return rows where x is NULL.

## Char vs Varchar
`CHAR(n)` is fixed length (padded); `VARCHAR(n)` is variable length (stores only
what's used + length). Use VARCHAR unless values are truly fixed-width.

### Interview one-liners
- "Execution order: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT."
- "TRUNCATE is DDL, no WHERE, can't rollback, resets auto-increment; DELETE is DML."
- "WHERE filters rows before grouping; HAVING filters groups after."
