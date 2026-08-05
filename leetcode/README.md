# LeetCode SQL practice

Curated LeetCode SQL problems with runnable **MySQL** solutions — great practice
once you've worked through the [lessons](../README.md).

Each file is **self-contained**: it creates the problem's tables, inserts a small
sample, restates the task in plain English (with a link to the official problem),
and gives a worked solution with a short note on the approach. Problem wording is
paraphrased — open the link for the official statement and to submit your own answer.

Run one like any other SQL file:

```bash
mysql -u root -p < leetcode/easy/0175_combine_two_tables.sql
```

Each file uses its own scratch database (`DROP DATABASE IF EXISTS lc; CREATE DATABASE lc;`),
so running one never touches your `bookstore` data.

## Problems

### Easy
| # | Problem | Technique |
|---|---------|-----------|
| 175 | [Combine Two Tables](easy/0175_combine_two_tables.sql) | `LEFT JOIN` |
| 181 | [Employees Earning More Than Their Managers](easy/0181_employees_earning_more_than_managers.sql) | self-join |
| 182 | [Duplicate Emails](easy/0182_duplicate_emails.sql) | `GROUP BY` + `HAVING` |
| 183 | [Customers Who Never Order](easy/0183_customers_who_never_order.sql) | anti-join / `NOT IN` |
| 596 | [Classes With At Least 5 Students](easy/0596_classes_more_than_5_students.sql) | `GROUP BY` + `HAVING` |

### Medium
| # | Problem | Technique |
|---|---------|-----------|
| 176 | [Second Highest Salary](medium/0176_second_highest_salary.sql) | subquery / `LIMIT OFFSET` |
| 177 | [Nth Highest Salary](medium/0177_nth_highest_salary.sql) | stored function / `OFFSET` |
| 178 | [Rank Scores](medium/0178_rank_scores.sql) | `DENSE_RANK()` window |
| 180 | [Consecutive Numbers](medium/0180_consecutive_numbers.sql) | `LAG()` window |
| 184 | [Department Highest Salary](medium/0184_department_highest_salary.sql) | window / correlated subquery |
| 197 | [Rising Temperature](medium/0197_rising_temperature.sql) | self-join on dates |

### Hard
| # | Problem | Technique |
|---|---------|-----------|
| 185 | [Department Top Three Salaries](hard/0185_department_top_three_salaries.sql) | `DENSE_RANK()` per group |
| 601 | [Human Traffic of Stadium](hard/0601_human_traffic_of_stadium.sql) | window + consecutive runs |
| 262 | [Trips and Users](hard/0262_trips_and_users.sql) | filtered aggregation over joins |

## How to practice
1. Read the task and the table setup at the top of the file.
2. **Write your own query before scrolling to the solution.**
3. Run the file to see the expected output, then compare.
4. Submit your version on LeetCode to check it against all their test cases.
