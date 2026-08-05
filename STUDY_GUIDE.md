# Study guide — SQL & DBMS from scratch (placement prep)

A start-to-finish plan using everything in this repo. No prior database knowledge
assumed. Adjust the pace to your timeline — a focused **2 weeks** covers it; a
relaxed **4 weeks** cements it.

## How to use this repo
- **Theory** → [`dbms-theory/`](dbms-theory/00_index.md) (concepts interviewers ask)
- **Hands-on SQL** → [`lessons/`](lessons/) + [`exercises/`](exercises/) (run real queries)
- **Problem solving** → [`leetcode/`](leetcode/README.md)
- **Scenario/word problems** → [`practice/word_problems.md`](practice/word_problems.md)
- **Interview Q&A** → [`interview/`](interview/infosys.md)
- **Revision** → [`dbms-theory/11_cheatsheet.md`](dbms-theory/11_cheatsheet.md)

> **Golden rule:** never just read SQL — **run it**. Set up the bookstore DB once
> (see the main [README](README.md)) and type every query yourself.

---

## Phase 0 — Setup (Day 0, ~30 min)
1. Install MySQL + the `mysql` client.
2. Build the practice DB:
   ```bash
   mysql -u root -p < schema/01_schema.sql
   mysql -u root -p < schema/02_seed.sql
   ```
3. Skim the main README and this guide.

## Phase 1 — SQL fundamentals (Days 1–4)
Goal: comfortably read and write everyday queries.
- Day 1: Lessons 01–02 (SELECT, WHERE). Do the "Try it yourself" prompts.
- Day 2: Lessons 03–04 (ORDER BY/LIMIT, aggregates & GROUP BY).
- Day 3: Lesson 05 (JOINs) — the big one. Redo it until joins feel natural.
- Day 4: Lessons 06–08 (subqueries, INSERT/UPDATE/DELETE, views/indexes).
- ✅ Checkpoint: finish all 12 [exercises](exercises/exercises.sql) without peeking.

## Phase 2 — DBMS theory (Days 5–9)
Goal: explain every core concept in 2–3 sentences.
- Day 5: Theory 01–02 (intro, architecture, data models, data independence).
- Day 6: Theory 03–04 (ER model + diagrams, relational model, **all key types**).
  Do word problems **A** and **B**.
- Day 7: Theory 06 (**normalization**) — the most-asked topic. Do word problems **C**.
- Day 8: Theory 08–09 (transactions, ACID, concurrency, isolation levels).
- Day 9: Theory 05, 07, 10 (relational algebra, SQL theory, indexing/B+ trees).

## Phase 3 — Problem solving (Days 10–12)
Goal: turn "read" into "can solve under pressure".
- Day 10: LeetCode **easy** (175, 181, 182, 183, 596).
- Day 11: LeetCode **medium** (176, 177, 178, 180, 184, 197) — learn window functions.
- Day 12: LeetCode **hard** (185, 601, 262). Re-solve any you struggled with.
- Submit each on LeetCode to pass all hidden test cases.

## Phase 4 — Interview drill (Days 13–14)
- Day 13: [`interview/common_dbms_questions.md`](interview/common_dbms_questions.md)
  + [`common_sql_questions.md`](interview/common_sql_questions.md). Say answers out loud.
- Day 14: [`interview/infosys.md`](interview/infosys.md) + re-do word problems **D**.
  Skim the [cheat sheet](dbms-theory/11_cheatsheet.md).

## The five-step scenario drill (do this repeatedly)
Pick any real system (library, railway booking, food delivery, banking) and:
1. Draw the **ER diagram**.
2. Map it to **tables** with keys.
3. Identify **candidate/primary/foreign keys**.
4. **Normalize** to 3NF.
5. Write **3 useful queries**.
This single exercise rehearses ~70% of what DBMS interviews test.

## The 20 topics you must not skip
Keys · normalization (1NF→BCNF) · ER→table mapping · joins · GROUP BY/HAVING ·
subqueries vs joins · window functions · WHERE vs HAVING · DELETE/TRUNCATE/DROP ·
ACID · transaction states · serializability · 2PL · deadlock · isolation levels ·
indexing & B+ trees · clustered vs non-clustered · SQL execution order · NULL
handling · SQL vs NoSQL.

## Habits that pay off
- Explain the **why**, not just syntax.
- For query questions, **state the approach first** ("this is a self-join…").
- Keep the [cheat sheet](dbms-theory/11_cheatsheet.md) open the day before an interview.
- Revisit weak spots — spaced repetition beats one long cram.

Good luck. Build the DB, run every query, and you'll walk in confident.
