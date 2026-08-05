# 10. Indexing & Storage

## Why indexing?
Without an index, finding rows means a **full table scan** (read every row). An
**index** is a separate sorted/searchable structure that lets the DBMS jump
straight to matching rows — like the index at the back of a book vs. reading every
page.

- **Speeds up** `WHERE`, `JOIN`, `ORDER BY`, and `GROUP BY` on the indexed column.
- **Costs**: extra disk space, and slower `INSERT`/`UPDATE`/`DELETE` (the index
  must be maintained too). So index the columns you actually search/join on — not
  every column.

## Types of indexes
- **Primary index** — built on the ordering key of a sorted file (one per table).
- **Clustered index** — the table's rows are physically stored in index order.
  Only **one** per table (the data can be sorted one way). In InnoDB the **primary
  key is the clustered index**.
- **Non-clustered / secondary index** — a separate structure pointing at rows; you
  can have **many**. Lookups do an extra hop (index → row).
- **Dense index** — one index entry per record.
- **Sparse index** — one entry per block/page (smaller, needs ordered data).
- **Composite index** — on multiple columns `(a, b)`. Usable for filters on `a` or
  `a,b` (leftmost-prefix rule), not on `b` alone.
- **Unique index** — also enforces uniqueness (PK/UNIQUE create one automatically).

## B-tree and B+ tree (the workhorse)
Most relational indexes use a **B+ tree**: a balanced, multi-way search tree that
keeps lookups at O(log n) even for huge tables, and stays shallow (few disk reads).

- **B-tree** — keys and data pointers live in **all** nodes.
- **B+ tree** — data pointers live **only in leaf nodes**; internal nodes hold only
  keys for routing. Leaves are also **linked in order**, which makes **range
  scans** (`BETWEEN`, `ORDER BY`) fast. This is why B+ trees dominate.

## Hashing (for equality lookups)
Maps a key through a **hash function** to a bucket for O(1) average equality
lookup (`=`), but **can't** do range queries.
- **Static hashing** — fixed number of buckets (overflow chains when full).
- **Dynamic hashing** (extendible / linear) — grows/shrinks buckets as data
  changes, avoiding long overflow chains.

## File organization (how rows sit on disk)
- **Heap (unordered)** — rows appended anywhere; fast insert, slow search.
- **Sequential (ordered)** — rows kept sorted by a key; good for range scans, costly
  inserts.
- **Hashed** — bucket by hash of a key; fast equality lookup.

## Reading the query plan
`EXPLAIN <query>` shows how MySQL will execute it — whether it uses an index
(`key` column) or does a full scan (`type = ALL`). After adding an index, re-run
`EXPLAIN` to confirm it's used (see [`../lessons/08_views_indexes.sql`](../lessons/08_views_indexes.sql)).

### Interview one-liners
- "Index trades slower writes + space for much faster reads on the indexed column."
- "Clustered index defines physical row order — one per table; secondary indexes —
  many."
- "B+ tree keeps data only in linked leaves → great for range queries; hashing is
  O(1) for equality but can't do ranges."
- "Composite index (a,b) helps queries on a or (a,b), not b alone (leftmost prefix)."
