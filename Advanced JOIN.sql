#One way to make a query run faster is to reduce the number of calculations that need to be performed.
Some of the high-level things that will affect the number of calculations a given query will make include:
1.Table size,2.Joins,3.Aggregations
Query runtime is also dependent on some things that you can’t really control related to the database itself:
Other users running queries concurrently on the database
Database software and optimization (e.g., Postgres is optimized differently than Redshift)

#UNION removes duplicate records (where all columns in the results are the same), UNION ALL does not.

#3.
SELECT a.name account_name,s.name sales_name
FROM accounts a
FULL OUTER JOIN sales_reps s
ON a.sales_rep_id=s.id
WHERE a.name IS NULL OR s.name IS NULL

#6.
SELECT a.name account_name,s.name sales_name,a.primary_poc
FROM accounts a
LEFT JOIN sales_reps s
ON a.sales_rep_id=s.id AND a.primary_poc < s.name

#9.
SELECT we1.id AS we1_id,
       we1.account_id AS we1_account_id,
       we1.occurred_at AS we1_occurred_at,
       we1.channel AS we1_channel,
       we2.id AS we2_id,
       we2.account_id AS we2_account_id,
       we2.occurred_at AS we2_occurred_at,
       we2.channel AS we2_channel
FROM web_events we1
LEFT JOIN web_events we2
ON we1.account_id = we2.account_id
AND we1.occurred_at > we2.occurred_at
AND we1.occurred_at <= we2.occurred_at + INTERVAL '1 day'
ORDER BY we1.account_id, we2.occurred_at

#12.
SELECT *
FROM accounts
UNION ALL
SELECT *
FROM accounts

SELECT *
FROM accounts
WHERE name='Walmart'
UNION ALL
SELECT *
FROM accounts
WHERE name='Disney'

WITH double_accounts AS (SELECT *
FROM accounts
UNION ALL
SELECT *
FROM accounts)
SELECT COUNT(name),name
FROM double_accounts
GROUP BY 2
