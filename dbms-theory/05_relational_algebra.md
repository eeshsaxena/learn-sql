# 5. Relational Algebra

Relational algebra is the **theoretical, procedural** query language behind SQL.
Each operator takes one or two relations and returns a relation (so operators
chain). Knowing it helps you reason about what SQL is really doing.

## Basic (fundamental) operators

| Op | Symbol | Meaning | SQL analogue |
|---|---|---|---|
| Select | σ (sigma) | pick **rows** matching a condition | `WHERE` |
| Project | π (pi) | pick **columns** (and dedupe) | `SELECT DISTINCT cols` |
| Union | ∪ | rows in A **or** B (same schema) | `UNION` |
| Set difference | − | rows in A but **not** B | `EXCEPT` / `NOT IN` |
| Cartesian product | × | every row of A paired with every row of B | `CROSS JOIN` |
| Rename | ρ (rho) | rename a relation/attributes | `AS` |

Examples (on our bookstore):
- σ<sub>price &lt; 13</sub>(BOOK) → books cheaper than 13.
- π<sub>title, price</sub>(BOOK) → just those two columns.
- π<sub>title</sub>(σ<sub>genre = 'Fantasy'</sub>(BOOK)) → titles of fantasy books.

## Derived operators (built from the basics, but everyday)

| Op | Symbol | Meaning |
|---|---|---|
| Intersection | ∩ | rows in **both** A and B (= A − (A − B)) |
| Natural join | ⋈ | combine rows matching on common attributes, no duplicate columns |
| Theta / equi join | ⋈<sub>θ</sub> | join on an explicit condition θ |
| Division | ÷ | "for all" queries (students who took **all** courses) |

- **Natural join** BOOK ⋈ AUTHOR joins on `author_id` (the shared attribute) and
  keeps one copy of it.
- **Division** answers "find X related to *every* Y" — e.g., customers who bought
  every book by an author.

## Joins recap (theory)
- **Inner join** — only matching rows (equi/natural/theta are inner joins).
- **Outer joins** keep unmatched rows, filling gaps with NULL:
  - **Left outer** — all left rows + matches.
  - **Right outer** — all right rows + matches.
  - **Full outer** — all rows from both sides.

## Relational calculus (contrast)
- **Relational algebra** — *procedural*: you specify **how** (the sequence of ops).
- **Relational calculus** — *declarative*: you specify **what** you want (a logic
  formula), not the steps. Two flavors: **tuple** (TRC) and **domain** (DRC)
  calculus. SQL is closer to calculus in spirit but is based on both.

### Interview one-liners
- "σ = rows (WHERE), π = columns (SELECT). Both are fundamental."
- "Algebra is procedural (how); calculus is declarative (what)."
- "Division expresses 'for all' queries."
