# 6. Normalization

**Normalization** organizes columns and tables to **reduce redundancy** and avoid
**update anomalies**, by decomposing big tables into smaller, well-structured
ones. This is the #1 most-asked DBMS topic — know the normal forms with examples.

## Why: the anomalies redundancy causes
Suppose one fat table stores student + their department + department head:

`STUDENT(roll, name, dept, dept_head)` — and `dept_head` repeats for every student
in that department.

- **Insertion anomaly** — can't add a new department until at least one student
  joins it (dept_head has nowhere to live).
- **Update anomaly** — if a department gets a new head, you must update *every*
  student row; miss one and the data is inconsistent.
- **Deletion anomaly** — delete the last student of a department and you lose the
  department/head info entirely.

Normalization removes these by splitting the table.

## Functional dependencies (FDs) — the foundation
`X → Y` ("X determines Y") means: any two rows with the same X must have the same
Y. Example: `roll → name` (a roll number determines exactly one name).

- **Trivial FD** — Y ⊆ X (e.g., `{roll, name} → roll`). Always holds.
- **Non-trivial FD** — Y not a subset of X.
- **Prime attribute** — an attribute that is part of *some* candidate key.
- **Non-prime attribute** — not part of any candidate key.
- **Partial dependency** — a non-prime attribute depends on **part** of a
  composite candidate key.
- **Transitive dependency** — a non-prime attribute depends on another non-prime
  attribute (X → Y → Z).

**Armstrong's axioms** (used to derive all FDs): Reflexivity, Augmentation,
Transitivity (plus derived: Union, Decomposition, Pseudotransitivity). The
**closure** X⁺ = all attributes functionally determined by X; if X⁺ = all
attributes, X is a super key.

## The normal forms

### 1NF — First Normal Form
- Every cell is **atomic** (no lists/sets/repeating groups in a column).
- Fix: split multivalued data into separate rows/tables.
- Bad: `phone = "111, 222"`. Good: one phone per row.

### 2NF — Second Normal Form
- Be in 1NF **and** have **no partial dependency** (no non-prime attribute
  depends on only *part* of a composite candidate key).
- Only relevant when the candidate key is composite.
- Example: `SCORE(student_id, course_id, marks, student_name)` with key
  `(student_id, course_id)`. `student_name` depends only on `student_id` (part of
  the key) → partial dependency. Fix: move `student_name` to a `STUDENT` table.

### 3NF — Third Normal Form
- Be in 2NF **and** have **no transitive dependency** (no non-prime attribute
  depends on another non-prime attribute).
- Formally: for every FD X → Y, either X is a super key, **or** Y is a prime
  attribute.
- Example: `STUDENT(roll, dept, dept_head)`: `roll → dept → dept_head` is
  transitive. Fix: split into `STUDENT(roll, dept)` and `DEPT(dept, dept_head)`.

### BCNF — Boyce-Codd Normal Form (a stricter 3NF)
- Be in 3NF **and** for **every** non-trivial FD X → Y, **X must be a super key**.
- Removes anomalies 3NF can still allow when there are overlapping candidate keys.
- Every BCNF table is in 3NF, but not vice versa. Decomposition to BCNF is always
  lossless but may **not** be dependency-preserving (a known trade-off).

### 4NF — Fourth Normal Form
- Be in BCNF **and** have no **multivalued dependency** (X ↠ Y): one attribute
  determining a *set* of values independently of other attributes.
- Example: `(course, instructor, textbook)` where instructors and textbooks are
  independent of each other → split into two tables.

*(5NF / Project-Join NF exists for rare join dependencies; seldom asked.)*

## Quick ladder to remember
```
1NF : atomic columns (no repeating groups)
2NF : 1NF + no partial dependency        (non-prime depends on WHOLE key)
3NF : 2NF + no transitive dependency     (non-prime depends only on a key)
BCNF: 3NF + every determinant is a super key
4NF : BCNF + no multivalued dependency
```

## Denormalization (the counterpoint)
Deliberately adding redundancy (e.g., storing a precomputed total) to speed up
reads, accepting harder writes. Used in reporting/warehouse workloads. Interviewers
like to hear you know normalization is a trade-off, not an absolute.

### Interview one-liners
- "Normalization reduces redundancy and update/insert/delete anomalies."
- "2NF removes partial deps, 3NF removes transitive deps, BCNF: every determinant
  is a super key."
- "BCNF decomposition is lossless but may not preserve dependencies."
