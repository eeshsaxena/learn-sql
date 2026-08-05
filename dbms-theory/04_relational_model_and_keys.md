# 4. Relational Model & Keys

## The relational model in one picture
Data is stored as **relations** (tables). Each relation has:
- a **schema** — name + attributes with domains, e.g. `BOOK(book_id, title, price)`
- **tuples** (rows), each a set of attribute values
- **domain** — the allowed set of values for an attribute (e.g., price ≥ 0)
- **degree** — number of attributes; **cardinality** — number of tuples

Properties: rows are unordered, columns are unordered (referenced by name), every
value is atomic (1NF), and no two rows are identical.

## Keys (the most-asked DBMS topic — know all of these)

Consider `STUDENT(roll_no, email, phone, name, dept)` where `roll_no`, `email`,
and `phone` are each unique.

- **Super key** — *any* set of attributes that uniquely identifies a row. May
  have extra attributes. `{roll_no}`, `{roll_no, name}`, `{email, phone}` are all
  super keys. (Every candidate key is a super key.)
- **Candidate key** — a **minimal** super key (remove any attribute and it's no
  longer unique). Here: `{roll_no}`, `{email}`, `{phone}`.
- **Primary key** — the *one* candidate key chosen to identify rows. Cannot be
  NULL, must be unique. Say we pick `roll_no`.
- **Alternate key** — candidate keys NOT chosen as primary (`email`, `phone`).
- **Composite key** — a key made of **two or more** attributes (e.g.,
  `order_item(order_id, book_id)`).
- **Foreign key** — an attribute that references the primary key of another (or
  the same) table, enforcing **referential integrity**. `books.author_id` →
  `authors.author_id`.
- **Unique key** — enforces uniqueness like a PK, but **can be NULL** (usually one
  NULL allowed) and there can be many per table.
- **Surrogate key** — an artificial key with no business meaning (an
  auto-increment id) used as the PK for stability.

> Relationship (memorize): **Primary ⊆ Candidate ⊆ Super key.**

## Integrity constraints
- **Domain constraint** — a value must belong to its attribute's domain/type.
- **Entity integrity** — no part of a **primary key** can be NULL.
- **Referential integrity** — a **foreign key** value must either match an
  existing primary key in the referenced table, or be NULL.
- **Key constraint** — candidate-key values must be unique.

### Foreign keys and referential actions
When a referenced row is deleted/updated, `ON DELETE` / `ON UPDATE` decides what
happens to the children:
- `RESTRICT` / `NO ACTION` — block it if children exist (MySQL default).
- `CASCADE` — delete/update the children too.
- `SET NULL` — set the child FK to NULL.
- `SET DEFAULT` — set the child FK to its default.

## Column constraints you'll declare in SQL
`NOT NULL`, `UNIQUE`, `PRIMARY KEY`, `FOREIGN KEY ... REFERENCES`, `CHECK
(condition)`, `DEFAULT value`, `AUTO_INCREMENT`.

### Interview one-liners
- "A candidate key is a **minimal** super key; the primary key is the chosen
  candidate key."
- "Primary key: unique + NOT NULL, one per table. Unique key: unique but allows a
  NULL, many per table."
- "Foreign key enforces referential integrity between two tables."
