# Infosys — SQL & DBMS interview questions

Infosys technical interviews (and the InfyTQ / HackWithInfy rounds) tend to ask
**fundamentals clearly explained** plus a few "write the query" problems. Below are
the most frequently reported ones, with concise answers. Practice saying each
answer out loud in 2–3 sentences.

## Theory (know these cold)

**1. What is DBMS / RDBMS? Difference?**
DBMS manages databases; RDBMS stores data as related **tables** with keys and
follows the relational model. Every RDBMS is a DBMS, not vice versa.

**2. DBMS vs File system?**
File systems suffer redundancy, inconsistency, no concurrency control, weak
security, and no recovery. DBMS fixes all of these. (See theory file 01.)

**3. What are the types of keys?**
Super, candidate (minimal super key), primary (chosen candidate, unique+NOT NULL),
alternate, composite, foreign, unique, surrogate. (Theory file 04.)

**4. Primary key vs Unique key?**
PK: one per table, no NULLs. Unique: many per table, allows a NULL.

**5. What is normalization? Explain 1NF/2NF/3NF/BCNF.**
Organizing tables to cut redundancy and anomalies. 1NF atomic; 2NF no partial
dep; 3NF no transitive dep; BCNF every determinant is a super key. (Theory file 06.)

**6. What is denormalization?**
Deliberately adding redundancy to speed up reads (reporting), at the cost of
harder writes.

**7. Explain ACID properties.**
Atomicity, Consistency, Isolation, Durability. (Theory file 08.)

**8. DELETE vs TRUNCATE vs DROP?**
DELETE = DML, WHERE, rollbackable. TRUNCATE = DDL, all rows, resets
auto-increment, no rollback. DROP removes the table itself.

**9. What are joins? Types?**
Combine rows across tables: INNER, LEFT, RIGHT, FULL OUTER, CROSS, SELF.

**10. WHERE vs HAVING?**
WHERE filters rows before grouping; HAVING filters groups (can use aggregates).

**11. What is an index? Pros/cons?**
A structure that speeds up reads on a column; costs space and slower writes.

**12. What is a foreign key / referential integrity?**
An FK value must match an existing PK (or be NULL); keeps tables consistent.

**13. What is a view? A stored procedure? A trigger?**
View = saved query (virtual table). Stored procedure = saved, callable block of
SQL. Trigger = SQL that runs automatically on INSERT/UPDATE/DELETE.

**14. CHAR vs VARCHAR?**
CHAR = fixed length (padded); VARCHAR = variable length. Prefer VARCHAR.

**15. SQL vs NoSQL?**
SQL: relational, fixed schema, ACID, scales vertically. NoSQL: flexible schema,
document/key-value/column/graph, scales horizontally.

## "Write a query" problems (typical)

**Q. Second highest salary from Employee(id, salary).**
```sql
SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);
-- or: SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET 1;
```

**Q. Nth highest salary.**
```sql
SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET N-1;
-- (replace N-1 with the literal offset; see leetcode/medium/0177)
```

**Q. Find duplicate emails in Person(id, email).**
```sql
SELECT email FROM Person GROUP BY email HAVING COUNT(*) > 1;
```

**Q. Employees who earn more than their manager.** — self-join (leetcode/easy/0181).

**Q. Customers who never placed an order.** — anti-join (leetcode/easy/0183).

**Q. Count employees per department.**
```sql
SELECT departmentId, COUNT(*) FROM Employee GROUP BY departmentId;
```

**Q. Fetch employees whose name starts with 'A'.**
```sql
SELECT * FROM Employee WHERE name LIKE 'A%';
```

## Tips for the Infosys round
- Explain the **why**, not just the syntax (e.g., why 3NF removes anomalies).
- For query questions, state your approach first ("this is a self-join because…").
- Know normalization with a concrete example — it's asked almost every time.
- Be ready to draw an **ER diagram** for a small scenario (see [`../practice/word_problems.md`](../practice/word_problems.md)).
