# 2. Architecture & Data Models

## Three-schema (three-level) architecture
ANSI-SPARC separates a database into three levels so users are shielded from
storage details. **This is a top interview favorite.**

```
        ┌──────────────────────────────┐
        │  External / View level        │  what each user group sees (views)
        ├──────────────────────────────┤
        │  Conceptual / Logical level   │  the whole schema: tables, columns,
        │                               │  relationships, constraints
        ├──────────────────────────────┤
        │  Internal / Physical level    │  how data is actually stored on disk
        └──────────────────────────────┘
```

- **External level (view)** — multiple user-specific views hide the rest of the
  DB. A payroll clerk sees salary; a receptionist doesn't.
- **Conceptual level** — the community/logical view: all entities, attributes,
  relationships, and constraints. What the DB designer works with.
- **Internal level** — physical storage: files, indexes, compression, layout.

## Data abstraction
Hiding complexity, level by level: physical (how) → logical (what) → view (a slice).

## Data independence (asked a lot)
The ability to change one level without disturbing the level above.
- **Logical data independence** — change the conceptual schema (e.g., add a
  column, split a table) without changing external views/apps. *Harder to
  achieve.*
- **Physical data independence** — change physical storage (e.g., add an index,
  change file layout) without changing the conceptual schema. *Easier.*

## Schema vs. Instance
- **Schema** — the *design/structure* of the DB (the column definitions). Changes
  rarely. Analogy: a class in OOP.
- **Instance** — the *actual data* at a moment in time. Changes constantly.
  Analogy: an object.

## Data models (how data is logically structured)
- **Hierarchical** — tree, parent→child (one-to-many). Old (IBM IMS).
- **Network** — graph, a child can have many parents. Old (CODASYL).
- **Relational** — tables + keys. **Dominant today.** (MySQL, Postgres, Oracle.)
- **Entity-Relationship (ER)** — a *design* model: entities and relationships,
  drawn as ER diagrams, then converted to relational tables. (See file 03.)
- **Object-oriented / Object-relational** — objects, inheritance.
- **Document / Key-value / Column / Graph (NoSQL)** — non-relational, for scale
  and flexible schemas (MongoDB, Redis, Cassandra, Neo4j).

## DBMS languages
- **DDL** (Data Definition) — define structure: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.
- **DML** (Data Manipulation) — work with data: `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
- **DCL** (Data Control) — permissions: `GRANT`, `REVOKE`.
- **TCL** (Transaction Control) — `COMMIT`, `ROLLBACK`, `SAVEPOINT`.

## Three-tier application architecture (don't confuse with three-schema)
Presentation (UI) → Application/Logic (server) → Database tier. This is about
*app deployment*; the three-schema architecture is about *data abstraction*.

### Interview one-liners
- "Three-schema = external/conceptual/internal; it enables data independence."
- "Physical independence (easy) vs logical independence (hard)."
- "Schema is the blueprint (rarely changes); instance is the current data."
