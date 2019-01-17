####Expert Tip
Note that you should not include an alias when you write a subquery in a conditional statement.
This is because the subquery is treated as an individual value (or set of values in the IN case) rather than as a table.

Also, notice the query here compared a single value.
If we returned an entire column IN would need to be used to perform a logical argument.
If we are returning an entire table, then we must use an ALIAS for the table,
and perform additional logic on the entire table.

#####QUIZ
#3.
SELECT DATE_TRUNC('day',occurred_at) AS day,channel,COUNT(channel)
FROM web_events
GROUP BY 1,2
ORDER BY 1,2

SELECT channel,AVG(count)
FROM
(SELECT DATE_TRUNC('day',occurred_at) AS day,channel,COUNT(channel)
FROM web_events
GROUP BY 1,2
ORDER BY 1,2) sub
GROUP BY 1
ORDER BY 2 DESC

#7.
SELECT DATE_TRUNC('month', MIN(occurred_at))
FROM orders;

SELECT AVG(gloss_qty) gloss_qty,AVG(poster_qty) poster_qty,AVG(standard_qty) standard_qty,SUM(total_amt_usd) total_usd
FROM orders
WHERE  DATE_TRUNC('month',occurred_at)=(SELECT DATE_TRUNC('month',MIN(occurred_at))
FROM orders)

#10.
1
SELECT subj.region_name1,subj.sales_name1,subj.total
FROM (SELECT max
      FROM (SELECT MAX(total),region_name1
            FROM(SELECT r.name region_name1,s.name sales_name1,SUM(o.total_amt_usd) total
                 FROM region r
                 JOIN sales_reps s
                 ON s.region_id=r.id
                 JOIN accounts a
                 ON a.sales_rep_id=s.id
                 JOIN orders o
                 ON o.account_id=a.id
                 GROUP BY 1,2) sub1
                 GROUP BY 2) sub2) AS sub3
JOIN (SELECT r.name region_name1,s.name sales_name1,SUM(o.total_amt_usd) total
     FROM region r
     JOIN sales_reps s
     ON s.region_id=r.id
     JOIN accounts a
     ON a.sales_rep_id=s.id
     JOIN orders o
     ON o.account_id=a.id
     GROUP BY 1,2) subj
ON subj.total = sub3.max
ORDER BY 3 DESC

2
SELECT SUM(o.total_amt_usd) total_usd,r.name region_name,SUM(o.total) total_orders
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
JOIN accounts a
ON a.sales_rep_id=s.id
JOIN orders o
ON o.account_id=a.id
GROUP BY 2
ORDER BY 1
LIMIT 1

3
SELECT a.name,SUM(total) total
FROM accounts a
JOIN orders o
ON a.id=o.account_id
GROUP BY 1
HAVING SUM(total)>(SELECT sub2.total
                  FROM (SELECT accounts.name,SUM(orders.standard_qty) qty,SUM(orders.total) total
                  FROM accounts
                  JOIN  orders
                  ON accounts.id=orders.account_id
                  GROUP BY 1
                  ORDER BY 2 DESC
                  LIMIT 1) sub2);

4
SELECT COUNT(w.channel),a.name
FROM accounts a
JOIN web_events w
ON a.id=w.account_id
WHERE  a.name=(SELECT name
FROM (SELECT SUM(o.total_amt_usd) total_usd, a.name
FROM orders o
JOIN accounts a
ON a.id=o.account_id
JOIN web_events w
ON w.account_id=a.id
GROUP BY 2
ORDER BY 1 DESC
LIMIT 1) sub1)
GROUP BY a.name

5
SELECT AVG(sum)
FROM (SELECT SUM(o.total_amt_usd),a.name
FROM accounts a
JOIN orders o
ON o.account_id=a.id
GROUP BY 2
ORDER BY 1 DESC
LIMIT 10) sub

6
SELECT SUM(total_usd)/SUM(count) average
FROM (SELECT a.name,SUM(o.total_amt_usd) total_usd,COUNT(O.total_amt_usd)
FROM accounts a
JOIN orders o
ON a.id=o.account_id
GROUP BY 1
HAVING SUM(o.total_amt_usd)>(SELECT AVG(total_amt_usd)
                             FROM orders)) sub
#14
1
WITH table1 AS (SELECT SUM(o.total_amt_usd),r.name region,s.name
                FROM orders o
                JOIN accounts a
                ON o.account_id=a.id
                JOIN sales_reps s
                ON s.id=a.sales_rep_id
                JOIN region r
                ON s.region_id=r.id
                GROUP BY 2,3),
table2 AS (SELECT MAX(sum),region
           FROM table1
           GROUP BY region)
SELECT table1.region,table1.name,table1.sum
FROM table1
JOIN table2
ON table1.sum=table2.max
ORDER BY sum DESC

2
SELECT SUM(o.total_amt_usd),r.name region,COUNT(o.*)
                FROM orders o
                JOIN accounts a
                ON o.account_id=a.id
                JOIN sales_reps s
                ON s.id=a.sales_rep_id
                JOIN region r
                ON s.region_id=r.id
                GROUP BY 2
                ORDER BY 1 DESC
                LIMIT 1
