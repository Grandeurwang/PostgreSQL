##### example
SELECT web_events.*,accounts.name,accounts.primary_poc
FROM accounts
JOIN web_events
ON web_events.account_id=accounts.id
WHERE accounts.name='Walmart'

#####QUIZ
#4.
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

SELECT orders.standard_qty, orders.gloss_qty,  orders.poster_qty,accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

#11.
SELECT web_events.*,accounts.name,accounts.primary_poc
FROM accounts
JOIN web_events
ON web_events.account_id=accounts.id
WHERE accounts.name='Walmart'

SELECT r.name AS region_name,s.name AS sale_name,a.name AS account_name
FROM sales_reps s
JOIN region r
ON r.id=s.region_id
JOIN accounts a
ON a.sales_rep_id=s.id

SELECT r.name AS region, a.name AS account,(o.total_amt_usd/(o.total+0.01)) AS unit_price
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id=s.id
JOIN region r
ON r.id=s.region_id
JOIN orders o
ON o.account_id=a.id

#19.
#1
SELECT r.name region,s.name sales_rep,a.name account
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
JOIN accounts a
ON a.sales_rep_id=s.id
WHERE r.name='Midwest'
48 rows

#2
SELECT r.name region,s.name sales_rep,a.name account
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
JOIN accounts a
ON a.sales_rep_id=s.id
WHERE r.name='Midwest' AND s.name LIKE 'S%'
ORDER BY a.name
5 rows

#3
SELECT r.name region,s.name sales_rep,a.name account
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
JOIN accounts a
ON a.sales_rep_id=s.id
WHERE r.name='Midwest' AND s.name LIKE '%K%' AND s.name NOT LIKE 'K%'
ORDER BY a.name
13 rows

#4
SELECT r.name region,a.name account,((o.total_amt_usd/o.total+0.01)) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
JOIN accounts a
ON a.sales_rep_id=s.id
JOIN orders o
ON o.account_id=a.id
WHERE o.standard_qty>100
4509 rows

#5
SELECT r.name region,a.name account,((o.total_amt_usd/o.total+0.01)) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
JOIN accounts a
ON a.sales_rep_id=s.id
JOIN orders o
ON o.account_id=a.id
WHERE o.standard_qty>100 AND o.poster_qty>50
ORDER BY unit_price
835 rows

#6
SELECT r.name region,a.name account,((o.total_amt_usd/o.total+0.01)) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
JOIN accounts a
ON a.sales_rep_id=s.id
JOIN orders o
ON o.account_id=a.id
WHERE o.standard_qty>100 AND o.poster_qty>50
ORDER BY unit_price DESC
835 rows

#7
SELECT DISTINCT a.name account,w.channel channel
FROM accounts a
JOIN web_events w
ON w.account_id=a.id
WHERE w.account_id=1001
6 rows

#8
SELECT o.occurred_at, a.name account, o.total order_total,  o.total_amt_usd
FROM orders o
JOIN accounts a
ON  a.id=o.account_id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
1725 rows
