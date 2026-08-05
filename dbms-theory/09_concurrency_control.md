# 9. Concurrency Control

Concurrency control lets many transactions run at once **without breaking
isolation**. It's how the DBMS delivers the "I" in ACID.

## Lock-based protocols
A **lock** reserves a data item for a transaction.
- **Shared lock (S)** — for reading; many txns can hold S on the same item.
- **Exclusive lock (X)** — for writing; only one txn, and no S locks at the same time.

Compatibility: S with S = OK; S with X = conflict; X with X = conflict.

### Two-Phase Locking (2PL) — the key protocol
Each transaction has two phases:
1. **Growing phase** — it may acquire locks, but not release any.
2. **Shrinking phase** — it may release locks, but not acquire any.

2PL **guarantees conflict serializability**. Variants:
- **Strict 2PL** — hold all **exclusive** locks until commit/abort → avoids
  cascading rollbacks.
- **Rigorous 2PL** — hold **all** locks until commit/abort.
- Basic 2PL can still cause **deadlocks**.

## Deadlock
Two+ transactions each wait for a lock the other holds → nobody proceeds.
Four Coffman conditions (all needed): **mutual exclusion, hold-and-wait, no
preemption, circular wait**.

Handling:
- **Prevention** — design so a condition can't hold (e.g., acquire all locks at
  once; order resources).
- **Avoidance** — timestamp schemes that never enter unsafe states:
  - **Wait-Die** (non-preemptive): older waits, younger dies (restarts).
  - **Wound-Wait** (preemptive): older wounds (aborts) younger, younger waits.
- **Detection & recovery** — build a **wait-for graph**; a cycle = deadlock; abort
  a victim to break it.

## Timestamp-based protocol
Give each transaction a unique timestamp; order conflicting operations by
timestamp so the schedule is equivalent to that timestamp order (no locks, no
deadlock, but more restarts). Uses read-TS and write-TS per data item.

## MVCC (Multi-Version Concurrency Control)
Keep **multiple versions** of a row. Readers see a consistent snapshot without
blocking writers, and writers don't block readers. Used by PostgreSQL and MySQL's
InnoDB. Great for read-heavy workloads.

## Isolation levels (SQL standard) — trade correctness for speed
From weakest to strongest; each prevents more anomalies:

| Level | Dirty read | Non-repeatable read | Phantom read |
|---|---|---|---|
| **Read Uncommitted** | possible | possible | possible |
| **Read Committed** | prevented | possible | possible |
| **Repeatable Read** | prevented | prevented | possible* |
| **Serializable** | prevented | prevented | prevented |

\* MySQL InnoDB's Repeatable Read (its default) also blocks most phantoms via
next-key locking. Set with `SET TRANSACTION ISOLATION LEVEL ...`.

### Interview one-liners
- "2PL (growing then shrinking) guarantees conflict serializability; strict 2PL
  also avoids cascading rollbacks."
- "Deadlock needs all four Coffman conditions; detect with a wait-for graph."
- "Isolation levels: Read Uncommitted < Read Committed < Repeatable Read <
  Serializable."
- "MVCC = readers and writers don't block each other (Postgres, InnoDB)."
