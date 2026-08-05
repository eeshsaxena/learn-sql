# 1. Introduction to DBMS

## What is data, a database, and a DBMS?
- **Data** — raw facts (e.g., `"Aisha"`, `19`, `"Bengaluru"`).
- **Information** — data processed into something meaningful.
- **Database** — an organized, related collection of data stored electronically.
- **DBMS (Database Management System)** — software to **define, store, retrieve,
  update, and manage** databases (e.g., MySQL, PostgreSQL, Oracle, SQL Server).

## DBMS vs. File System (very common interview question)
Storing data in plain files (`.txt`, `.csv`) has serious problems that a DBMS solves:

| Problem with file systems | How a DBMS fixes it |
|---|---|
| **Data redundancy** — same data copied in many files | Centralized storage, normalization |
| **Inconsistency** — copies get out of sync | One source of truth + constraints |
| **Hard to query** | Declarative query language (SQL) |
| **No concurrency control** — two users corrupt each other's writes | Transactions + locking |
| **Weak security** | Users, roles, privileges (GRANT/REVOKE) |
| **No integrity rules** | Constraints (PK, FK, CHECK, UNIQUE) |
| **No backup/recovery** | Logging, checkpoints, recovery after crash |
| **Data-program dependence** | Data independence (see file 02) |

## RDBMS
A **Relational DBMS** stores data as **tables** (relations) of rows and columns,
and supports relationships between tables via keys. It follows the relational
model (Codd's rules). MySQL, PostgreSQL, Oracle, SQL Server are RDBMSs.

- **Table / Relation** — a named 2D grid of data.
- **Row / Tuple / Record** — one entry.
- **Column / Attribute / Field** — one property.
- **Degree** — number of columns. **Cardinality** — number of rows.

## Advantages of a DBMS
Reduced redundancy, consistency, sharing, security, integrity, backup & recovery,
and enforcement of standards.

## Disadvantages
Cost (software/hardware/training), complexity, and it can be overkill for tiny apps.

## Types of users
- **DBA (Database Administrator)** — designs, secures, tunes, backs up the DB.
- **Application programmer / Backend dev** — writes programs that use the DB.
- **End user** — naive (uses an app) or sophisticated (writes queries directly).

## The three-schema idea (preview)
A DBMS separates *how data looks to users* from *how it's actually stored*. That
separation (data abstraction and data independence) is covered next in
[Architecture & Data Models](02_architecture_and_data_models.md).

### Interview one-liners
- "DBMS is software to manage databases; RDBMS stores data as related tables."
- "The killer features file systems lack: **redundancy control, consistency,
  concurrency, integrity, security, recovery**."
