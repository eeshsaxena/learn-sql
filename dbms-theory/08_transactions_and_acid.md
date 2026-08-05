# 8. Transactions & ACID

A **transaction** is a single logical unit of work — a sequence of operations that
must **all succeed or all fail** together. The classic example: transferring ₹100
from account A to B is *two* updates (debit A, credit B) that must happen as one.

```sql
START TRANSACTION;
    UPDATE account SET balance = balance - 100 WHERE id = 'A';
    UPDATE account SET balance = balance + 100 WHERE id = 'B';
COMMIT;    -- make it permanent; or ROLLBACK; to undo everything
```

## ACID properties (must-know, every interview)
- **A — Atomicity** — all-or-nothing. If any step fails, the whole transaction is
  rolled back. (Ensured by the recovery manager / undo log.)
- **C — Consistency** — a transaction takes the DB from one valid state to another,
  respecting all constraints. (App logic + constraints.)
- **I — Isolation** — concurrent transactions don't interfere; the result is as if
  they ran one after another. (Ensured by concurrency control — file 09.)
- **D — Durability** — once committed, changes survive crashes/power loss.
  (Ensured by write-ahead logging, checkpoints, flush to disk.)

## Transaction states
```
        ┌────────┐   read/write    ┌────────────────┐
        │ Active │ ──────────────▶ │ Partially       │
        └────────┘                 │ Committed       │
             │                     └───────┬────────┘
        failure                        commit ok
             ▼                             ▼
        ┌────────┐   rollback done   ┌───────────┐
        │ Failed │ ───────────────▶ │ Aborted    │
        └────────┘                  └───────────┘
                                        Committed ✔ (changes durable)
```
- **Active** — executing.
- **Partially committed** — last statement done, changes still in memory.
- **Committed** — changes written durably.
- **Failed** — something went wrong.
- **Aborted** — rolled back to the state before it started (may restart).

## TCL commands
- `COMMIT` — save all changes permanently.
- `ROLLBACK` — undo changes since the transaction (or a savepoint) began.
- `SAVEPOINT name` — a marker you can partially roll back to.

## Schedules (ordering of concurrent operations)
- **Serial schedule** — transactions run one fully after another. Always correct,
  but no concurrency.
- **Concurrent schedule** — operations interleave (for performance) — needs
  control to stay correct.
- **Serializable schedule** — a concurrent schedule whose result equals *some*
  serial schedule → the correctness goal.
  - **Conflict serializable** — can be turned into a serial schedule by swapping
    non-conflicting adjacent operations. Tested with a **precedence
    (serializability) graph**: if it has **no cycle**, the schedule is conflict
    serializable.
  - **View serializable** — a weaker, more general notion based on read/write
    "views".
- **Recoverable schedule** — a transaction commits only after all transactions
  whose data it read have committed (so you never have to undo a committed txn).
- **Cascadeless** — no dirty reads of uncommitted data → avoids cascading rollbacks.

## Concurrency problems (why isolation matters)
- **Dirty read** — read data another txn wrote but hasn't committed (it may roll back).
- **Non-repeatable read** — read the same row twice, get different values (another
  txn updated it in between).
- **Phantom read** — re-run a range query and new rows appear (another txn inserted).
- **Lost update** — two txns overwrite each other's change.

Isolation **levels** trade correctness for speed against these — see file 09.

### Interview one-liners
- "ACID = Atomicity, Consistency, Isolation, Durability."
- "Serializable = interleaved but equivalent to some serial order — the goal."
- "Conflict serializable ⇒ precedence graph has no cycle."
