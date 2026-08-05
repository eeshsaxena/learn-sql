# Top DBMS interview questions (with short answers)

Rapid-fire Q&A across companies. Pair with the [theory notes](../dbms-theory/00_index.md)
for depth.

### Basics
1. **DBMS vs RDBMS?** RDBMS stores data as related tables + keys; all RDBMS are DBMS.
2. **Advantages of DBMS?** Less redundancy, consistency, sharing, security,
   integrity, backup/recovery.
3. **Schema vs instance?** Schema = design (rare change); instance = current data.
4. **Data independence?** Change one level without affecting the one above —
   physical (easy) & logical (hard).
5. **Three-schema architecture?** External / Conceptual / Internal.

### ER & relational
6. **Entity vs attribute vs relationship?** Object / property / association.
7. **Strong vs weak entity?** Weak has no key of its own; needs owner's key + partial key.
8. **Degree vs cardinality of a relation?** Degree = #columns; cardinality = #rows.
9. **How is M:N mapped to tables?** A junction table with both PKs.
10. **Types of keys?** Super, candidate, primary, alternate, composite, foreign,
    unique, surrogate.

### Normalization
11. **What is normalization?** Reducing redundancy/anomalies by decomposing tables.
12. **Functional dependency?** X → Y: same X ⇒ same Y.
13. **Partial vs transitive dependency?** Non-prime depends on part of a key
    (2NF) vs on another non-prime (3NF).
14. **BCNF vs 3NF?** BCNF is stricter — *every* determinant must be a super key.
15. **Lossless vs lossy decomposition?** Lossless = you can rejoin to get the
    original exactly (natural join returns no extra/lost rows). Aim for lossless.
16. **Dependency-preserving decomposition?** All FDs are checkable without joins;
    BCNF may not preserve dependencies, 3NF always can.

### SQL
17. **DDL/DML/DCL/TCL?** Define / manipulate / control access / transaction control.
18. **DELETE vs TRUNCATE vs DROP?** See the SQL notes — DML+WHERE vs DDL all-rows
    vs remove table.
19. **WHERE vs HAVING?** Rows vs groups.
20. **Types of joins?** INNER, LEFT, RIGHT, FULL OUTER, CROSS, SELF.
21. **Correlated subquery?** Inner query references the outer row; runs per outer row.
22. **View vs table?** View stores no data — it's a saved query.
23. **Stored procedure vs function?** Procedure: callable block, may not return a
    value, can do DML. Function: returns a value, usable inside queries.
24. **Trigger?** Auto-runs on INSERT/UPDATE/DELETE.

### Transactions & concurrency
25. **What is a transaction?** An all-or-nothing unit of work.
26. **ACID?** Atomicity, Consistency, Isolation, Durability.
27. **Concurrency problems?** Dirty read, non-repeatable read, phantom, lost update.
28. **Serializability?** A concurrent schedule equivalent to some serial one
    (conflict serializable ⇒ acyclic precedence graph).
29. **2PL?** Growing (acquire) then shrinking (release) → conflict serializable.
30. **Deadlock & handling?** Circular wait for locks; prevent/avoid (wait-die,
    wound-wait) or detect via wait-for graph.
31. **Isolation levels?** Read Uncommitted < Read Committed < Repeatable Read <
    Serializable.
32. **MVCC?** Multiple row versions so readers/writers don't block each other.

### Indexing & storage
33. **What is an index and its trade-off?** Faster reads, slower writes + space.
34. **Clustered vs non-clustered?** Physical order (1) vs separate pointer
    structure (many).
35. **B-tree vs B+ tree?** B+ keeps data only in linked leaves → better range scans.
36. **When does an index NOT help?** Low-selectivity columns, functions on the
    column (`WHERE YEAR(d)=…`), leading `%` in LIKE, tiny tables.

### Misc
37. **SQL vs NoSQL?** Relational+ACID vs flexible-schema+horizontal scale (BASE).
38. **OLTP vs OLAP?** Transactional (many small writes) vs analytical (big reads,
    warehouse).
39. **Primary vs foreign key?** Identifies rows vs references another table's PK.
40. **What is a deadlock victim?** The transaction the DBMS aborts to break a
    detected deadlock cycle.
