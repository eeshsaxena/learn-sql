# Top SQL query questions (with solutions)

The query patterns that show up again and again. All in MySQL, using a generic
`Employee(id, name, salary, departmentId, managerId)` unless stated. Practice by
writing your own answer before reading.

### 1. Nth highest salary
```sql
SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET 1;  -- 2nd
```

### 2. Find and remove duplicate rows (by email)
```sql
-- find:
SELECT email, COUNT(*) FROM Employee GROUP BY email HAVING COUNT(*) > 1;
-- delete duplicates, keeping the smallest id:
DELETE e1 FROM Employee e1
JOIN Employee e2 ON e1.email = e2.email AND e1.id > e2.id;
```

### 3. Second highest without LIMIT (subquery form)
```sql
SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);
```

### 4. Employees earning more than their manager (self-join)
```sql
SELECT e.name FROM Employee e JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;
```

### 5. Department-wise highest salary (window function)
```sql
SELECT * FROM (
  SELECT name, salary, departmentId,
         DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) rk
  FROM Employee
) t WHERE rk = 1;
```

### 6. Running / cumulative total
```sql
SELECT name, salary,
       SUM(salary) OVER (ORDER BY id) AS running_total
FROM Employee;
```

### 7. Count and % per group
```sql
SELECT departmentId, COUNT(*) AS cnt,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM Employee), 2) AS pct
FROM Employee GROUP BY departmentId;
```

### 8. Rows with the max value per group (without window functions)
```sql
SELECT e.* FROM Employee e
JOIN (SELECT departmentId, MAX(salary) ms FROM Employee GROUP BY departmentId) m
  ON e.departmentId = m.departmentId AND e.salary = m.ms;
```

### 9. Pivot-ish: count by category in one row (conditional aggregation)
```sql
SELECT
  SUM(salary > 50000) AS high_earners,     -- boolean -> 1/0 in MySQL
  SUM(salary <= 50000) AS others
FROM Employee;
```

### 10. Employees with no department (LEFT JOIN + IS NULL / NOT IN)
```sql
SELECT e.name FROM Employee e
LEFT JOIN Department d ON e.departmentId = d.id
WHERE d.id IS NULL;
```

### 11. Third-highest distinct salary per department (window + filter)
```sql
SELECT * FROM (
  SELECT *, DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) rk
  FROM Employee
) t WHERE rk = 3;
```

### 12. Swap two column values (e.g., gender 'm' <-> 'f') without a temp
```sql
UPDATE Salary SET sex = CASE sex WHEN 'm' THEN 'f' ELSE 'm' END;
```

### Concept checks interviewers slip in
- **`COUNT(*)` vs `COUNT(col)`** — `*` counts rows; `col` skips NULLs.
- **Why can't I use a SELECT alias in WHERE?** WHERE runs before SELECT; use it in
  ORDER BY (or wrap in a subquery).
- **`UNION` vs `UNION ALL`** — UNION removes duplicates (slower); UNION ALL keeps them.
- **`IN` vs `EXISTS`** — EXISTS often faster for large correlated subqueries and
  handles NULLs more safely than `NOT IN`.
- **`RANK` vs `DENSE_RANK` vs `ROW_NUMBER`** — gap-with-ties / no-gap-with-ties /
  unique sequential.
