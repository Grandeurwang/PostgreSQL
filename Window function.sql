#####
Note: You can’t use window functions and standard aggregations in the same query.
More specifically, you can’t include window functions in a GROUP BY clause.

# Intro to Window Function: https://blog.sqlauthority.com/2015/11/04/sql-server-what-is-the-over-clause-notes-from-the-field-101/
# Difference of ROW_NUMBER, RANK and DENSE_RANK: https://blog.jooq.org/2014/08/12/the-difference-between-row_number-rank-and-dense_rank/
# Window functions Documentation:https://www.postgresql.org/docs/8.4/functions-window.html
# Aggregates in Window Functions with and without ORDER BY:
  The ORDER BY clause is one of two clauses integral to window functions.
  The ORDER and PARTITION define what is referred to as the “window”—
  the ordered subset of data over which calculations are made.
  Removing ORDER BY just leaves an unordered partition;
  in our query's case, each column's value is simply an aggregation (e.g., sum, count, average, minimum, or maximum) of all the standard_qty values in its respective account_id

#Functions included in this chapter: OVER,PARTITION BY, ROW_NUMBER, RANK,DENSE_RANK,LAG,LEAD,NTILE

#QUIZ

#3.
SELECT standard_amt_usd,
SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders

#5.
SELECT standard_amt_usd,
DATE_TRUNC('year',occurred_at) years,
SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year',occurred_at) ORDER BY occurred_at) AS running_total
FROM orders

#8.
SELECT id,account_id,total, RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders

#11.
SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS max_std_qty
FROM orders

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ) AS max_std_qty
FROM orders

#17.
SELECT occurred_at,total_amt_usd,
LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead,
total_amt_usd-LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead_difference
FROM (
SELECT occurred_at,total_amt_usd
FROM orders
ORDER BY occurred_at) sub

#20.
SELECT account_id,occurred_at,standard_qty,
SUM(standard_qty) OVER (PARTITION BY account_id) sum_qty,
NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) standard_quartile
FROM orders

SELECT account_id,occurred_at,gloss_qty,
SUM(gloss_qty) OVER (PARTITION BY account_id) gloss_qty,
NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) gloss_half
FROM orders

SELECT account_id,occurred_at,total_amt_usd,
SUM(total_amt_usd) OVER (PARTITION BY account_id) account_usd_amt,
NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) total_percentile
FROM orders
