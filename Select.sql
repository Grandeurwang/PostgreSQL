### The order of key words
EXPLAIN(used when you wanna see the order how queries are executed)
SELECT col1, col2
FROM table1
JOIN web_events
ON web_events.account_id=accounts.id
WHERE col3  > 5 AND col4 LIKE '%os%'
WINDOW alias AS (PARTITION BY ... ORDER BY...)
GROUP BY
HAVING
ORDER BY col5
LIMIT 10;

##### Expert tips:If you recall from earlier lessons on joins,
      the join clause is evaluated before the where clause:
      filtering in the join clause will eliminate rows before they are joined,
      while filtering in the WHERE clause will leave those rows in and produce some nulls.
##### String comparison: https://stackoverflow.com/questions/26080187/sql-string-comparison-greater-than-and-less-than-operators/26080240#26080240

#####QUIZ
#16.
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15

#19.
SELECT id, occurred_at,  total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10

SELECT id, account_id,  total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5

SELECT id, account_id,  total
FROM orders
ORDER BY total
LIMIT 20

#22.
SELECT id, account_id,total
FROM orders
ORDER BY account_id,total DESC

SELECT id, account_id,total
FROM orders
ORDER BY total DESC, account_id

#25.
SELECT *
FROM orders
WHERE gloss_amt_usd>=1000
LIMIT 5

SELECT *
FROM orders
WHERE total_amt_usd<500
LIMIT 10

#28.
SELECT name, website,primary_poc
FROM accounts
WHERE name='Exxon Mobil'

#31.
SELECT id,account_id,standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10

SELECT id,account_id,(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10

#35.
SELECT *
FROM accounts
WHERE name LIKE 'C%'

SELECT *
FROM accounts
WHERE name LIKE '%one%'

SELECT *
FROM accounts
WHERE name LIKE '%s'

#38.
SELECT name, primary_poc,  sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')

#41.
SELECT name, primary_poc,  sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom')

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords')

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%'

SELECT *
FROM accounts
WHERE name NOT LIKE '%one%'

SELECT *
FROM accounts
WHERE name NOT LIKE '%s'

#44.
SELECT *
FROM orders
WHERE standard_qty>1000 AND poster_qty=0 AND gloss_qty=0

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name  LIKE '%s'

SELECT occurred_at,gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC

#47.
SELECT id
FROM orders
WHERE gloss_qty>4000 OR poster_qty>4000

SELECT *
FROM orders
WHERE standard_qty=0 AND (gloss_qty>1000 OR poster_qty>1000)

SELECT name
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND ((primary_poc LIKE 'ana' OR primary_poc LIKE 'Ana' )AND primary_poc NOT LIKE 'eana')
