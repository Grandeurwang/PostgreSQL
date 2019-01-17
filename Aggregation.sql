### Expert Tips
1.The order of column names in your GROUP BY clause doesn’t matter
the results will be the same regardless.
If we run the same query and reverse the order in the GROUP BY clause,
you can see we get the same results.
2.As with ORDER BY, you can substitute numbers for column names in the GROUP BY clause.
It’s generally recommended to do this only when you’re grouping many columns,
or if something else is causing the text in the GROUP BY clause to be excessively long.
3.We must use aggregation after the HAVING command
4.CASE must include the following components:
WHEN, THEN, and END.
ELSE is an optional component to catch cases that didn’t meet any of the other previous CASE conditions.

#####QUIZ
#7.
SELECT SUM(poster_qty)
FROM orders

SELECT SUM(standard_qty )
FROM orders

SELECT SUM(total_amt_usd  )
FROM orders

SELECT standard_amt_usd+gloss_amt_usd  AS sum
FROM orders

SELECT SUM(standard_amt_usd)/SUM(standard_qty )  AS per_unit
FROM orders

#11.
1
SELECT MIN(occurred_at) earliest_date
FROM orders

2
SELECT occurred_at earliest_date
FROM orders
ORDER BY occurred_at
LIMIT 1

3
SELECT MAX(occurred_at) latest_date
FROM web_events

4
SELECT occurred_at latest_date
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1

5
SELECT AVG(standard_qty) sd_avg,AVG(gloss_qty) gloss_avg,AVG(poster_qty) poster_avg, AVG(standard_amt_usd) sd_usd_avg,AVG(gloss_amt_usd) gloss_usd_avg,AVG(poster_amt_usd) poster_usd_avg
FROM orders

6
SELECT AVG(total_amt_usd) median
FROM (SELECT *
      FROM (SELECT total_amt_usd
            FROM orders
            ORDER BY total_amt_usd
            LIMIT 3457) a
      ORDER BY total_amt_usd DESC
      LIMIT 2) b

#14.
1
SELECT a.name AS name,o.occurred_at o_date
FROM accounts a
JOIN orders o
ON o.account_id=a.id
ORDER BY o_date
LIMIT 1

2
SELECT SUM(o.total_amt_usd) AS usd,a.name AS company_name
FROM orders o
JOIN accounts a
ON o.account_id=a.id
GROUP BY a.name
350 rows

3
SELECT w.occurred_at AS occur_date,w.channel,a.name
FROM web_events w
JOIN accounts a
ON w.account_id=a.id
ORDER BY occur_date DESC
LIMIT 1

4
SELECT channel,COUNT(channel) used_times
FROM web_events
GROUP BY channel
6 rows

5
SELECT a.primary_poc,w.occurred_at
FROM accounts a
JOIN web_events w
ON w.account_id=a.id
ORDER BY w.occurred_at
LIMIT 1

6
SELECT a.name,MIN(o.total_amt_usd) AS total_usd
FROM accounts a
JOIN orders o
ON o.account_id=a.id
GROUP BY a.name
350 rows

7
SELECT COUNT(s.name),r.name AS region
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
GROUP BY region
4 rows

#17.
SELECT a.name,AVG(o.standard_qty) AS avg_sd, AVG(o.gloss_qty) AS avg_gloss, AVG(o.poster_qty) AS avg_poster
FROM accounts a
JOIN orders o
ON o.account_id=a.id
GROUP BY a.name
350 rows

SELECT a.name,AVG(o.standard_amt_usd) AS avg_sd,AVG(o.gloss_amt_usd) AS avg_gloss,AVG(o.poster_amt_usd) AS avg_poster
FROM accounts a
JOIN orders o
ON o.account_id=a.id
GROUP BY a.name
350 rows

SELECT s.name sales_name,w.channel,COUNT(w.channel) used_times
FROM web_events w
JOIN accounts a
ON a.id=w.account_id
JOIN sales_reps s
ON s.id=a.sales_rep_id
GROUP BY s.name,w.channel
ORDER BY used_times DESC
295 rows

SELECT r.name region, w.channel,COUNT(w.channel) used_times
FROM web_events w
JOIN accounts a
ON a.id=w.account_id
JOIN sales_reps s
ON s.id=a.sales_rep_id
JOIN region r
ON r.id=s.region_id
GROUP BY r.name,w.channel
ORDER BY used_times DESC
24 rows

#20.
1.
SELECT DISTINCT a.name account_name, r.name region_name
FROM accounts a
JOIN sales_reps s
ON s.id=a.sales_rep_id
JOIN region r
ON r.id=s.region_id
ORDER BY a.name
351 rows

SELECT DISTINCT account_name
FROM (SELECT DISTINCT a.name account_name, r.name region_name
      FROM accounts a
      JOIN sales_reps s
      ON s.id=a.sales_rep_id
      JOIN region r
      ON r.id=s.region_id
      ORDER BY a.name) a
351 rows
#No accounts associate with more than one region

2.
SELECT DISTINCT s.name sales_name,a.name account_name
      FROM accounts a
      JOIN sales_reps s
      ON s.id=a.sales_rep_id
      ORDER BY s.name
351 rows

SELECT DISTINCT sales_name
FROM (SELECT DISTINCT s.name sales_name,a.name account_name
      FROM accounts a
      JOIN sales_reps s
      ON s.id=a.sales_rep_id
      ORDER BY s.name) a
50 rows
#There are sales_reps worked on more than one account

#24.
1.
SELECT s.name , COUNT(a.name)AS account_number
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id=s.id
GROUP BY s.name
HAVING COUNT(a.name)>5
34 rows

2.
SELECT a.name,COUNT(a.name) order_number
FROM orders o
JOIN accounts a
ON a.id=o.account_id
GROUP BY a.name
HAVING COUNT(a.name)>20
120 rows

3.
SELECT a.name,COUNT(a.name) order_number
FROM orders o
JOIN accounts a
ON a.id=o.account_id
GROUP BY a.name
ORDER BY order_number DESC
LIMIT 1

4.
SELECT a.name,SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON o.account_id=a.id
GROUP BY a.name
HAVING SUM(o.total_amt_usd)>30000
204 rows

5.
SELECT a.name,SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON o.account_id=a.id
GROUP BY a.name
HAVING SUM(o.total_amt_usd)<1000
3 rows

6.
SELECT a.name,SUM(o.total_amt_usd) sum_usd
FROM accounts a
JOIN orders o
ON o.account_id=a.id
GROUP BY a.name
ORDER BY sum_usd DESC
LIMIT 1

7.
SELECT a.name,SUM(o.total_amt_usd) sum_usd
FROM accounts a
JOIN orders o
ON o.account_id=a.id
GROUP BY a.name
ORDER BY sum_usd
LIMIT 1

8.
SELECT a.name,COUNT(w.*)
FROM web_events w
JOIN accounts a
ON a.id=w.account_id
WHERE w.channel='facebook'
GROUP BY a.name
HAVING  COUNT(w.*)>6
ORDER BY count
46 rows

9.
SELECT a.name,COUNT(w.*)
FROM web_events w
JOIN accounts a
ON a.id=w.account_id
WHERE w.channel='facebook'
GROUP BY a.name
HAVING  COUNT(w.*)>6
ORDER BY count DESC
LIMIT 1

10.
SELECT channel,COUNT(name) c_name
FROM (SELECT DISTINCT w.channel,a.name
	  FROM web_events w
  	  JOIN accounts a
	  ON a.id=w.account_id) dist
GROUP BY channel
ORDER BY c_name DESC
LIMIT 1

SELECT SUM(use_of_channel)
FROM (SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10) a

#27.
SELECT SUM(total_amt_usd) total,DATE_TRUNC('year',occurred_at) d
FROM  orders
GROUP BY d
ORDER BY d DESC

SELECT  SUM(total_amt_usd) total,DATE_TRUNC('month',occurred_at) d
FROM orders
GROUP BY d
ORDER BY total DESC
LIMIT 1

SELECT  COUNT(*) total,DATE_TRUNC('year',occurred_at) d
FROM orders
GROUP BY d
ORDER BY total DESC
LIMIT 1

SELECT  COUNT(total) total,DATE_TRUNC('month',occurred_at) d
FROM orders
GROUP BY d
ORDER BY total DESC
LIMIT 1

SELECT DATE_PART('month',occurred_at) m,DATE_PART('year',occurred_at) y,SUM(gloss_amt_usd) gloss_sum
FROM orders o
JOIN accounts a
ON o.account_id=a.id
WHERE a.name='Walmart'
GROUP BY m,y
ORDER BY gloss_sum DESC
38 rows

#31.
1
SELECT a.id,o.total total_order,CASE WHEN o.total>=3000 THEN 'Large'
                                     ELSE 'Small' END AS amount
FROM orders o
JOIN accounts a
ON a.id=o.account_id
6912 rows

2
SELECT COUNT(total),number_of_orders
FROM (SELECT total,CASE WHEN total>=2000 THEN 'At least 2000'
                  WHEN total>=1000 AND total<2000 THEN 'Between 2000 and 1000'
                  ELSE 'Less than 1000' END AS number_of_orders
FROM orders) a
GROUP BY 2
ORDER BY 1

3
SELECT name,total_sales,CASE WHEN total_sales>200000 THEN 'greater than 200,000'
                             WHEN total_sales>=100000 AND total_sales<200000 THEN '200,000 and 100,000'
                             ELSE 'under 100000' END AS level_of_account
FROM (SELECT a.name,SUM(o.total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id=o.account_id
GROUP BY 1) p
ORDER BY 2 DESC
350 rows

4
SELECT name,total_sales,CASE WHEN total_sales>200000 THEN 'greater than 200,000'
                             WHEN total_sales>=100000 AND total_sales<200000 THEN '200,000 and 100,000'
                             ELSE 'under 100000' END AS level_of_account
FROM (SELECT a.name,SUM(o.total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id=o.account_id
WHERE o.occurred_at BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY 1) p
ORDER BY 2 DESC
322 rows

5
SELECT name,total_order,CASE WHEN total_order>200 THEN 'top'
                          ELSE 'not top' END AS top
FROM (SELECT s.name,COUNT(o.total) total_order
      FROM sales_reps s
      JOIN accounts a
      ON s.id=a.sales_rep_id
      JOIN orders o
      ON a.id=o.account_id
      GROUP BY s.name) p
ORDER BY total_order DESC
50 rows

6
SELECT name,total_order,total_amt,CASE WHEN total_order>200 OR total_amt>750000 THEN 'top'
                                       WHEN (total_order>150 AND total_order<=200) OR (total_amt<=750000 AND total_amt>500000) THEN 'middle'
                                       ELSE 'low' END AS level_sales_rep
FROM (SELECT s.name,COUNT(o.total) total_order,SUM(o.total_amt_usd) total_amt
      FROM sales_reps s
      JOIN accounts a
      ON s.id=a.sales_rep_id
      JOIN orders o
      ON a.id=o.account_id
      GROUP BY s.name) p
ORDER BY total_order DESC,total_amt DESC
