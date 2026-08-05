# 11. DBMS Cheat Sheet (last-minute revision)

Skim this the night before / morning of an interview.

## Keys
- **Super key** ⊇ **Candidate key** (minimal) → one chosen as **Primary key**
  (unique + NOT NULL). Others = **alternate keys**.
- **Foreign key** → referential integrity. **Composite key** = ≥2 columns.
- **Unique key**: unique but allows a NULL; many per table. PK: no NULL, one per table.

## Normalization ladder
- **1NF**: atomic columns.
- **2NF**: 1NF + no **partial** dependency.
- **3NF**: 2NF + no **transitive** dependency.
- **BCNF**: every determinant (LHS of an FD) is a **super key**.
- **4NF**: BCNF + no multivalued dependency.
- Goal: remove **insert / update / delete anomalies**.

## ER → tables
- 1:N → FK on the **many** side. M:N → **junction table**.
- Weak entity → owner PK + partial key. Multivalued attr → own table.

## Three-schema architecture
External (views) / Conceptual (logical) / Internal (physical) →
**physical** independence (easy) & **logical** independence (hard).

## SQL execution order
`FROM → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY → LIMIT`
(so no SELECT aliases in WHERE; WHERE filters rows, HAVING filters groups.)

## DELETE vs TRUNCATE vs DROP
DELETE = DML, has WHERE, rollbackable · TRUNCATE = DDL, all rows, resets
auto-increment, no rollback · DROP = removes the table itself.

## ACID
**Atomicity** (all-or-nothing) · **Consistency** (valid → valid) ·
**Isolation** (no interference) · **Durability** (survives crash).

## Concurrency
- Problems: **dirty / non-repeatable / phantom** reads, **lost update**.
- **2PL** (growing→shrinking) ⇒ conflict serializable; **strict 2PL** avoids
  cascading rollbacks.
- Deadlock = 4 Coffman conditions; detect via **wait-for graph**.
- Isolation levels: Read Uncommitted < Read Committed < Repeatable Read < Serializable.
- **MVCC** = readers/writers don't block (Postgres, InnoDB).

## Indexing
- Speeds reads, slows writes. **Clustered** (1, defines row order) vs
  **secondary** (many).
- **B+ tree** (data in linked leaves → range scans); **hashing** (O(1) equality, no ranges).
- Composite index: **leftmost-prefix** rule.

## Joins
INNER (matches only) · LEFT/RIGHT/FULL OUTER (keep unmatched + NULLs) ·
CROSS (Cartesian) · SELF (table to itself).

## NULL
`NULL = NULL` is unknown → use `IS NULL`. Aggregates skip NULL (except `COUNT(*)`).

## SQL vs NoSQL
SQL: relational, fixed schema, ACID, vertical scaling. NoSQL: document/key-value/
column/graph, flexible schema, often BASE + horizontal scaling.

## Fast facts to drop in interviews
- "Candidate key is a minimal super key."
- "M:N always needs a junction table."
- "2NF = no partial dep; 3NF = no transitive dep; BCNF = every determinant is a key."
- "TRUNCATE is DDL and can't be rolled back."
- "B+ tree beats B-tree for range queries because data lives in linked leaves."
